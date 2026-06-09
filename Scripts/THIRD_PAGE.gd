extends Node

var current_music = null

func _ready():
 var global_music = get_node("/root/music_1")
 
 var scene_music = load("res://Scenes/Music/music_3.tscn").instantiate()
 add_child(scene_music)
 
 var tween = create_tween()
 tween.tween_property(global_music, "volume_db", -60.0, 3.0)
 
 scene_music.volume_db = -60.0 
 scene_music.play()
 
 var tween2 = create_tween()
 tween2.tween_property(scene_music, "volume_db", -10.0, 3.0)
 
 self.current_music = scene_music
 
 scene_music.tree_exited.connect(func(): print("Music node removed"))

func stop_music():
 if current_music:
   current_music.stop()
   
func resume_music():
 if current_music:
   current_music.play()

func _exit_tree():
 if current_music:
   current_music.queue_free()
