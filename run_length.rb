def encode(bv)
  code = []
  last = bv[0]
  code.push last
  count = 0

  bv.split("").each do |c|
    if c != last 
      code.push count
      count = 1 
    else 
      count += 1
    end
    last = c
  end
  code.push count
  code.join
end

def decode(e)
  current = e[0]
  final = []

  e[1..e.length].split("").each do |r|
    r.to_i.times { final.push current } 
    current = (current == "0") ? "1" : "0"
  end
  final.join
end

# Looked into Ruby's assertion functions but didn't really feel like importing
# It was less work to just write one myself than figure all that out
def assert_equal(exp1, exp2)
  if exp1 == exp2
    puts "Assertion passed!"
    true
  else 
    puts "Assertion failed"
    puts "Expected #{exp1} but got #{exp2}"
    nil
  end
end

def encode_tests
  tests = {
    "000111" => "033",
    "0011" => "022", 
    "01" => "011", 
    "1100111" => "1223", 
    "11100010" => "13311"
  }
  tests.each do |k,v|
    assert_equal encode(k), v
  end
end

def decode_tests
  tests = [ 
    "000111",
    "0011",
    "01",
    "1100111",
    "11100010"
    ] 
  tests.each do |v|
    assert_equal(v, decode(encode(v)))
  end
end

def saved(bv)
  diff = bv.length- encode(bv).length
  percent_reduction = (1 - (bv.length - diff).to_f/bv.length) * 100
  puts "Original Length: #{bv.length}"
  puts "Encoded Length: #{encode(bv).length}"
  puts "Characters saved: #{diff}"
  puts "Percent Reduction: #{percent_reduction}%"
  diff
end

def performance_test(params = {})
  length_bv = params[:length] ? params[:length] : rand(1000..10000).to_i 
  distribution = params[:distribution] ? params[:distribution] : rand
  bv = ""
  length_bv.times do
    if rand > distribution
      bv += "0" 
    else bv += "1"
    end
  end
  puts "Distribution: #{distribution}"
  saved bv
end


=begin
end
=begin
  bit vector "0001110011"
  should output bitvector where first bit is the first bit of the vector
  then it has the number of bits that goes for, until the end.

  So above would be: 03322

  0101010 is
  0 111111
=end
