extends Control

var current_options: Array = []
var player_progression: PlayerProgression

@onready var button1 = $Panel/VBoxContainer/Button1  # Replace with your actual button paths
@onready var button2 = $Panel/VBoxContainer/Button2
@onready var button3 = $Panel/VBoxContainer/Button3

func _ready():
	add_to_group("levelupui")
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func show_upgrade_choices(options: Array):
	print("🎯 LevelUpUI: show_upgrade_choices called")
	print("📋 Received options: ", options)
	print("📋 Options count: ", options.size())
	
	if options.size() < 3:
		print("❌ ERROR: Not enough options received!")
		return
		
	current_options = options
	visible = true
	print("👁️ UI made visible")
	
	# Check if buttons exist
	if not button1:
		print("❌ ERROR: button1 is null!")
		return
	if not button2:
		print("❌ ERROR: button2 is null!")  
		return
	if not button3:
		print("❌ ERROR: button3 is null!")
		return
		
	print("✅ All buttons found, updating text...")
	button1.text = options[0].title + "\n" + options[0].description
	button2.text = options[1].title + "\n" + options[1].description  
	button3.text = options[2].title + "\n" + options[2].description
	print("✅ Button texts updated successfully")
	
func _on_button_1_pressed():
	_choose_upgrade(0)
	
func _on_button_2_pressed():
	_choose_upgrade(1)
	
func _on_button_3_pressed():
	_choose_upgrade(2)

func _choose_upgrade(index: int):
	print("🎯 LevelUpUI: Button ", index, " pressed!")
	print("🎯 Selected upgrade: ", current_options[index])
	var player = get_tree().get_first_node_in_group("player")
	if player and player.progression_component:
		print("🎯 Calling apply_upgrade on progression component...")
		player.progression_component.apply_upgrade(current_options[index])
	else:
		print("❌ ERROR: Player or progression component not found!")
	visible = false

func _on_damage_button_pressed():
	var player = get_tree().get_first_node_in_group("player")
	if player and player.progression_component:
		player.progression_component.apply_stat_choice("damage")
	visible = false
	get_tree().paused = false

func _on_speed_button_pressed():
	var player = get_tree().get_first_node_in_group("player")
	if player and player.progression_component:
		player.progression_component.apply_stat_choice("speed")
	visible = false
	get_tree().paused = false

func _on_attack_speed_button_pressed():
	var player = get_tree().get_first_node_in_group("player")
	if player and player.progression_component:
		player.progression_component.apply_stat_choice("attack_speed")
	visible = false
	get_tree().paused = false

func show_level_up_ui():
	visible = true
	button1.text = "💪 Damage +5"
	button2.text = "💨 Speed +1.0"
	button3.text = "⚡ Attack Speed"
