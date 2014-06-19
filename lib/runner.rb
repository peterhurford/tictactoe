# Program to run the TicTacToe game
# (Needs to be separate so it is not triggered by the spec test.)

require_relative 'tictactoe'		# Get game
$player = TicTacToe::Player.new		# Create a new game object
$player.start_game()				# Start the game