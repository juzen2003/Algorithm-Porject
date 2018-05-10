require_relative 'graph'
require_relative 'topological_sort'

def install_order2(arr)
  vertices = Hash.new
  list = arr.flatten.uniq
  list.each do |el|
    vertices[el] = Vertex.new(el)
  end

  no_dependecies = []
  arr.each do |to, from|
    if from == nil
      no_dependecies << to
    else
      Edge.new(from, to)
    end
  end
  dependencies = topological_sort(vertices.values).map {|vert| vert.value}
  sorted = no_dependecies + dependencies

end

arr = [["mocha", "browserify"], ["bower", "browserify"], ["browserify", nil]]

p install_order2(arr)
