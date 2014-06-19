# Program to run the TicTacToe game
# (Needs to be separate so it is not triggered by the spec test.)

require_relative 'tictactoe'		# Get game
game = TicTacToe::Game.new			# Create a new game object
game.start_turn()					# Start the first turn