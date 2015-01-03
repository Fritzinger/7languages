File.open(ARGV[0]).readlines.each_with_index do |l, i|
  if l =~ Regexp.new(ARGV[1])
    puts "#{i}: #{l}"
  end
end

