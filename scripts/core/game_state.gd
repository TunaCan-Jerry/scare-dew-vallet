extends Node

enum Phase { DAY, DUSK, NIGHT, DAWN }

signal phase_changed(new_phase: int)
signal day_time_updated(time_remaining: float)
signal day_count_changed(day: int)

var current_phase: int = Phase.DAY
var current_day: int = 1
var day_time_remaining: float = 0.0
var day_duration: float = 180.0  # 3 minutes per day

var _paused: bool = false

func start_day() -> void:
	current_phase = Phase.DAY
	day_time_remaining = day_duration
	phase_changed.emit(Phase.DAY)

func start_dusk() -> void:
	current_phase = Phase.DUSK
	phase_changed.emit(Phase.DUSK)

func start_night() -> void:
	current_phase = Phase.NIGHT
	phase_changed.emit(Phase.NIGHT)

func start_dawn() -> void:
	current_phase = Phase.DAWN
	phase_changed.emit(Phase.DAWN)

func advance_to_next_day() -> void:
	current_day += 1
	day_count_changed.emit(current_day)
	start_day()

func end_day_early() -> void:
	if current_phase == Phase.DAY:
		day_time_remaining = 0.0

func _process(delta: float) -> void:
	if _paused:
		return
	if current_phase == Phase.DAY:
		day_time_remaining -= delta
		day_time_updated.emit(day_time_remaining)
		if day_time_remaining <= 0.0:
			start_dusk()
