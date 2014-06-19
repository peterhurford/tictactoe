module TicTacToe

	class Game
		attr_accessor :board
		attr_accessor :current_player

		def initialize
			@board =																					# Start with an empty board (. = empty space)
				[[".", ".", "."],
				[".", ".", "."],
				[".", ".", "."]]
			@current_player = ["O", "X"].sample							# Select a player to play first at random.
		end


		def helper_square_to_coords square 									# Helper function to ap a square number to x, y coords
			square = square.to_i
			x = (square-1) / 3
			y = (square-1) % 3
			[x, y]
		end


		def legal_move? square 															# Determine if a move to a square is a legal move
			coords = helper_square_to_coords(square)
			@board[coords[0]][coords[1]] == "."								# If the square is empty (has a "."), then the move is legal
		end


		def make_move! player, square 											# Modify the board to reflect the new move
			coords = helper_square_to_coords(square)
			@board[coords[0]][coords[1]] = player
		end


		def draw?																						# Determine if the game has ended in a draw (return true or false)
			helper_determine_game_state("draw")
		end


		def win?																						# Determine if the game has ended in a win (return false or winner ("X" or "O"))
			helper_determine_game_state("wins")
		end


		def helper_determine_game_state mode 								# Helper method to do the work of determining the game state for win or draw
																														# (Mode must be "wins", "draw", or "AI" or an error is raised.)

			board = @board 																		# Create a local instance of the board variable so we can modify it

			total_dots = 0 																		# Initialize a variable to count the number of empty spaces (dots)

			dimensions = ["row", "col", "diag1", "diag2"]			# The dimensions that matter
																														# (rows, columns, diag1 = top-left to bottom-right diagonal, diag2 = top-right to bottom-left diagonal)
			
			types = ["X", "O", "."]														# The types ("X", "O", or empty space ("."))

			count = {}																				# Initialize count hash for all types and dimensions
			dimensions.each do |dim|															# (e.g., count["row"][2]["X"] will keep track of the number of "X"s in row 2 (the bottom row).)
				count[dim] = {}
				for i in (0..2) do
					count[dim][i] = {}	
				end
			end

			board.each do |row| 															# Count the number of empty dots
				row.each do |cell|
					total_dots += 1 if cell == "."
				end
			end

			types.each do |t| 																# Use the count variable to actually count the number of that type in that row/column/diagonal
				["row", "col"].each do |dim|
					for i in (0..2) do
						count[dim][i][t] = board[i].count { |cell| cell == t }
					end
					board = board.transpose												# Transpose the grid so that we can count columns
																												# This is triggered a second time to return the grid to normal
				end		
			end	

			diag1 = [board[0][0], board[1][1], board[2][2]]		# Construct diagonals
			diag2 = [board[0][2], board[1][1], board[2][0]]
			types.each do |t|
				count["diag1"][0][t] = diag1.count { |cell| cell == t }					# Count the number of each type within the diagonals
				count["diag2"][0][t] = diag2.count { |cell| cell == t }
			end

			if mode == "wins"																	# Determine whether the game state is a win, and, if so, who won
				for i in (0..2) do 																	# (A game state is won if there are three "O" or three "X" in a row, meaning a count has reached 3)
					return "X" if count["row"][i]["X"] == 3 or count["col"][i]["X"] == 3 or count["diag1"][0]["X"] == 3 or count["diag2"][0]["X"] == 3
					return "O" if count["row"][i]["O"] == 3 or count["col"][i]["O"] == 3 or count["diag1"][0]["O"] == 3 or count["diag2"][0]["O"] == 3
				end

			elsif mode == "draw"															# Determine whether the game state is a draw

				return false if total_dots >= 3 								# No draw can occur if there are three empty spaces (dots) or more.
				return true if total_dots == 0 									# A draw must occur if there are no longer any empty spaces.

				# A draw cannot occur if there are two of the same type in a row and the opportunity to finish the row (i.e., one turn away from winning.)
				# Though, there still could be a draw if there is only one empty space and the player is forced to block (not ruled out here and captured later.)
				dimensions.each do |dim|
					for i in (0..2) do
						checkSquare = board[i][1] if dim == "row"
						checkSquare = board[1][i] if dim == "col"
						checkSquare = board[1][1] if dim == "diag1" or dim == "diag2"
						return false if count[dim][i]["X"] == 2 and checkSquare == "X" and count[dim][i]["."] == 1 and @current_player == "O"
						return false if count[dim][i]["O"] == 2 and checkSquare == "O" and count[dim][i]["."] == 1 and @current_player == "X"
					end
				end

				# A draw must occur if there is only one empty space and no row/column/diagonal containing that dot has two of the same type.
				dimensions.each do |dim|
					for i in (0..2) do
						return true if count[dim][i]["."] == 1 and count[dim][i]["O"] == 1 and count[dim][i]["X"] == 1 and total_dots == 1
					end
				end
				return true if total_dots == 2

			elsif mode == "AI"															# AI can request the count hash (so it doesn't need to be coded elsewhere)
				return count

			
			else																						# If the method variable is something other than "wins" or "draw", raise an error.
				raise "Mode error".inspect
			end

			return false 																		# If we get here in "wins" mode, it can only be because no player has won, so return false.
																											# If we get here in "draw" mode, there cannot be a draw, because all draws have already been ruled out, so return false.
		end


		def print_board																		# Print the board onto the screen.
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



	class Player
		attr_accessor :current_player

		def initialize
			@game = Game.new
			@game_over = false
		end


		def helper_display_name name											# Helper method to turn the player variable into a displayable name based on game type
			if @game_type == "AI"
				disp = "Human" if name == "O"
				disp = "The AI" if name == "X"
			else
				disp = "Player " + name.to_s
			end
			disp
		end


		def switch_player! 																# Method to switch the player.
			@game.current_player == "O" ? @game.current_player = "X" : @game.current_player = "O"
		end


		def process! plSquare																			# Process the legal move.
			if @game_over == false
				@game.make_move!(@game.current_player, plSquare)			# Make the move on the board.
				if @game.win?																					# Check board state for winner...
					@game.print_board()
					#{helper_display_cp_name()}
					puts "Congratulations... " + helper_display_name(@game.win?) + " wins!"
					@game_over = true
				elsif @game.draw? 															# Check board state for a draw...
					@game.print_board()
					puts "The game ends in a draw!"
					@game_over = true
				else 																						# Otherwise...
					if @game_type == "player"											# In a player vs. player game, the game simply switches to the next player and begins again.
						switch_player!()
						start_turn()
					elsif @game_type == "AI"											# In a player vs. AI game, the AI moves and then switches back to the player and begins again.
						
						if @game.current_player == "O"							# If AI to go...
							switch_player!()													# ...Switch to AI
							@AI.make_move!()													# ...AI makes move

						elsif @game.current_player == "X"						# If AI just went...
							switch_player!()													# ...Switch back to human
							start_turn()															# ...Start the turn for the human
						end

					else 																					# If the game type isn't recognized, raise an error.
						raise "Game Type Error".inspect
					end
				end
			end
		end


		def start_game 																		# Method to start the game.
			puts "Welcome to Ruby Tic-Tac-Toe!"
			
			# Get input from player on game mode
			valid = false
			while valid == false do
				puts "To play against another person, type P.  To play against the AI, type A."
				@input = STDIN.gets.chomp.downcase

				valid = "pa".split("")
				if valid.include? @input
					valid = true
				else
					puts "That input is not valid."
				end
			end

			# Set game mode
			if @input == "p"
				@game_type = "player"
			elsif @input == "a"
				@AI = AI.new(@game, self)											# Create an AI to play against -- pass it the @game object and this player instance
				@game_type = "AI" 
				if @game.current_player == "X"								# AI randomly selected to be first...
					@AI.make_move!()
				end
			end


			start_turn()																		# Start the first turn
		end


		def start_turn 																		# Method to implement the turn for the user (called by runner.rb)
			if @game_over == false
				@game.print_board()
				puts helper_display_name(@game.current_player) + "... On which square number would you like to play?"

				plSquare = STDIN.gets.chomp	 										# Get the move from the player via terminal.
				
				valid = "123456789".split("")										# Validate the input, reject it if not 1-9, and start over asking for input again.
				unless valid.include? plSquare
					puts "Please enter either a number 1-9."
					start_turn()
				end

				if @game.legal_move?(plSquare) 									# Validate the input to see if the move is legal.
					process!(plSquare)														# If the move is legal, process it.
				else																						# If not, reject it, and start over.
					puts "Sorry, that square is already taken.  Try again?"
					start_turn()
				end
			end
		end
	end



	class AI
		def initialize game, player
			@game = game 																			# AI needs a copy of the game and player objects
			@player = player
		end

		def make_move!
			puts "AI to go..."

			move_made = false
			while move_made == false
				move = think()
				move = Random.new.rand(1..9) if move == false
				if @game.legal_move?(move)
					@player.process!(move)
					move_made = true
				end
			end
		end

		def think
			# Implement Newell and Simon's (1972) tic-tac-toe algorithm. <https://en.wikipedia.org/wiki/Tic-tac-toe#Strategy>

			# Collect data
			board = @game.board
			dimensions = ["row", "col", "diag1", "diag2"]
			count = @game.helper_determine_game_state("AI")

			# Step 1: Win. (If the AI has two in a row, the AI will place a third to get three in a row.)
			select = false
			dimensions.each do |dim|												# Determine if AI has two in a row
				for i in (0..2) do
					select = [dim, i] if count[dim][i]["X"] == 2
				end
			end
			if select 																			# If so, determine and place the third...
				if select[0] == "row"
					for i in (0..2) do
						return select[1]*3 + i+1 if board[select[1]][i] == "."
					end
				elsif select[0] == "col"
					for i in (0..2) do
						return i*3 + select[1]+1 if board[i][select[1]] == "."
					end
				elsif select[0] == "diag1"
					for i in (0..2) do
						return select[1]*3 + select[1]+1 if board[select[1]][select[1]] == "."
					end
				elsif select[0] == "diag2"
					for i in (0..2) do
						return select[1]*3 + 2-select[1]+1 if board[select[1]][2-select[1]] == "."
					end
				end
			end
			false

			# Step 2: Block. If the opponent has two in a row, the AI must play the third themself to block the opponent.

			# Step 3: Fork. Create an opportunity where the AI has two threats to win (two non-blocked lines of 2).

			# Step 4: Block an opponent's fork.  The AI should create two in a row to force the opponent into defending, as long as it doesn't result in them creating a fork.
			# (For example, if "X" has a corner, "O" has the center, and "X" has the opposite corner as well, "O" must not play a corner in order to win, as playing a corner in this scenario creates a fork for "X" to win.)

			# Step 5: Center. AI marks the dead center, if it is available.

			# Step 6: Opposite Corner. If the opponent is in a corner, the AI plays the opposite corner.

			# Step 7: Empty Corner. The AI plays in a corner square.

			# Step 8: Empty Side. The AI plays in the middle of any of the four sides.

			# Step 9: Open. If playing first, pick a random corner.
		end
	end

end

##### TO-DO
## * AI is smart + commit
