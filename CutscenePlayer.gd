extends Node
# Assuming you have a CutscenePlayer node named "CutscenePlayer" in your scene
@onready var cutscene_player = $Timeline

@onready var cutsz : Animation = preload("res://cutscenes/main_cutscene.tres")

func _ready():
	# Load a cutscene
	var new_animation = Animation.new()
	# ... set up your animation here ...
	cutscene_player.load_cutscene("main_cutscene", cutsz)

	# Play a cutscene
	cutscene_player.play_cutscene("main_cutscene")

	# Connect to the cutscene_finished signal
	cutscene_player.connect("cutscene_finished", Callable(self, "_on_cutscene_finished"))

func _on_cutscene_finished():
	print("Cutscene finished!")

# To stop the cutscene
func _on_stop_button_pressed():
	cutscene_player.stop_cutscene()
