@tool
extends AtlasTexture

class_name TextureFrame

@export_range(1, 10000)
var tiles_width : int = 1 :
	set(v):
		tiles_width = v
		
		if atlas != null:
			_tile_size = atlas.get_size() / Vector2(tiles_width, tiles_height)
		_update_region()


@export_range(1, 10000)
var tiles_height : int = 1 :
	set(v):
		tiles_height = v
		if atlas != null:
			_tile_size = atlas.get_size() / Vector2(tiles_width, tiles_height)
		
		_update_region()


@export_range(0, 10000)
var current_frame_x : int = 0 :
	set(v):
		if v < tiles_width:
			_current_frame_x = v
			_recalc_crossing_frame()
			_update_region()
	get:
		return _current_frame_x



@export_range(0, 10000)
var current_frame_y : int = 0 :
	set(v):
		if v < tiles_height:
			_current_frame_y = v
			_recalc_crossing_frame()
			_update_region()
	get:
		return _current_frame_y



@export_range(0, 10000000000)
var crossing_frame : int = 0 :
	set(v):
		_crossing_frame = v % (tiles_width*tiles_height)
		
		_current_frame_x = _crossing_frame % tiles_width
		@warning_ignore("integer_division")
		_current_frame_y = _crossing_frame / tiles_width
		
		_update_region()
	get:
		return _crossing_frame


var _tile_size : Vector2 = Vector2.ZERO
var _crossing_frame : int = 0
var _current_frame_y : int = 0
var _current_frame_x : int = 0


func _update_region() -> void:
	region = Rect2(_tile_size*Vector2(_current_frame_x, _current_frame_y), _tile_size)


func _recalc_crossing_frame() -> void:
	_crossing_frame = _current_frame_x + _current_frame_y*tiles_width
