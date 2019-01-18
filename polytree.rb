module Searches
  # !Split into its own module after seeing solution - module might serve me in the future
  def dfs(target=nil, &prc)
    raise "Need a block or specify a target" if [target, prc].none?
    prc ||= Proc.new { |node| node.value == target }

    return self if prc.call(self)

    children.each do |child|
      result = child.dfs(&prc)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target, &prc)
    raise "Need a block or specify a target" if [target, prc].none?
    prc ||= Proc.new { | node | node.value == target }

    nodes = [self]

    until nodes.empty?
      node = nodes.shift
      return node if prc.call(node)
      node.children.each { |child| nodes << child }
    end
    nil
  end

def count
  1 + children.map(&:count).inject(:+)
  end

end

class PolyTreeNode
  include Searches

  attr_accessor :value
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def children
    @children.dup
  end

  def parent=(parent)
    return if self.parent == parent
    if self.parent
      self.parent._children.delete(self) 
    end

    @parent = parent
    self.parent._children << self unless self.parent.nil?

    self
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if child && !self.children.include?(child)
      raise 'Tried to remove node thats not a child'
    end

    child.parent = nil
  end

  def _children
    @children
  end

  
end