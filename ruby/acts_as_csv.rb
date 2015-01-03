class ActsAsCsv
  def read
    file = File.new("#{self.class.to_s.downcase}.txt")
    @headers = file.gets.chomp.split(', ') # .gets takes the first line, chomp
    #without args removes trailing newline, split does what we expect

    file.each do |row|
      @result << row.chomp.split(', ')
    end
  end

  def headers
    @headers
  end

  def csv_contents
    @result
  end

  def initialize
    @result = []
    read
  end
end
