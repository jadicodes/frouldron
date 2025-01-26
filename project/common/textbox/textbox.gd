extends CanvasLayer

signal finished_current_text
signal finished_all_text

const CHAR_READ_RATE = 0.03

enum state {
	READY,
	READING,
	FINISHED
}

var current_state = state.READY
var _queue: int
var _tween
var current_queue_index: int = 0

@onready var _textbox = %TextboxContainer
@onready var _text = %Label


# Manages player input

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		if current_state == state.FINISHED:
			_change_state(state.READY)
			current_queue_index += 1
			if current_queue_index <= _queue - 1:
				finished_current_text.emit()
			else:
				finished_all_text.emit()
				reset_queue_index()

		elif current_state == state.READING:
			_change_state(state.FINISHED)


# Setters

func set_queue(total_strings):
	_queue = total_strings


func set_text(text) -> void:
	_text.text = text
	show_textbox()
	_tween = create_tween()
	_tween.tween_property(_text, "visible_ratio", 1.0, len(text) * CHAR_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	_tween.connect("finished", _on_tween_finished)
	_change_state(state.READING)


# Getters

func get_queue_index() -> int:
	return current_queue_index


# Set index to 0

func reset_queue_index() -> void:
	current_queue_index = 0


# Show and hide textbox

func show_textbox() -> void:
	_textbox.show()


func hide_textbox() -> void:
	_text.visible_ratio = 0.0
	_textbox.hide()


# Manages state of the textbox 

func _change_state(new_state) -> void: 
	current_state = new_state
	match current_state:
		state.READY:
			_text.visible_ratio = 0.0
		state.READING:
			_tween.play()
		state.FINISHED:
			_text.visible_ratio = 1.0
			_tween.pause()


# Manages signal received from tween finishing

func _on_tween_finished() -> void:
	_change_state(state.FINISHED)
