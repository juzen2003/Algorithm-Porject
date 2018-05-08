# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  no_dependencies = (1..arr.flatten.max).to_a - arr

  hsh = {}
  arr.each do |package|
    hsh[package[0]] = Vertex.new(package[0]) if hsh[package[0]] == nil
    hsh[package[1]] = Vertex.new(package[1]) if hsh[package[1]] == nil
    Edge.new(hsh[package[1]], hsh[package[0]])
  end

  no_dependencies.each do |package|
    hsh[package] = Vertex.new(package) if hsh[package] == nil
  end

  sorted = topological_sort(hsh.values)
  sorted.map do |el|
    el.value
  end
end
