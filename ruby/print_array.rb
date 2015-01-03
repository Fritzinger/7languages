arr = (1..16).to_a
#print the contents of an array of sixteen numbers, four numbers at a time, 
#using just each.
#method 1 temporary array
puts "METHOD 1"
tmp = []
arr.each do |v|
  tmp << v
  if tmp.length == 4
    p tmp
    tmp = []
  end
end

#method 2 use next on each enumerator
puts "METHOD 2 enum from internal iterator (each) without block"
enum = arr.each
4.times {p [enum.next, enum.next, enum.next, enum.next]}

#Now do the same with each_slice in Enumerable
puts "each_slice(4) iterates gropus of 4 elements"
arr.each_slice(4) {|slice| p slice}
