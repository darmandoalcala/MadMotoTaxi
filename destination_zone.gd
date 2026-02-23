extends Area3D

var taxi_inside = false
var node_taxi = null

func _ready() -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.name == "taxi":
		taxi_inside = true
		node_taxi = body
		print("Frena para dejar al pasajero!")

func _on_body_exited(body: Node3D) -> void:
	if body.name == "taxi":
		taxi_inside = false
		node_taxi = null
		print("Saliste de la Zona de destino")

func _physics_process(delta):
	if taxi_inside and node_taxi != null:
		var speed = node_taxi.linear_velocity.length()
		# Si la velocidad es casi cero, dejamos al pasajero
		if speed < 0.5:
			dropoff_passenger()

func dropoff_passenger():
	print("¡Viaje completado! ¡Ganaste dinero/tiempo!")
	
	# Aquí después sumaremos puntos o tiempo al HUD
	
	# Destruimos este cilindro de destino
	queue_free()
