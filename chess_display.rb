require 'colorize'
require_relative 'cursorable'
require_relative 'chess_board.rb'
require_relative 'chess_piece.rb'
require 'byebug'

class Display
  include Cursorable

  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
  end

  def render
    board.board.each_with_index do |row, i|
      row.each_with_index do |square, j|
        colors = colors_for(i,j)
        if !square.nil?
          print " #{square.name} ".colorize(colors)
          # p " #{square.name} "
        else
          print "   ".colorize(colors)
          # p "[ ]"
        end
      end
      puts
    end

    nil
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :white
    else
      bg = :black
    end
    { background: bg, color: :blue }
  end


end
# a= Board.new
# a.move([6,5],[5,5])
# a.move([1,4],[3,4])
# a.move([6,6],[4,6])
# a.move([0,3],[4,7])
#
# Display.new(a).render
