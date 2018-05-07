require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  sorted = []


  vertices.each do |vertex|

    queue << vertex if vertex.in_edges == []

  end


  until queue.empty?
    current_vertex = queue.shift
    sorted << current_vertex


    current_vertex.out_edges.each do |edge|
      edge.to_vertex.in_edges.delete(edge)
      if edge.to_vertex.in_edges.empty?
        queue << edge.to_vertex
      end
      #  can't have this destroy, otherwise it would fail
      # edge.destroy!
    end
    # if we remove from graph then we need to check the length of vertices (=0) to make sure all vertices are sorted
    # vertices.delete(current_vertex)
  end

  if vertices.length == sorted.length
    sorted
  else
    []
  end

end
