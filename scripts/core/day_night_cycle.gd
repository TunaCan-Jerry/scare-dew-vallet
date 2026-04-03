extends Node

## Manages the visual and gameplay transitions between phases.

const DUSK_DURATION := 5.0
const DAWN_DURATION := 5.0

var game_state: Node
var _transition_timer: float = 0.0

func _ready() -> void:
	game_state = get_node("/root/GameState")
	game_state.phase_changed.connect(_on_phase_changed)

func _on_phase_changed(phase: int) -> void:
	match phase:
		0:  # DUSK
			pass
		1:  # Phase.DUSK
			_transition_timer = DUSK_DURATION
		3:  # Phase.DAWN
			_transition_timer = DAWN_DURATION

func _process(delta: float) -> void:
	if game_state.current_phase == 1:  # DUSK
		_transition_timer -= delta
		if _transition_timer <= 0.0:
			game_state.start_night()
	elif game_state.current_phase == 3:  # DAWN
		_transition_timer -= delta
		if _transition_timer <= 0.0:
			game_state.advance_to_next_day()
