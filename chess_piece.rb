class Piece

  attr_reader :name, :board, :color
  attr_accessor :pos

  def initialize(color, pos, board, name)
    @name = name
    @color = color
    @pos = pos
    @board = board
  end

  def valid_moves
    valid_moves = []

    self.moves.each do |move|
      test_board = board.deep_dup
      test_board.test_move(self.pos,move)

      valid_moves << move unless test_board.in_check?(self.color)
    end

    valid_moves
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
        if (x.between?(0,7) && y.between?(0,7)) && !self.board.board[x][y].nil?
          if self.color == self.board.board[x][y].color
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

    possible_moves.select { |move| board.board[move[0]][move[1]].nil? ||
      board.board[move[0]][move[1]].color != self.color }
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


class Pawn < Piece

  attr_accessor :first_move

  def initialize(color, pos, board, name = "P", first_move = true)
    super(color, pos, board, name)
    @first_move = first_move
  end



  def moves
    possible_moves = []

      if self.color == :black
        x = self.pos[0]
        y = self.pos[1]
        if first_move && board.board[x+2][y].nil?
          possible_moves << [x+2,y]
        end

        if board.board[x+1][y].nil?
          possible_moves << [x+1,y]
        end

        if !board.board[x+1][y-1].nil? && board.board[x+1][y-1].color == :white
          possible_moves << [x+1,y-1]
        end

        if !board.board[x+1][y+1].nil? && board.board[x+1][y+1].color == :white
            possible_moves << [x+1,y-1]
        end

      end

      if self.color == :white
        x = self.pos[0]
        y = self.pos[1]
        if first_move && board.board[x-2][y].nil?
          possible_moves << [x-2,y]
        end

        if board.board[x-1][y].nil?
          possible_moves << [x-1,y]
        end

        if !board.board[x-1][y-1].nil? && board.board[x-1][y-1].color == :black
          possible_moves << [x-1,y-1]
        end

        if !board.board[x-1][y+1].nil? && board.board[x-1][y+1].color == :black
            possible_moves << [x-1,y-1]
        end

      end
      possible_moves

  end
end
