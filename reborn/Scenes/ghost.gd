extends CharacterBody2D


const SPEED = 250
const JUMP_VELOCITY = -350
var jumpAmount = 0
var is_jumping = false
var is_floating = false
@onready var hover_bar: ProgressBar = $HoverBar
@onready var stylebox = hover_bar.get_theme_stylebox("background")
@onready var glow: PointLight2D = $Sprite2D/Glow


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		# Progress bar show
		hover_bar.show()
		
		if !is_floating:
			velocity += get_gravity() * delta
		else:
			velocity.y -= 5
		
		if not is_floating and jumpAmount == 1 and Input.is_action_pressed("Jump") and hover_bar.value > 0:
			glow.show()
			# Progress bar drain
			hover_bar.value -= 1
			velocity.y = 0
		
		# If player falls off
		# If player not on floor but has not jumped (slip)
		if jumpAmount == 0 and not is_jumping:
			jumpAmount += 1
			
		if Input.is_action_just_released("Jump"):
			is_jumping = false
			jumpAmount += 1
			glow.hide()
			if jumpAmount > 1:
				hover_bar.value = 0
				
	
	#if progress bar is 0, change style
	if hover_bar.value <= 0 and stylebox is StyleBoxFlat:
		glow.hide()
		stylebox.border_color = Color.RED
		hover_bar.add_theme_stylebox_override("background", stylebox)
	
	if is_on_floor():
		# Prevent jump followed by hover
		if Input.is_action_just_released("Jump"):
			is_jumping = false
		# Progress bar hide and reset to 100
		hover_bar.hide()
		glow.hide()
		hover_bar.value = 100
		if stylebox is StyleBoxFlat:
			stylebox.border_color = Color.BLACK
			hover_bar.add_theme_stylebox_override("background", stylebox)
		
		jumpAmount = 0
		# Handle jump.
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP_VELOCITY
			is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED * 0.5
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
