extends TileMapLayer

var noise = FastNoiseLite.new()
#var upart = FastNoiseLite.new()
#var vpart = FastNoiseLite.new()

var width = 128
var height = 64

@onready var player = get_tree().get_root().get_node("Main/Player/Player")

func _ready() -> void:
	noise.seed= 3
	#upart.seed= randi()
	#vpart.seed= randi()

func _process(_delta: float) -> void:
	generate_chunk(player.position)

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var tileid = abs( round( 2*noise.get_noise_2d(tile_pos.x + x - width/2, tile_pos.y + y - height/2) ) )
			#print(tileid)
			#var u = 17+round(upart.get_noise_2d(tile_pos.x + x - width/2, tile_pos.y + y - height/2)*2)
			#var v = round(vpart.get_noise_2d(tile_pos.x + x - width/2, tile_pos.y + y - height/2)*2)
			if tileid == 1:
				set_cell(Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y),0,Vector2i(2,6))
				#set_cells_terrain_connect(layer: int, cells: Array[Vector2i], terrain_set: int, terrain: int, ignore_empty_terrains: bool = true)
			#else:
			#	set_cell(Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y),0,Vector2i(13,3))

			#set_cell(Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y),0,Vector2i(u,v))
			#set_cell(Vector2i(tile_pos.x + x - width/2, tile_pos.y + y - height/2),0,Vector2i(0,0))
		
	
