import os
import re

def resolve_links(file_path, base_dir, processed_files):
    """Рекурсивно разворачивает ссылки в файле."""
    if file_path in processed_files:
        return f"<!-- Ссылка на {file_path} уже обработана -->\n"
    
    processed_files.add(file_path)
    content = []
    
    with open(file_path, 'r', encoding='utf-8') as file:
        for line in file:
            # Обрабатываем ссылки в формате [[file_name]]
            match = re.findall(r'\[\[([\w\-/]+)\]\]', line)
            if match:
                for link in match:
                    # Определяем путь к связанному файлу
                    linked_file = os.path.join(base_dir, f"{link}.md")
                    if os.path.exists(linked_file):
                        content.append(f"<!-- Начало содержимого {linked_file} -->\n")
                        content.append(resolve_links(linked_file, base_dir, processed_files))
                        content.append(f"<!-- Конец содержимого {linked_file} -->\n")
                    else:
                        content.append(f"<!-- Файл {linked_file} не найден -->\n")
            else:
                content.append(line)
    
    return ''.join(content)

def merge_markdown_files(main_file, output_file):
    """Объединяет Markdown файлы, разворачивая ссылки."""
    base_dir = os.path.dirname(main_file)
    processed_files = set()
    merged_content = resolve_links(main_file, base_dir, processed_files)
    
    with open(output_file, 'w', encoding='utf-8') as output:
        output.write(merged_content)

# Задайте путь к основному файлу и выходному файлу
main_md_file = "GDD.md"  # Замените на ваш основной файл
output_md_file = "merged.md"

merge_markdown_files(main_md_file, output_md_file)
print(f"Файл объединён: {output_md_file}")

