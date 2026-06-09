extends Node

func _ready():
   var global_music = get_node("/root/music_1")

   global_music.volume_db = 0
