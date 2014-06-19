module TicTacToe
	class Board
		def initialize
			@board =
				[[".", ".", "."],
				[".", ".", "."],
				[".", ".", "."]]
		end


		def test_set_board board
			@board = board
		end


		def helper_square_to_coords square
			square = square.to_i
			x = (square-1) / 3
			y = (square-1) % 3
			[x, y]
		end


		def legal_move? square
			coords = helper_square_to_coords(square)
			@board[coords[0]][coords[1]] == "."
		end


		def make_move! player, square
			coords = helper_square_to_coords(square)
			@board[coords[0]][coords[1]] = player
		end


		def draw?
			helper_count_positions("draw")
		end


		def win?
			helper_count_positions("wins")
		end


		def helper_count_positions mode
			board = @board
			total_dots = 0
			dimensions = ["row", "col", "diag1", "diag2"]
			types = ["X", "O", "."]

			count = {}
			dimensions.each do |dim|
				count[dim] = {}
				for i in (0..2) do
					count[dim][i] = {}	
				end
			end

			board.each do |row|
				row.each do |cell|
					total_dots += 1 if cell == "."
				end
			end

			types.each do |t|
				["row", "col"].each do |dim|
					for i in (0..2) do
						count[dim][i][t] = board[i].count { |cell| cell == t }
					end
					board = board.transpose
				end		
			end	

			diag1 = [board[0][0], board[1][1], board[2][2]]
			diag2 = [board[0][2], board[1][1], board[2][0]]
			types.each do |t|
				count["diag1"][0][t] = diag1.count { |cell| cell == t }
				count["diag2"][0][t] = diag2.count { |cell| cell == t }
			end

			if mode == "wins"
				for i in (0..2) do
					return "X" if count["row"][i]["X"] == 3 or count["col"][i]["X"] == 3 or count["diag1"][0]["X"] == 3 or count["diag2"][0]["X"] == 3
					return "O" if count["row"][i]["O"] == 3 or count["col"][i]["O"] == 3 or count["diag1"][0]["O"] == 3 or count["diag2"][0]["O"] == 3
				end

			elsif mode == "draw"
				return false if total_dots >= 3
				return true if total_dots == 0
				dimensions.each do |dim|
					for i in (0..2) do
						checkSquare = board[i][1] if dim == "row"
						checkSquare = board[1][i] if dim == "col"
						checkSquare = board[1][1] if dim == "diag1" or dim == "diag2"
						return false if count[dim][i]["X"] == 2 and checkSquare == "X" and count[dim][i]["."] == 1 and $curr_player == "O"
						return false if count[dim][i]["O"] == 2 and checkSquare == "O" and count[dim][i]["."] == 1 and $curr_player == "X"
					end
				end
				dimensions.each do |dim|
					for i in (0..2) do
						return true if count[dim][i]["."] == 1 and count[dim][i]["O"] == 1 and count[dim][i]["X"] == 1 and total_dots == 1
					end
				end
				return true if total_dots == 2

			else
				raise "Mode error".inspect
			end

			return false
		end


		def print_board
			i = 1
			@board.each do |row|
				row.each do |column|
					print "#{i}: #{column} "
					i += 1
				end
				print "\n"
			end
		end
	end


	class Game
		def initialize
			@game = Board.new
			$curr_player = "O"
			start_turn()
		end


		def switch_player!
			$curr_player == "O" ? $curr_player = "X" : $curr_player = "O"
		end


		def start_turn
			@game.print_board()
			puts "Player #{$curr_player}... On which square number would you like to play?"
			plSquare = STDIN.gets.chomp
			valid = "123456789".split("")
			
			unless valid.include? plSquare
				puts "Please enter either a number 1-9."
				start_turn()
			end
			if @game.legal_move?(plSquare)
				@game.make_move!($curr_player, plSquare)
				if @game.win?
					@game.print_board()
					puts "Congratulations... #{@game.win?} wins!"
				elsif @game.draw?
					@game.print_board()
					puts "The game ends in a draw!"
				else
					switch_player!()
					start_turn()
				end
			else
				puts "Sorry, that square is already taken.  Try again?"
				start_turn()
			end
		end
	end
end

##### TO-DO
## * Code comments + commit
## * 4 dot draw detection + commit
## * Play against other person or play against AI + commit
