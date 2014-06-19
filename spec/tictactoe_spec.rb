require_relative '../lib/tictactoe'

describe TicTacToe do
	$game = TicTacToe::Board.new
	describe "Board should win" do		
		describe "in rows" do
			describe "top row" do
				sample_board =
					[["X", "X", "X"],
					[".", ".", "."],
					[".", ".", "."]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "X" }
			end
			describe "middle row" do
				sample_board =
					[[".", ".", "."],
					["X", "X", "X"],
					[".", ".", "."]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "X" }
			end
			describe "bottom row" do
				sample_board =
					[[".", ".", "."],
					[".", ".", "."],
					["X", "X", "X"]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "X" }
			end
		end

		describe "in columns" do
			describe "left column" do
				sample_board =
					[["O", ".", "."],
					["O", ".", "."],
					["O", ".", "."]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "O" }
			end
			describe "middle column" do
				sample_board =
					[[".", "O", "."],
					[".", "O", "."],
					[".", "O", "."]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "O" }
			end
			describe "right column" do
				sample_board =
					[[".", ".", "O"],
					[".", ".", "O"],
					[".", ".", "O"]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "O" }
			end
		end

		describe "in diagonals" do
			describe "diagonal1" do
				sample_board =
					[["O", ".", "."],
					[".", "O", "."],
					[".", ".", "O"]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "O" }
			end
			describe "diagonal2" do
				sample_board =
					[[".", ".", "X"],
					[".", "X", "."],
					["X", ".", "."]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == "X" }
			end
		end
	end
	describe "Board should not win" do
		describe "when not a win" do
				sample_board =
					[[".", ".", "X"],
					[".", "X", "."],
					[".", ".", "."]]
				$game.test_set_board(sample_board)
				output = $game.win?
				subject { output }
				specify { output should == false }
			end
	end


	describe "Board should draw" do
		describe "no dot tie" do
			sample_board =
					[["O", "O", "X"],
					["X", "X", "O"],
					["O", "O", "X"]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end
		describe "one dot tie A" do
			sample_board =
					[["X", "O", "X"],
					["O", "X", "O"],
					["O", ".", "O"]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end

		describe "one dot tie B" do
			sample_board =
					[["O", "O", "X"],
					[".", "X", "O"],
					["X", "O", "X"]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end

		describe "one dot tie C" do
			sample_board =
					[["O", "X", "O"],
					["X", "O", "."],
					["X", "O", "X"]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end		

		describe "two dot tie A" do
			sample_board =
					[["X", "O", "X"],
					["X", "O", "."],
					["O", "X", "."]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end

		describe "two dot tie B" do
			sample_board =
					[["X", "X", "O"],
					["O", "O", "X"],
					["X", ".", "."]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end

		describe "two dot tie C" do
			sample_board =
					[["O", "X", "O"],
					[".", "O", "."],
					["X", "O", "X"]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end

		describe "two dot tie D" do
			sample_board =
					[["O", "O", "X"],
					["X", "X", "O"],
					["O", ".", "."]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == true }
		end		

	end
	describe "Board should not draw" do
		describe "when four dots" do
			sample_board =
					[["X", "O", "X"],
					["O", "O", "."],
					[".", ".", "."]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == false }
		end
		describe "when three dots" do
			sample_board =
					[["X", "O", "X"],
					["O", "O", "X"],
					[".", ".", "."]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == false }
		end	
		describe "when two dots and there's still game" do
			sample_board =
					[["O", "X", "X"],
					["O", "O", "X"],
					["X", ".", "."]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == false }
		end	
		describe "when one dot and there's still game" do
			sample_board =
					[["X", "O", "O"],
					["O", "O", "X"],
					["X", ".", "X"]]
			$game.test_set_board(sample_board)
			output = $game.draw?
			subject { output }
			specify { output should == false }
		end	
	end

end
