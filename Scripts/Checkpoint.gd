extends Area2D


signal touched_player(checkpoint_position)

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("touched_player", global_position)
