require_relative 'polytree'
class Knightpathfinder
  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]
  def self.valid_moves(pos)
    valid_moves = []
    px, py = pos
    MOVES.each do |(mx, my)|
      new_pos = [(mx - px), (my-py)]
      valid_moves << new_pos
    end
    valid_moves
  end
  def initialize(start_position=[0,0])
    @position = position
    self.root_node = PolyTreeNode.new(start_position)
  end


  end