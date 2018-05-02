class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_val = 0
    self.each_with_index do |el, idx|
      hash_val += ((idx + 1)*10) ^ el.hash
    end

    hash_val
  end
end

class String
  def hash
    hash_val = 0
    self.chars.each_with_index do |chr, idx|
      hash_val += ((idx + 1)*10) ^ chr.ord.hash
    end

    hash_val
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_val = 0
    self.each do |k, v|
      hash_val += (k.hash * v.hash)
    end

    hash_val
  end
end
