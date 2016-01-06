class SlidingPiece < Piece

  def moves
    possible_moves = []
    self.class::MOVES.each do |move|
      x = self.pos[0]
      y = self.pos[1]
      while x.between?(0,7) && y.between?(0,7)
        x += move[0]
        y +=  move[1]
        test_pos = [x,y]
        if (x.between?(0,7) && y.between?(0,7)) && !self.board[test_pos].nil?
          if self.color == self.board[test_pos].color
            break
          else
            possible_moves << test_pos
            break
          end
        else
          possible_moves << test_pos if x.between?(0,7) && y.between?(0,7)
        end
      end
    end
    possible_moves
  end

end
