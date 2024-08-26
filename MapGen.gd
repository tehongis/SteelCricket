extends TileMapLayer

var upart = FastNoiseLite.new()
var vpart = FastNoiseLite.new()

var width = 128
var height = 64

@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	upart.seed= randi()
	vpart.seed= randi()

func _process(_delta: float) -> void:
	generate_chunk(player.position)

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var u = 17+round(upart.get_noise_2d(tile_pos.x + x - width/2, tile_pos.y + y - height/2)*2)
			var v = round(vpart.get_noise_2d(tile_pos.x + x - width/2, tile_pos.y + y - height/2)*2)
			set_cell(Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y),0,Vector2i(u,v))
			#set_cell(Vector2i(tile_pos.x + x - width/2, tile_pos.y + y - height/2),0,Vector2i(0,0))
		
	
