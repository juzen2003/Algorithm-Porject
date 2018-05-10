require_relative 'graph'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's Algorithm
def topological_sort(vertices)
  queue = []
  sorted = []

  vertices.each do |vertex|
    queue << vertex if vertex.in_edges == []
  end

  until queue.empty?
    edges = []
    current_vertex = queue.shift
    sorted << current_vertex

    current_vertex.out_edges.each do |edge|
      edge.to_vertex.in_edges.delete(edge)
      if edge.to_vertex.in_edges.empty?
        queue << edge.to_vertex
      end
      edges << edge
    end
    edges.each {|edge| edge.destroy!}
    # if we remove from graph then we need to check the length of vertices (=0) to make sure all vertices are sorted
    # vertices.delete(current_vertex)
  end

  if vertices.length == sorted.length
    sorted
  else
    []
  end

end

# Tarjan's Algorithm (without catching cycle)
def topological_sort_tarjan(vertices)
  order =[]
  explored = Set.new

  vertices.each do |vertex|
    dfs!(order, explored, vertex) unless explored.include?(vertex)
  end
end

def dfs!(order, explored, vertex)
  explored.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    dfs!(order, explored, to_vertex) unless explored.include?(to_vertex)
  end

  order.unshift(vertex)
end

#  Tarjan's Algorithm with cycle catching
def topological_sort_tarjan_cycle(vertices)
  order =[]
  explored = Set.new
  cycle = false
  temp = Set.new

  vertices.each do |vertex|
    cycle = dfs_cycle!(order, explored, vertex, cycle, temp) unless explored.include?(vertex)

    return [] if cycle
  end
end

def dfs_cycle!(order, explored, vertex, cycle, tmep)
  temp.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    cycle = dfs_cycle!(order, explored, to_vertex, cycle, temp) unless explored.include?(to_vertex)
    return true if cycle
  end

  temp.delete(vertex)
  explored.add(vertex)
  order.unshift(vertex)
end


# #  Tarjan's Algorithm
# def topological_sort(vertices)
#   sorted = []
#   visited = []
#
#   vertices.each do |vertex|
#     sorted = visit(vertex, sorted, visited)
#   end
#   sorted
#
# end
#
# def visit(vertex, sorted, visited)
#   return sorted if visited.include?(vertex)
#
#   vertex.out_edges.each do |edge|
#     # return[] if visited.include?(edge.to_vertex)
#     sorted = visit(edge.to_vertex, sorted, visited)
#   end
#
#   visited << vertex
#   sorted.unshift(vertex)
# end
