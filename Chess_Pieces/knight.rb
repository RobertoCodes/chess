class Knight < SteppingPiece

  MOVES = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

  def initialize(color, pos, board, name ="N")
    if color == :black
      name = ["265E".hex].pack("U")
    else
      name = ["2658".hex].pack("U")
    end

    super(color, pos, board, name)

  end

end
