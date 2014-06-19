module TicTacToe
	class Board
		def initialize
			@board =
				[[".", ".", "."],
				[".", ".", "."],
				[".", ".", "."]]
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
			for i in (0..2) do
				for j in (0..2) do
					return false if @board[i][j] == "."
				end
			end
			true
		end


		def win?
			board = @board

			2.times do
				count_Od = 0
				count_Xd = 0
				count_Ord = 0
				count_Xrd = 0

				for i in (0..2) do
					count_O = 0
					count_X = 0
					for j in (0..2) do
						count_O += 1 if board[i][j] == "O"
						count_X += 1 if board[i][j] == "X"
						if j == 0
							count_Od += 1 if board[i][i] == "O"
							count_Xd += 1 if board[i][i] == "X"
							count_Ord += 1 if board[i][2-i] == "O"
							count_Xrd += 1 if board[i][2-i] == "X"
						end
					end
					return "O" if count_O == 3
					return "X" if count_X == 3
				end
				return "O" if count_Od == 3
				return "X" if count_Xd == 3
				return "O" if count_Ord == 3
				return "X" if count_Xrd == 3
				board = @board.transpose
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
			@curr_player = "O"
			start_turn()
		end


		def switch_player!
			@curr_player == "O" ? @curr_player = "X" : @curr_player = "O"
		end


		def start_turn
			@game.print_board()
			puts "Player #{@curr_player}... On which square number would you like to play?"
			plSquare = gets.chomp
			valid = "0123456789".split("")
			
			unless valid.include? plSquare
				puts "Please enter either a number 1-9."
				start_turn()
			end
			if @game.legal_move?(plSquare)
				@game.make_move!(@curr_player, plSquare)
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


game = TicTacToe::Game.new



##### TO-DO
## * Earlier draw detection.
## * Play against other person or play against AI.
## * On Git.