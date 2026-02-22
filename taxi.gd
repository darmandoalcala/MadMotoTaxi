extends VehicleBody3D

var enginePower = 300.0
var steeringAngle = 0.6

@onready var backWheelLeft = $BackWheelLeft
@onready var backWheelRight = $BackWheelRight

var NormalGrip = 10.5 # Fricción por defecto 
var driftGrip = 2.0 # Fricción baja 

#Main Funct
func _physics_process(delta):
	
	# Dirección
	var turn = Input.get_axis("ui_right", "ui_left")
	steering = turn * steeringAngle

	# Aceleración
	var acceleration = Input.get_axis("ui_up", "ui_down")
	engine_force = acceleration * enginePower

	# DERRAPE 
	# "ui_accept" es la barra espaciadora (o el botón A en un control)
	if Input.is_action_pressed("ui_accept") and abs(turn) > 0.1:
		
		# 1. Quitamos el agarre de las llantas traseras
		backWheelLeft.wheel_friction_slip = driftGrip
		backWheelRight.wheel_friction_slip = driftGrip
		brake = 5.0
		
	else:
		backWheelLeft.wheel_friction_slip = NormalGrip
		backWheelRight.wheel_friction_slip = NormalGrip
		brake = 0.0
