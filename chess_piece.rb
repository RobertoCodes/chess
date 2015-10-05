class Piece

  attr_reader :name, :board, :color
  attr_accessor :pos

  def initialize(color, pos, board,name)
    @name = name
    @color = color
    @pos = pos
    @board = board
  end

end


class SlidingPiece < Piece

  def moves
    possible_moves = []
    self.class::MOVES.each do |move|
      x = self.pos[0]
      y = self.pos[1]
      while x.between?(0,7) && y.between?(0,7)
        x += move[0]
        y +=  move[1]
        if (x.between?(0,7) && y.between?(0,7)) && !self.board[x][y].nil?
          if self.color == self.board[x][y].color
            next
          else
            possible_moves << [x,y]
            next
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
      x += move[0]
      y +=  move[1]
      possible_moves << [x,y] if x.between?(0,7) && y.between?(0,7)
    end
    
    possible_moves.select { |move| board[move[0]][move[1]].nil? ||
      board[move[0]][move[1]].color != self.color }
  end

end


class Bishop < SlidingPiece

  MOVES = [[-1,1],[1,1],[-1,-1],[1,-1]]

  def initialize(color, pos, board, name ="B")
    super
  end

end


class Rook < SlidingPiece

  MOVES = [[1,0],[0,1],[-1,0],[0,-1]]

  def initialize(color, pos, board, name ="R")
    super
  end

end


class Queen < SlidingPiece

  MOVES = [[1,0],[0,1],[-1,0],[0,-1],[-1,1],[1,1],[-1,-1],[1,-1]]

  def initialize(color, pos, board, name ="Q")
    super
  end

end

class King < SteppingPiece

  MOVES = [[1,0],[0,1],[-1,0],[0,-1],[-1,1],[1,1],[-1,-1],[1,-1]]

  def initialize(color, pos, board, name ="K")
    super
  end

end

class Knight < SteppingPiece

  MOVES = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

  def initialize(color, pos, board, name ="N")
    super
  end

end


class Pawn < SteppingPiece
end
