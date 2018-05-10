class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    # @super_frog_cache = {
    #   1 => [[1]],
    #   2 => [[1,1], [2]],
    #   3 => [[1,1,1], [1,2], [2,1], [3]]
    # }

    @maze_cache = []
  end

  def blair_nums(n)
    # top-down
    # return @blair_cache[n] unless @blair_cache[n].nil?
    #
    # ans = blair_nums(n-1) + blair_nums(n-2) + ((n-1) * 2 - 1)
    # @blair_cache[n] = ans
    # @blair_cache[n]

    # bottom-up
    cache = blair_cache_builder(n)
    cache[n]
  end

  #  for bottom-up
  def blair_cache_builder(n)
    cache = {1 => 1, 2 => 2}
    return cache if n < 3
    (3..n).each do |i|
      cache[i] = cache[i-1] + cache[i-2] + ((i-1) * 2 - 1)
    end

    cache
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    return cache if n < 4

    (4..n).each do |i|
      cache1 = cache[i-1].map {|el| el + [1]}
      cache2 = cache[i-2].map {|el| el + [2]}
      cache3 = cache[i-3].map {|el| el + [3]}
      cache[i] = cache1 + cache2 + cache3
    end

    cache
  end

  def frog_hops_top_down(n)
    ans = frog_hops_top_down_helper(n)
    @frog_cache[n] = ans
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?

    cache1 = frog_hops_top_down_helper(n-1).map {|el| el + [1]}
    cache2 = frog_hops_top_down_helper(n-2).map {|el| el + [2]}
    cache3 = frog_hops_top_down_helper(n-3).map {|el| el + [3]}
    ans = cache1 + cache2 + cache3
    ans
  end

  def super_frog_hops(n, k)
    #  bottom-up
    cache = super_frog_hops_cache_builder(n, k)
    cache[n]
  end

  def super_frog_hops_cache_builder(n, k)
    #  this is extending from frog_cache_builder (fix k = 3) bottom-up
    cache = { 0 => [[]], 1 => [[1]]}
    return cache if n == 1
    k = n if k > n

    (2..n).each do |num|
      value = []
      (1..k).each do |k_num|
        if k_num <= num
          temp_cache = cache[num - k_num].map {|el| el + [k_num]}
          value += temp_cache
        end
      end
      cache[num] = value
    end
    cache
  end

  def knapsack(weights, values, capacity)
    cache = knapsack_table(weights, values, capacity)
    cache[-1][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    int_length = weights.length
    cache = Array.new(capacity + 1) {Array.new(int_length)}
    cache[0] = [0] * int_length

    (1..capacity).each do |current_cap|
      (0..int_length-1).each do |len|
        if len == 0
          prev_val = 0
        else
          prev_val = cache[current_cap][len-1]
        end
        current_val = values[len]

        # for each item consideration:
        # (1) previous item's value at current capacity
        # (2) previous item's solution from smaller bag (capacity - current_capacity) + current_item value
        # for first item, it's always itself
        if weights[len] <= current_cap
          if len == 0
            val = values[len]
          else
            prev_idx = current_cap - weights[len]

            prev_sol = cache[prev_idx][len-1]
            val = (current_val + prev_sol) > prev_val ? (current_val + prev_sol) : prev_val
          end

        else
          val = prev_val
        end
        cache[current_cap][len] = val
      end
    end
    # p cache
    cache
  end

  def maze_solver(maze, start_pos, end_pos)
    @maze_cache << start_pos if @maze_cache[-1] != start_pos
    return [start_pos] if start_pos == end_pos

    # row = start_pos[0]
    # col = start_pos[1]
    row, col = start_pos
    max_row = maze.length
    max_col = maze[0].length

    # use "P" to mark the visited point so that we don't re-visit again
    if ["F", " "].include?(maze[row][col + 1]) && (col + 1) <= max_col
      maze[row][col + 1] = "P"
      maze_solver(maze, [row, col + 1], end_pos)
    elsif ["F", " "].include?(maze[row + 1][col]) && (row + 1) <= max_row
      maze[row + 1][col] = "P"
      maze_solver(maze, [row + 1, col], end_pos)
    elsif ["F", " "].include?(maze[row][col - 1])
      maze[row][col - 1] = "P"
      maze_solver(maze, [row, col - 1], end_pos) && (col-1) >= 0
    elsif ["F", " "].include?(maze[row - 1][col]) && (row-1) >= 0
      maze[row - 1][col] = "P"
      maze_solver(maze, [row - 1, col], end_pos)
    else
      # no where to go, we go back to previous point and visit other " " or "F" points ("P" would not be re-visit), if still no where to go, we move back again to previous points in @maze_cache
      @maze_cache.pop
      maze_solver(maze, @maze_cache[-1], end_pos)
    end

    @maze_cache
  end

end

# d = DynamicProgramming.new
# m = [['X', 'X', 'X', 'X'],
#     ['X', 'S', ' ', 'X'],
#     ['X', 'X', 'F', 'X']]
# start_pos = [1,1]
# end_pos = [2,2]
# p d.maze_solver(m, start_pos, end_pos)

# values = [1,3,3]
# weights = [2,3,4]
# capacity = 7
# puts d.knapsack(weights, values, capacity)
# p d.knapsack_table(weights, values, capacity)
# # [[0, 0, 0], [0, 0, 0], [1, 1, 1], [1, 3, 3], [1, 3, 3], [1, 4, 4], [1, 4, 4], [1, 4, 6]]
