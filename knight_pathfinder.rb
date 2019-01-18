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
  attr_reader :start_pos

  def self.valid_moves(pos)
    valid_moves = []
    px, py = pos
    MOVES.each do |(mx, my)|
      new_pos = [(mx - px), (my-py)]
      if new_pos.all? { |val| val.between?(0, 8) }
        valid_moves << new_pos 
      end
    end
    valid_moves
  end
  
  def initialize(start_pos)
    @start_pos = start_pos
    @considered_positions = [start_pos]
    build_move_tree
  end
  def build_move_tree
    self.root_node = PolyTreeNode.new(start_pos)

  end
  
  def new_move_pos(pos)

  end

  attr_accessor :root_node, :considered_positions

  end

  a = Knightpathfinder.new([0,0])
  p a.valid_moves