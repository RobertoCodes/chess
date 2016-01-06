class Rook < SlidingPiece

  MOVES = [[1,0],[0,1],[-1,0],[0,-1]]

  def initialize(color, pos, board)
    if color == :black
      name = ["265C".hex].pack("U")
    else
      name = ["2656".hex].pack("U")
    end
    super(color, pos, board, name)
  end

end
