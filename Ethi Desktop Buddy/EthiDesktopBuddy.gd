# All written in GDScript, in the Godot game engine 

extends Node2D

var speed = 100
var direction = Vector2(1, 0)
var screen_size = Vector2()
var window_size = Vector2(200, 200)
var is_dragging = false
var drag_offset = Vector2()
var idle_timer = 0.0
var is_idling = false
var is_talking = false
var textbox_timer = 0.0
var phrases: Array[String] = ["I love you, Syli!", "Hello, my beloved!", 
"My amplifier is my heart, and you have my heart.", "Thank you for existing.", 
"I’m so glad I’m able to create a safe space for you", "I love being able to do the thing that I love to make my love happy", 
"♪My ebony baby, with a heart like ivory♪"]
var time := 0.0
var duration := 1.0

@onready var sprite = $Character2D
@onready var area = $CharacterSpace2D

func _ready():
	screen_size = Vector2(DisplayServer.screen_get_size())
	area.input_event.connect(_on_area_input)
	_pick_new_direction()


func _physics_process(delta):
	if is_dragging:
		var mouse_pos = Vector2(DisplayServer.mouse_get_position())
		var new_win_pos = mouse_pos - drag_offset
		DisplayServer.window_set_position(Vector2i(new_win_pos))
		sprite.play("pick_up")
		return

	if is_idling:
		idle_timer -= delta
		if idle_timer <= 0:
			is_idling = false
			_pick_new_direction()
		return

	if is_talking:
		textbox_timer -= delta
		if textbox_timer <= 0:
			is_talking = false
		return

	var win_pos = Vector2(DisplayServer.window_get_position())
	win_pos += direction * speed * delta
	win_pos.x = clamp(win_pos.x, 0, screen_size.x - window_size.x)
	win_pos.y = clamp(win_pos.y, 0, screen_size.y - window_size.y)
	DisplayServer.window_set_position(Vector2i(win_pos))
	_update_animation(win_pos)

	if win_pos.x <= 0 or win_pos.x >= screen_size.x - window_size.x:
		direction.x *= -1
		_maybe_idle()
	if win_pos.y <= 0 or win_pos.y >= screen_size.y - window_size.y:
		direction.y *= -1
		_maybe_idle()

func _update_animation(win_pos):
	var on_bottom = win_pos.y >= screen_size.y - window_size.y - 2
	var on_top = win_pos.y <= 2
	var on_left = win_pos.x <= 2
	var on_right = win_pos.x >= screen_size.x - window_size.x - 2

	if on_bottom:
		if direction.x > 0:
			sprite.play("walk_right")
		else:
			sprite.play("walk_left")
	elif on_top:
		if direction.x > 0:
			sprite.play("crawl_top_right")
		else:
			sprite.play("crawl_top_left")
	elif on_left:
		if direction.y > 0:
			sprite.play("crawl_left_down")
		else:
			sprite.play("crawl_left_up")
	elif on_right:
		if direction.y > 0:
			sprite.play("crawl_right_down")
		else:
			sprite.play("crawl_right_up")

func _maybe_idle():
	if randf() < 0.3:
		is_idling = true
		idle_timer = randf_range(1.0, 3.0)
		var r = randi() % 3
		if r == 0:
			sprite.play("idle")
			talk(phrases.pick_random())
		elif r == 1:
			sprite.play("crouch")
			talk(phrases.pick_random())
		else:
			sprite.play("splat")
			talk(phrases.pick_random())


func _pick_new_direction():
	var angle = randf() * TAU
	direction = Vector2(cos(angle), sin(angle)).normalized()

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			var mouse_pos = Vector2(DisplayServer.mouse_get_position())
			var win_pos = Vector2(DisplayServer.window_get_position())
			drag_offset = mouse_pos - win_pos
		else:
			is_dragging = false
			_pick_new_direction()

func talk(text:String) -> void:
	$Chatbox.show()
	%Textbox.text = text
	await get_tree().create_timer(5).timeout
	$Chatbox.hide()
