extends AnimationPlayer

class_name CutscenePlayer

signal cutscene_finished

var current_cutscene: String = ""

func _ready():
	# Connect the animation_finished signal to our custom method
	connect("animation_finished", Callable(self, "_on_animation_finished"))

func play_cutscene(cutscene_name: String):
	if has_animation(cutscene_name):
		current_cutscene = cutscene_name
		play(cutscene_name)
	else:
		push_error("Cutscene '%s' not found!" % cutscene_name)

func load_cutscene(cutscene_name: String, animation_resource: Animation):
	if not has_animation(cutscene_name):
		get_animation_library("").add_animation(cutscene_name, animation_resource)
		print("Cutscene '%s' loaded successfully." % cutscene_name)
	else:
		push_warning("Cutscene '%s' already exists. Use a different name or remove it first." % cutscene_name)

func stop_cutscene():
	if is_playing():
		stop()
		current_cutscene = ""
		print("Cutscene stopped.")
	else:
		print("No cutscene is currently playing.")

func _on_animation_finished(anim_name: String):
	if anim_name == current_cutscene:
		current_cutscene = ""
		emit_signal("cutscene_finished")

# Optional: Method to remove a cutscene
func remove_cutscene(cutscene_name: String):
	if has_animation(cutscene_name):
		get_animation_library("").remove_animation(cutscene_name)
		print("Cutscene '%s' removed." % cutscene_name)
	else:
		push_warning("Cutscene '%s' not found." % cutscene_name)

# Optional: Method to get all loaded cutscene names
func get_loaded_cutscenes() -> Array:
	return get_animation_list()
