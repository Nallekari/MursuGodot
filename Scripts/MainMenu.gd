extends Control


func _ready():
	pass # Replace with function body.




func _on_Play_pressed():
	get_tree().change_scene("res://Levels/SavannaLevel.tscn")


func _on_Exit_pressed():
	get_tree().quit()
