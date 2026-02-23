extends Area3D
var taxi_inside = false
var node_taxi = null
@export var destination_scene: PackedScene
@export var dropoff_position: Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node3D) -> void:
	#Check if taxi is the object inside
	if body.name == "taxi":
		taxi_inside = true
		node_taxi = body
		print("Frena para recoger al pasajero!")
		
func _on_body_exited(body: Node3D) -> void:
	if body.name == "taxi":
		taxi_inside = false
		node_taxi = null
		print("Saliste de la Zona del pasajero")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# If the taxi is inside check the speed
	if taxi_inside and node_taxi != null:
		var speed = node_taxi.linear_velocity.length()
		# if speed (linear_velocity) is lower than 0.5 can pick up passenger
		if speed < 0.5:
			pickup_passenger()
	
func pickup_passenger():
	print("¡Pasajero a bordo! ¡Acelera!")
	
	if destination_scene != null:
		var new_destination = destination_scene.instantiate()
		
		new_destination.position = dropoff_position
		
		get_parent().add_child(new_destination)
	
	# queue_free frees the cylinder
	queue_free()
