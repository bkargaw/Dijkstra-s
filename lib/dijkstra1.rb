require_relative 'graph'
require 'byebug'
# O(|V|**2 + |E|).
def dijkstra1(source)
  possible_paths = {}
  shortest_paths = {}

  possible_paths[source] = { cost: 0, last_edge: nil }

  while !possible_paths.empty?
    current_vertex = get_vertex(possible_paths)
    current_cost = possible_paths[current_vertex][:cost]
    current_vertex.out_edges.each do |edge|
      next_vertex = edge.to_vertex
      new_cost = edge.cost + current_cost
      if possible_paths[next_vertex]
        if possible_paths[next_vertex][:cost] > new_cost
          possible_paths[next_vertex] = { cost: new_cost, last_edge: edge }
        end
      else
        possible_paths[next_vertex] = { cost: new_cost, last_edge: edge }
      end
    end
    shortest_paths[current_vertex] = possible_paths[current_vertex]
    possible_paths.delete(current_vertex)
  end

  shortest_paths

end

def get_vertex possible_paths
  min_vertex = nil
  min_cost = 1.0 / 0
  possible_paths.each do |k, v|
    min_vertex = k if v[:cost] < min_cost
  end
  min_vertex
end
