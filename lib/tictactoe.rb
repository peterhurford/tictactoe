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

			count = {}
			count["row"] = {}
			count["col"] = {}
			count["diag1"] = {}
			count["diag2"] = {}
			for i in (0..2) do
				count["row"][i] = {}	
				count["col"][i] = {}	
				count["diag1"][i] = {}	
				count["diag2"][i] = {}	
			end

			board.each do |row|
				row.each do |cell|
					total_dots += 1 if cell == "."
				end
			end

			for i in (0..2) do
				count["row"][i]["X"] = board[i].count { |cell| cell == "X" }
				count["row"][i]["O"] = board[i].count { |cell| cell == "O" }
				count["row"][i]["."] = board[i].count { |cell| cell == "." }
			end

			board = board.transpose

			for i in (0..2) do
				count["col"][i]["X"] = board[i].count { |cell| cell == "X" }
				count["col"][i]["O"] = board[i].count { |cell| cell == "O" }
				count["col"][i]["."] = board[i].count { |cell| cell == "." }
			end

			count["diag1"][0]["X"] = [board[0][0], board[1][1], board[2][2]].count { |cell| cell == "X" }
			count["diag1"][0]["O"] = [board[0][0], board[1][1], board[2][2]].count { |cell| cell == "O" }
			count["diag1"][0]["."] = [board[0][0], board[1][1], board[2][2]].count { |cell| cell == "." }

			count["diag2"][0]["X"] = [board[0][2], board[1][1], board[2][0]].count { |cell| cell == "X" }
			count["diag2"][0]["O"] = [board[0][2], board[1][1], board[2][0]].count { |cell| cell == "O" }
			count["diag2"][0]["."] = [board[0][2], board[1][1], board[2][0]].count { |cell| cell == "." }

			if mode == "wins"
				for i in (0..2) do
					return "X" if count["row"][i]["X"] == 3 or count["col"][i]["X"] == 3 or count["diag1"][0]["X"] == 3 or count["diag2"][0]["X"] == 3
					return "O" if count["row"][i]["O"] == 3 or count["col"][i]["O"] == 3 or count["diag1"][0]["O"] == 3 or count["diag2"][0]["O"] == 3
				end

			elsif mode == "draw"
				return false if total_dots >= 4
				return true if total_dots == 0

				for i in (0..2) do
					return true if count["row"][i]["."] == 1 and count["row"][i]["O"] == 1 and count["row"][i]["X"] == 1 and total_dots == 1
					return true if count["col"][i]["."] == 1 and count["col"][i]["O"] == 1 and count["col"][i]["X"] == 1 and total_dots == 1
					return true if count["diag1"][i]["."] == 1 and count["diag1"][i]["O"] == 1 and count["diag1"][i]["X"] == 1 and total_dots == 1
					return true if count["diag2"][i]["."] == 1 and count["diag2"][i]["O"] == 1 and count["diag2"][i]["X"] == 1 and total_dots == 1
				end

				for i in (0..2) do
					return false if count["row"][i]["."] == 2 and total_dots == 2 and ((count["row"][i]["X"] == 1 and $curr_player == "O") or (count["row"][i]["O"] == 1 and $curr_player == "X"))
					return false if count["col"][i]["."] == 2 and total_dots == 2 and ((count["col"][i]["X"] == 1 and $curr_player == "O") or (count["col"][i]["O"] == 1 and $curr_player == "X"))
					return false if count["diag1"][i]["."] == 2 and total_dots == 2 and ((count["diag1"][i]["X"] == 1 and $curr_player == "O") or (count["diag1"][i]["O"] == 1 and $curr_player == "X"))
					return false if count["diag2"][i]["."] == 2 and total_dots == 2 and ((count["diag2"][i]["X"] == 1 and $curr_player == "O") or (count["diag2"][i]["O"] == 1 and $curr_player == "X"))
				end
				return true if total_dots == 2

				three_dots_in_line = false
				for i in (0..2) do
					three_dots_in_line = true if count["row"][i]["."] == 3 or count["col"][i]["."] == 3 or count["diag1"][0]["."] == 3 or count["diag2"][0]["."] == 3
				end
				return true if three_dots_in_line == true and total_dots == 3				
			
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
## * Write tests + commit
## * Refactor code + commit
## * Code comments + commit
## * 4 dot draw detection + commit
## * Play against other person or play against AI + commit
