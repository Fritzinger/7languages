# Ruby day 2
# How would you translate a hash to an array
h = {a: 2, b: 3, c: 4}
# method 1 keys.each_with_index
arr = []
h.keys.each_with_index do |k, i|
  arr[i*2] = k
  arr[i*2 + 1] = h[k]
end
p arr
# method 2 each_pair (or just each)
arr = []
h.each do |k,v|
  arr << k
  arr << v
end
p arr
# method 3 built in flatten
p h.flatten


