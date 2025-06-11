# Static class for rithmatic line definitions
class_name RithmaticLines

enum Types {
	WARDING,
	FORBIDDANCE,
	VIGOR,
	REVOCATION
}

static func type_name(line_type: int) -> StringName:
	match line_type:
		Types.WARDING: return &"warding"
		Types.FORBIDDANCE: return &"forbiddance"
		Types.VIGOR: return &"vigor"
		Types.REVOCATION: return &"revocation"
		_:
			push_error("called type_name on invalid line type")
			return &"invalid"

# Used for render and damage bucketing
const NUM_WARDING_SEGMENTS : int = 32

const VIGOR_DEFAULT_BEAM_WIDTH : float = 20
const NUM_VIGOR_SEGMENTS : int = 32 # used as long as Vigor represented as Line2D
