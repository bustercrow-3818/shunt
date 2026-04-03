extends Node



const knockback_constant: float = 75.0

const gravity: float = 12.5
const terminal_velocity: float = 1000

const death_fade_time: float = 3.0

const coyote_time: float = 0.15

const bullet_offscreen_life: float = 0.2



static func coin_flip() -> int:
	return [-1, 1].pick_random()
