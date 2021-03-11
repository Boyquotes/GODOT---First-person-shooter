extends Label


func _ready():
	pass
	
func _process(delta):
	self.set_text("FPS : " + str(Engine.get_frames_per_second()))
