require_relative '../lib/tictactoe'
require_relative '../lib/ai'

describe TicTacToe do
  describe "AI" do
    describe "AI should win" do   
      describe "in rows" do
        describe "top row" do
          sample_board =
            [["X", "X", "."],
            [".", ".", "."],
            [".", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 3 }
        end
        describe "middle row" do
          sample_board =
            [[".", ".", "."],
            ["X", ".", "X"],
            [".", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 5 }
        end
        describe "bottom row" do
          sample_board =
            [[".", ".", "."],
            [".", ".", "."],
            [".", "X", "X"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 7 }
        end
      end

      describe "in columns" do
        describe "left column" do
          sample_board =
            [[".", ".", "."],
            ["X", ".", "."],
            ["X", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 1 }
        end
        describe "middle column" do
          sample_board =
            [[".", "X", "."],
            [".", ".", "."],
            [".", "X", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 5 }
        end
        describe "right column" do
          sample_board =
            [[".", ".", "X"],
            [".", ".", "X"],
            [".", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 9 }
        end
      end

      describe "in diagonals" do
        describe "diagonal1" do
          sample_board =
            [[".", ".", "."],
            [".", "X", "."],
            [".", ".", "X"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 1 }
        end
        describe "diagonal2" do
          sample_board =
            [[".", ".", "X"],
            [".", ".", "."],
            ["X", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 5 }
        end
        describe "diagonal2 B" do
          sample_board =
            [[".", ".", "X"],
            [".", "X", "."],
            [".", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 7 }
        end
      end
    end

    describe "AI should block wins" do    
      describe "in rows" do
        describe "top row" do
          sample_board =
            [["O", "O", "."],
            [".", "X", "O"],
            [".", "X", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 3 }
        end
        describe "middle row" do
          sample_board =
            [[".", "X", "."],
            ["O", ".", "O"],
            [".", ".", "X"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 5 }
        end
        describe "bottom row" do
          sample_board =
            [["O", "X", "."],
            [".", "X", "."],
            [".", "O", "O"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 7 }
        end
      end

      describe "in columns" do
        describe "left column" do
          sample_board =
            [[".", ".", "."],
            ["O", ".", "X"],
            ["O", "X", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 1 }
        end
        describe "middle column" do
          sample_board =
            [[".", "O", "."],
            ["X", ".", "."],
            [".", "O", "X"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 5 }
        end
        describe "right column" do
          sample_board =
            [[".", ".", "O"],
            ["X", "X", "O"],
            [".", ".", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 9 }
        end
      end

      describe "in diagonals" do
        describe "diagonal1" do
          sample_board =
            [[".", ".", "."],
            [".", "O", "."],
            ["X", "X", "O"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 1 }
        end
        describe "diagonal2" do
          sample_board =
            [[".", ".", "O"],
            [".", ".", "."],
            ["O", "X", "X"]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 5 }
        end
        describe "diagonal2 B" do
          sample_board =
            [[".", "X", "O"],
            [".", "O", "."],
            [".", "X", "."]]
          game = TicTacToe::Game.new
          game.board = sample_board
          player = TicTacToe::Player.new
          robot = TicTacToe::AI.new(game, player)
          output = robot.think()
          subject { output }
          specify { output should == 7 }
        end
      end
    end
  end
end

## Probably should have specs to ensure AI follows proper forking and block forking rules, but I think this is good enough for now.