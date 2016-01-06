class Bishop < SlidingPiece

  MOVES = [[-1,1],[1,1],[-1,-1],[1,-1]]

  def initialize(color, pos, board)
    if color == :black
      name = ["265D".hex].pack("U")
    else
      name = ["2657".hex].pack("U")
    end

    super(color, pos, board, name)

  end

end
