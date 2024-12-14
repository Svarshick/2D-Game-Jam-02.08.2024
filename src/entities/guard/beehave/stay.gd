extends ActionLeaf


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var checkpoint = actor.checkpoints.current()
	checkpoint.timer.start()
	listen_checkpoint_timeout(blackboard, checkpoint, true)


func tick(actor: Node, blackboard: Blackboard) -> int:
	var c = actor.checkpoints.current()
	print("time: " + str(c.timer.time_left))
	if blackboard.get_value("checkpoint timer timeout"):
		blackboard.set_value("checkpoint timer timeout", false)
		var checkpoint = actor.checkpoints.current()
		listen_checkpoint_timeout(blackboard, checkpoint, false)
		return FAILURE
	return RUNNING


func listen_checkpoint_timeout(blackboard: Blackboard, checkpoint: Checkpoint, doListen: bool) -> void:
	if doListen:
		checkpoint.timer.timeout.connect(on_checkpoint_timeout.bind(blackboard))
	else:
		checkpoint.timer.timeout.disconnect(on_checkpoint_timeout.bind(blackboard))


func on_checkpoint_timeout(blackboard: Blackboard):
	print("DA!!")
	blackboard.set_value("checkpoint timer timeout", true)
