extends Area2D
class_name portal


@onready var portal_collider = $CollisionShape2D

@export_category("Variables") 
@export var destiny: String

@export_category("objects")
@export var _animator: AnimatedSprite2D = null

func _ready():
		if Global.onTavern:
			_animator.visible = true 
			_animator.play("spawn")
			await get_tree().create_timer(0.8).timeout
			_animator.play("idle")
			portal_collider.set_deferred("disabled", false)
	

func _process(delta):
	if Global.enemies_killed >= Global.max_enemies * 2: #TODO trocar magic number pelo comprimento do vetor de inimigos
		portal_collider.set_deferred("disabled",false)
		_animator.play("spawn")
		_animator.visible = true
		await  _animator.animation_finished
		_animator.play("idle")
		Global.enemies_killed = 0
		

## Retorna a chave da scene correspondente ao numero da wave no momento
func getDestinyByWaveNumber() -> String:
	if Global.num_wave < 10:
		return "forest";
	if Global.num_wave < 20:
		return "win";
	if Global.num_wave == 10:
		return "win"
	
	return "forest"
	

## Função que verifica se o player entrou no portal
func _on_body_entered(_body) -> void:
	if _body is CharacterBody2D:
		
		if not Global.onTavern:
			Global.num_wave += 1
			Global.total_xp += 1 # Experiência do jogador
			Global.max_enemies += 1
			Global.damage_enemy += 0.25
		
		# Se entrou a partir do bar:
		if Global.onTavern:
			destiny = getDestinyByWaveNumber();
			Global.onTavern = false;
			print("Taverna: ", Global.onTavern)
		else: # Caso contrário (player na fase):
			# Saber se o numero da wave corresponde a um checkpoint para o bar
			if Global.num_wave % 5 == 0:
				destiny = "tavern"
				Global.onTavern = true
				print("Taverna: ", Global.onTavern)
			else:
				destiny = getDestinyByWaveNumber()
				print("Taverna: ", Global.onTavern);

		# Transiciona finalmente para a cena destino.
		Global.transitionToScene(destiny)
		print("Wave: ", Global.num_wave)
