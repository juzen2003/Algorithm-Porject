class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
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

  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
