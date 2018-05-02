require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hsh = HashMap.new

  string.chars.each do |chr|
    if hsh[chr] != nil
      hsh[chr] += 1
    else
      hsh[chr] = 1
    end
  end

  str_length = string.length
  odd_el_num = 0

  hsh.each do |chr, count|
    # even string
    if str_length % 2 == 0
      odd_el_num += 1 if count % 2 == 1
      return false if odd_el_num != 0
    else # odd string
      odd_el_num += 1 if count % 2 == 1
      return false if odd_el_num > 1
    end
  end

  true

  # p hsh
end
