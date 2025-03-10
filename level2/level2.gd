extends Node2D

var board = [
	[1, 2, 3, 4],
	[5, 6, 7, 8],
	[9, 10, 11, 12],
	[13, 14, 15, 0]
]

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
		10: return $p10
		11: return $p11
		12: return $p12
		13: return $p13
		14: return $p14
		15: return $p15
	return null

func position_site(x):
	var start_x = 150  # Aumentado para centralizar
	var start_y = 150
	var spacing = 250  # Aumentado para evitar sobreposição
	
	var col = (x - 1) % 4
	var row = (x - 1) / 4
	
	return Vector2(
		start_x + col * spacing,
		start_y + row * spacing
	)
func plot_board():
	# Esconde todas as peças primeiro
	for i in range(1, 16):
		var sprite = get_sprite(i)
		if sprite:
			sprite.visible = false
	
	# Posiciona apenas as peças visíveis
	var x = 0
	for i in range(4):
		for j in range(4):
			x += 1
			var piece = board[i][j]
			if piece != 0:
				var sprite = get_sprite(piece)
				if sprite:
					sprite.visible = true
					sprite.global_position = position_site(x)

func valid_movements():
	var empty_pos = 0
	for i in range(4):
		for j in range(4):
			empty_pos += 1
			if board[i][j] == 0:
				var valid = []
				# Cima
				if i > 0: valid.append(empty_pos - 4)
				# Baixo
				if i < 3: valid.append(empty_pos + 4)
				# Esquerda
				if j > 0: valid.append(empty_pos - 1)
				# Direita
				if j < 3: valid.append(empty_pos + 1)
				return valid
	return []

func move(pos):
	var valid = valid_movements()
	if pos not in valid:
		return
	
	var empty_i = 0
	var empty_j = 0
	var piece_i = 0
	var piece_j = 0
	var x = 0
	
	for i in range(4):
		for j in range(4):
			x += 1
			if board[i][j] == 0:
				empty_i = i
				empty_j = j
			if x == pos:
				piece_i = i
				piece_j = j
	
	board[empty_i][empty_j] = board[piece_i][piece_j]
	board[piece_i][piece_j] = 0
	plot_board()
	check_win()

func find_piece_position(piece):
	var x = 0
	for i in range(4):
		for j in range(4):
			x += 1
			if board[i][j] == piece:
				return x
	return -1

func check_win():
	var solution = [
		[1, 2, 3, 4],
		[5, 6, 7, 8],
		[9, 10, 11, 12],
		[13, 14, 15, 0]
	]
	if board == solution:
		print("Parabéns! Você venceu!")

func _ready():
	# Garanta que o tabuleiro está visível apenas uma vez
	plot_board()
	# Embaralhar com 200 movimentos válidos
	for i in range(200):
		var moves = valid_movements()
		if moves.size() > 0:
			var rand_pos = moves[randi() % moves.size()]
			move(rand_pos)
	plot_board()  # Atualiza posições finais após embaralhamento

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		
		
		var mouse_pos = get_global_mouse_position()
		for num in range(1, 16):
			var sprite = get_sprite(num)
			if sprite and sprite.visible:
				var rect = Rect2(
					sprite.global_position - Vector2(100, 100),
					Vector2(200, 200)  # Área de clique maior
				)
				if rect.has_point(mouse_pos):
					var pos = find_piece_position(num)
					if pos != -1:
						move(pos)
						break  # Evita múltiplos cliques
