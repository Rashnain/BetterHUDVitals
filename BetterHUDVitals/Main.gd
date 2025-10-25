extends Node


func _ready() -> void:
	overrideScript("res://mods/BetterHUDVitals/HUD.gd")
	queue_free()


func overrideScript(overrideScriptPath : String) -> void:
	var script : Script = load(overrideScriptPath)
	script.reload()
	var parentScript : Script = script.get_base_script();
	script.take_over_path(parentScript.resource_path)
