extends Area2D

func _ready ():
	body_entered.connect(func (body):
		if body is Player:
			ALGlobal.AdvanceLevel()
			ALGlobal.GetDeathSound().play()
	)
