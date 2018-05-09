class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
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

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
