class Piece

  attr_reader :name, :board, :color
  attr_accessor :pos

  def initialize(name, color, pos, board)
    @name = name
    @color = color
    @pos = pos
    @board = board
  end



end


class SlidingPiece < Piece

  def initialize
    super
  end

  def moves
    possible_moves = []
    self.class::MOVES.each do |move|
      x = self.pos[0]
      y = self.pos[1]
      while x.between?(0,7) && y.between?(0,7)
        x += move[0]
        y +=  move[1]
        if x.between?(0,7) && y.between?(0,7) && !board.board[x,y].nil?
          if self.color == board.board[x][y].color
            break
          else
            possible_moves << [x,y]
            break
          end
        else
          possible_moves << [x,y] if x.between?(0,7) && y.between?(0,7)
        end
      end
    end
    possible_moves
  end
end












class SteppingPiece < Piece

  def moves
    possible_moves = []
    self.class::MOVES.each do |move|
      x = self.pos[0]
      y = self.pos[1]
      while x.between?(0,7) && y.between?(0,7)
          x += move[0]
          y +=  move[1]
          possible_moves << [x,y] if x.between?(0,7) && y.between?(0,7)
      end
    end
    possible_moves.select { |move| board[move[0]][move[1]].nil? ||
      board[move[0]][move[1]].color != self.color }
  end

end



class Bishop < SlidingPiece

  MOVES = [[1,1],[-1,1],[-1,-1],[1,-1]]

  def initialize(name ="B", color, pos, board)
    super
  end

end


class Rook < SlidingPiece

  MOVES = [[1,0],[0,1],[-1,0],[0,-1]]

end


class Queen < SlidingPiece
end


class Knight < SteppingPiece
end


class Pawn < SteppingPiece
end
