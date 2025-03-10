extends Node2D
@onready var popup = $Window

var board = [[1,2,3],[4,5,6],[7,8,0]]
func get_sprite(x):
	match x:
		1: return $p1
		2: return $p2
		3: return $p3
		4: return $p4
		5: return $p5
		6: return $p6
		7: return $p7
		8: return $p8
		9: return $p9
	return null

func position_site(x):
	match x:
		1: return Vector2(125,125)
		2: return Vector2(375,125)
		3: return Vector2(625,125)
		4: return Vector2(125,375)
		5: return Vector2(375,375)
		6: return Vector2(625,375)
		7: return Vector2(125,625)
		8: return Vector2(375, 625)
		9: return Vector2(625, 625)
	return Vector2.ZERO

func plot_board():
	var x = 0
	for i in range(3):
		for j in range(3):
			x += 1
			if board[i][j] != 0:
				get_sprite(board[i][j]).global_position = position_site(x)

			

func valid_movements():
	var empty_pos = 0
	for i in range(3):
		for j in range(3):
			empty_pos += 1
			if board[i][j] == 0:
				match empty_pos:
					1: return [2,4]
					2: return [1,5,3]
					3: return [2,6]
					4: return [1,5,7]
					5: return [2,4,6,8]
					6: return [3,5,9]
					7: return [4,8]
					8: return [5,7,9]
					9: return [6,8]
	return []
func move2(pos):
	var valid = valid_movements()
	if pos not in valid:
		return  
	
	var empty_pos = find_piece_position(0)
	var x = 0
	var piece_i = 0
	var piece_j = 0
	var empty_i = 0
	var empty_j = 0
	
	
	for i in range(3):
		for j in range(3):
			x += 1
			if x == pos:
				piece_i = i
				piece_j = j
			if x == empty_pos:
				empty_i = i
				empty_j = j
	
	
	board[empty_i][empty_j] = board[piece_i][piece_j]
	board[piece_i][piece_j] = 0
	plot_board()
func move(pos):
	var valid = valid_movements()
	if pos not in valid:
		return  
	
	var empty_pos = find_piece_position(0)
	var x = 0
	var piece_i = 0
	var piece_j = 0
	var empty_i = 0
	var empty_j = 0
	
	
	for i in range(3):
		for j in range(3):
			x += 1
			if x == pos:
				piece_i = i
				piece_j = j
			if x == empty_pos:
				empty_i = i
				empty_j = j
	
	
	board[empty_i][empty_j] = board[piece_i][piece_j]
	board[piece_i][piece_j] = 0
	plot_board()
	check_win()
func find_piece_position(piece):
	var x = 0
	for i in range(3):
		for j in range(3):
			x += 1
			if board[i][j] == piece:
				return x
	return -1

func check_win():
	if board == [[1,2,3],[4,5,6],[7,8,0]]:
		print("Parabéns! Você resolveu o quebra-cabeça!")
		popup.show()
		get_tree().change_scene_to_file("res://level2/level2.tscn")

func _ready():
	for i in range(100):
		var possible_moves = valid_movements()
		if possible_moves.size() > 0:
			var rand_pos = possible_moves[randi() % possible_moves.size()]
			move2(rand_pos)
			plot_board()
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		for i in range(1, 9):
			var sprite = get_sprite(i)
			if sprite:
				var sprite_rect = Rect2(sprite.global_position - sprite.get_rect().size / 2, sprite.get_rect().size)
				if sprite_rect.has_point(mouse_pos):
					var pos = find_piece_position(i)
					if pos != -1:
						move(pos)


func _on_window_close_requested() -> void:
	popup.hide()


func _on_window_visibility_changed() -> void:
		pass
