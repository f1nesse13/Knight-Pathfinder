require_relative 'polytree'
class KnightPathFinder
  include Searches
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
      new_pos = [mx + px, my + py]
      if new_pos.all? { |val| val.between?(0, 7) }
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

  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(node)
    path_array = []
    node_array = [node]
    unless node.value == start_pos
      node = node_array.first
      node_array << trace_path_back(node.parent)
    end
    path_array << node.value
    p path_array
  end

  def build_move_tree
    self.root_node = PolyTreeNode.new(start_pos)
    nodes = [root_node]

    until nodes.empty?
      current_node = nodes.shift
      current_pos = current_node.value
      new_move_pos(current_pos).each do |child|
        new_node = PolyTreeNode.new(child)
        current_node.add_child(new_node)
        nodes << new_node
      end
    end

  end
  
  def new_move_pos(pos)
    new_positions = KnightPathFinder.valid_moves(pos)
    new_positions.reject! { |pos| @considered_positions.include?(pos) }
    new_positions.each { |pos| @considered_positions << pos }
    new_positions
  end

  attr_accessor :root_node, :considered_positions

  end

  if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0, 0])
    kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
    kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
  end