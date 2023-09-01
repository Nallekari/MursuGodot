extends Node2D


onready var start_area = $Start

onready var player = $Mursu

var last_checkpoint = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#var playerGroup = get_tree().get_nodes_in_group("Player")
	#player = playerGroup[0]
	var checkpoints = get_tree().get_nodes_in_group("checkpoint")
	for checkpoint in checkpoints:
		checkpoint.connect("touched_player", self, "_on_checkpoint_touched_player")

	if player != null:
		player.global_position = start_area.global_position
		last_checkpoint = start_area.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_checkpoint_touched_player(position):
	print("checkpoint touched player")
	
	print(position)
	last_checkpoint = position
	print(last_checkpoint)
	

func _on_DeathSpike_body_entered(body):
	respawn_player()

func respawn_player():
	player.velocity = Vector2.ZERO
	player.global_position = last_checkpoint
