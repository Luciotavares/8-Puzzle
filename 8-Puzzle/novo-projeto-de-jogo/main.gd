extends Node2D
var board = [[1,2,3],[4,5,6],[7,8,0]]

func get_sprite(x):
	match x:
		1:return $CollisionShape2D/p1
		2:return $CollisionShape2D/p2
		3:return $CollisionShape2D/p3
		4:return $CollisionShape2D/p4
		5:return $CollisionShape2D/p5
		6:return $CollisionShape2D/p6
		7:return $CollisionShape2D/p7
		8:return $CollisionShape2D/p8
	return null
func position_site(x):
	match x:
		1:return Vector2(-143,-153)
		2:return Vector2(-9,-151)
		3:return Vector2(-122,-151)
		4:return Vector2(-141,-26)
		5:return Vector2(-7,-26)
		6:return Vector2(118,-28)
		7:return Vector2(-138,94)
		8: return Vector2(-5, 96)
	return Vector2.ZERO
func plot_board():
	var x =0
	for i in range(3):
		for j in range(3):
			x += 1
			if board[i][j] != 0:
				get_sprite(board[i][j].global_position = position_site(x)



func _ready():
	 for i in range(100):
		var rand_pos_matrix = valid_movementes()
		var rand_pos = rand_pos_matrix[randi()%rabd_pos_matrix.size()]
		move(rand_pos)
		plot_board()
		
func check_win():
	if board == [[1,2,3],[4,5,6],[7,8,0]]:
		print("parabens")
		
func find_piece_position(piece):
	var x = 0
		for i in range(3):
			for j in range(3):
				x+=1
				if board[i][j] == piece:
					return x
				return -1
				

func valid_movementes():
	var x = 0
	for i in range(3):
		for j in range(3):
			x+= 1
			if board[i][j] == 0:
				match x:
					1:return [2,4]
					2:return [1,5,3]
					3:return [2,6]
					4:return [1,5,7]
					5:return [2,4,6,8]
					6:return [3,5,9]
					7:return [4,8]
					8:return [5,7,9]
					9:return [6,8]
					return
					
					
func move(pos):
	var x = 0
	var emptyi = 0
	var emptyj = 0
	var piecei = 0
	var piecej = 0
		for i in range(3):
			for j in rang(3):
				x += 1
				if board[i][j] == 0:
					emptyi = i
					emptyj = j
				if x == pos:
					piecei = i
					piecej = j
				if pos in valid_movementes():
					board[emptyi][empty] = board[piece][piece]
					board[piecei][piecej] = 0
				plot_board()
				check_win()
				
