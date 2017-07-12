require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  possible_paths = PriorityMap.new { |v1, v2| v1[:cost] <=> v2[:cost] }
  shortest_paths = {}

  possible_paths[source] = { cost: 0, last_edge: nil }

  while !possible_paths.empty?
    current_vertex, obj = possible_paths.extract
    current_cost = obj[:cost]
    current_vertex.out_edges.each do |edge|
      next_vertex = edge.to_vertex
      new_cost = edge.cost + current_cost
      if possible_paths.has_key?(next_vertex)
        if possible_paths[next_vertex][:cost] > new_cost
          possible_paths[next_vertex] = { cost: new_cost, last_edge: edge }
        end
      else
        possible_paths[next_vertex] = { cost: new_cost, last_edge: edge }
      end
    end
    shortest_paths[current_vertex] = obj
  end

  shortest_paths

end
