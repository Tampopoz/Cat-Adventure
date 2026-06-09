extends Node

func _ready():
   var global_music = get_node("/root/music_1") 
   var scene_music = %MUSIC_2
   
   var tween = create_tween()
   tween.tween_property(global_music, "volume_db", -60.0, 3.0)
   
   scene_music.volume_db = -60.0 
   scene_music.play()
   var tween2 = create_tween()
   tween2.tween_property(scene_music, "volume_db", -10.0, 3.0)
