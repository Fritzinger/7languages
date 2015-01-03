#Modify earlier Tree class initializer to accept a nested structure of hashes
class Tree
  attr_accessor :children, :node_name

  def initialize(hash)
    @node_name, child_contents = hash.each.next #assume top level of hash only has one key
    @children  = child_contents.map {|k,v| Tree.new(k => v)}
  end

  def visit_all(&block)
    visit &block
    @children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new({'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {}, 'child 3' => {}}}})

puts "Visiting a node:"
ruby_tree.visit {|node| puts node.node_name}
puts "Visiting entire tree:"
ruby_tree.visit_all {|node| puts node.node_name}
