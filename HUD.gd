extends "res://Scripts/HUD.gd"


@onready var medical_elements : BoxContainer = $Stats / Medical / Elements
@onready var vitals_elements : BoxContainer = $Stats / Vitals / Elements

const vitals_icons = {"Health": "Icon_Health", "Energy": "Icon_Energy", "Hydration": "Icon_Hydration",
					"Mental": "Icon_Mental", "Temperature": "Icon_Temperature"}


func _ready() -> void:
	super()

	medical_elements.alignment = BoxContainer.ALIGNMENT_END
	
	for vital in vitals_icons.keys():
		var vital_node = vitals_elements.find_child(vital)
		var icon = TextureRect.new()
		icon.name = "Icon"
		icon.texture = load("res://UI/Sprites/%s.png" % vitals_icons[vital_node.name])
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.custom_minimum_size = Vector2(32, 32)
		icon.size = Vector2(40, 40)
		icon.position = Vector2(-20, 0)
		var shader_material = ShaderMaterial.new()
		shader_material.shader = load("res://mods/BetterHUDVitals/Vitals.gdshader")
		icon.material = shader_material
		vital_node.add_child(icon)
		var header = vital_node.find_child("Header")
		header.visible = false
		var value = vital_node.find_child("Value")
		value.visible = false


func _physics_process(delta: float) -> void:
	super(delta)

	if Engine.get_physics_frames() % 10 == 0:
		var statuses = [gameData.overweight, gameData.starvation, gameData.dehydration,
						gameData.bleeding, gameData.fracture, gameData.burn,
						gameData.frostbite, gameData.insanity, gameData.poisoning,
						gameData.rupture, gameData.headshot]

		var children : Array[Node] = medical_elements.find_children("*", "TextureRect")
		for child in children:
			if child.get_script().resource_path == "res://Scripts/Condition.gd":
				if statuses[child.type]:
					child.visible = true
				else:
					child.visible = false

	if Engine.get_physics_frames() % 20 == 0 && !gameData.isTransitioning:
		for vital in vitals_icons.keys():
			var vital_node = vitals_elements.find_child(vital)
			var icon = vital_node.find_child("Icon", false, false)
			var value = vital_node.find_child("Value")
			icon.modulate = value.modulate
			icon.material.set_shader_parameter("value", float(value.text)/100.0)
