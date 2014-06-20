module TicTacToe
class AI
    def initialize game, player
      @game = game                                      # AI needs a copy of the game and player objects
      @player = player
    end

    def make_move!
      puts "AI to go..."
      move = think()
      if @game.legal_move?(move)
        @player.process!(move)
        move_made = true
      else
        raise "AI Error".inspect                        # The AI should never generate an illegal move
      end
    end

    def think
      # Implement Brian Harvey's tic-tac-toe algorithm <http://www.cs.berkeley.edu/~bh/v1ch6/ttt.html>.

      # Collect data
      board = @game.board
      dimensions = ["row", "col", "diag1", "diag2"]
      count = @game.helper_determine_game_state("AI")


      # Step 1: Open. (If playing first, pick a random corner.)
      total_dots = 0
      board.each do |row|
        row.each do |cell|
          total_dots += 1 if cell == "."
        end
      end
      return [1, 3, 7, 9].sample if total_dots == 9


      # Step 2: Win. (If the AI has two in a row, the AI will place a third to get three in a row.)
      select = false
      dimensions.each do |dim|                        # Determine if AI has two in a row
        for i in (0..2) do
          select = [dim, i] if count[dim][i]["X"] == 2 and count[dim][i]["."] == 1
        end
      end
      if select                                       # If so, determine and place the third...
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
            return i*3 + i+1 if board[i][i] == "."
          end
        elsif select[0] == "diag2"
          for i in (0..2) do
            return i*3 + 2-i+1 if board[i][2-i] == "."
          end
        end
      end


      # Step 3: Block. (If the opponent has two in a row, the AI must play the third themself to block the opponent.)
      select = false
      dimensions.each do |dim|                        # Determine if human has two in a row
        for i in (0..2) do
          select = [dim, i] if count[dim][i]["O"] == 2 and count[dim][i]["."] == 1
        end
      end
      if select                                       # If so, determine and place the third...
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
            return i*3 + i+1 if board[i][i] == "."
          end
        elsif select[0] == "diag2"
          for i in (0..2) do
            return i*3 + 2-i+1 if board[i][2-i] == "."
          end
        end
      end


      # Step 4: Block fork. (If the opponent controls opposite corners, the AI should create two in a row in the middle row or middle column.)
      tlc = board[0][0] #1
      trc = board[0][2] #3
      mm = board[1][1]  #5
      blc = board[2][0] #7
      brc = board[2][2] #9

      return 6 if ((trc == "O" and blc == "O") or (tlc == "O" and brc == "O")) and board[1][2] == "." and @game.legal_move? 6
      return 4 if ((trc == "O" and blc == "O") or (tlc == "O" and brc == "O")) and board[1][0] == "." and @game.legal_move? 4
      return 2 if ((trc == "O" and blc == "O") or (tlc == "O" and brc == "O")) and board[2][1] == "." and @game.legal_move? 2
      return 8 if ((trc == "O" and blc == "O") or (tlc == "O" and brc == "O")) and board[0][1] == "." and @game.legal_move? 8


      # Step 5: Set-up Fork. (Create an opportunity so that AI can force a win by having two separate winning rows.)
      # Step 5.1: If AI owns a corner and human owns the center, AI takes the opposite corner
      return 9 if tlc == "X" and mm == "O" and @game.legal_move? 9
      return 7 if trc == "X" and mm == "O" and @game.legal_move? 7
      return 3 if blc == "X" and mm == "O" and @game.legal_move? 3
      return 1 if brc == "X" and mm == "O" and @game.legal_move? 1

      # Step 5.2: If AI owns a corner and human owns opposite corner, AI takes a corner
      return 3 if tlc == "X" and brc == "O" and @game.legal_move? 3
      return 7 if tlc == "X" and brc == "O" and @game.legal_move? 7
      return 1 if trc == "X" and blc == "O" and @game.legal_move? 1
      return 9 if trc == "X" and blc == "O" and @game.legal_move? 9
      return 1 if blc == "X" and trc == "O" and @game.legal_move? 1
      return 9 if blc == "X" and trc == "O" and @game.legal_move? 9
      return 3 if brc == "X" and tlc == "O" and @game.legal_move? 3
      return 7 if brc == "X" and tlc == "O" and @game.legal_move? 7


      # Step 6: Center. (AI marks the dead center, if it is available and if it's not the first move of the game.)
      return 5 if board[1][1] == "." and @game.legal_move? 5 and total_dots < 9


      # Step 7: Opposite Corner. (If the opponent is in a corner, the AI plays the opposite corner.)
      return 9 if tlc == "O" and @game.legal_move? 9
      return 7 if trc == "O" and @game.legal_move? 7
      return 3 if blc == "O" and @game.legal_move? 3
      return 1 if brc == "O" and @game.legal_move? 1


      # Step 8: Empty Corner. (The AI plays in a corner square.)
      return 1 if @game.legal_move? 1
      return 3 if @game.legal_move? 3
      return 7 if @game.legal_move? 7
      return 9 if @game.legal_move? 9


      # Step 9: Empty Side. (The AI plays in the middle of any of the four sides.)
      return 2 if @game.legal_move? 1
      return 4 if @game.legal_move? 1
      return 6 if @game.legal_move? 1
      return 8 if @game.legal_move? 1


      raise "Move error".inspect          # This line shouldn't execute, so if we get here, we have a problem.
    end
  end
end