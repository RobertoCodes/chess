class Piece

  attr_reader :name, :color
  attr_accessor :pos, :board

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
