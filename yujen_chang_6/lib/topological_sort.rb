require_relative 'graph'

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
