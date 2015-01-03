# Ruby Day 3:
# Modify the CSV application to support an each method to return a CsvRow
# object. Use method_missing on that CsvRow to return the value for the column
# for a give heading
# For example, for the file:
#   one, two
#   lions, tigers
# Allow an API that works like this:
# csv = RubyCsv.new
# csv.each {|row| puts row.one} # prints "lions"
#
module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      filename = "#{self.class.to_s.downcase}.txt"
      file = File.new(filename)
      @headers = file.gets.chomp.split(',')
      # calling each on file runs the block once for each line of the file
      # (actually a method on superclass IO
      file.each do |row|
        @csv_contents << row.chomp.split(',')
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

    def each
      csv_contents.each do |row|
        yield CsvRow.new(col_names: @headers, row_values: row)
      end
    end
  end
end

class CsvRow
  attr_reader :values

  def initialize(col_names:, row_values:)
    @values = {}
    col_names.each_with_index do |c, i|
      values[c.to_sym] = row_values[i]
    end
  end


  def method_missing name, *args, &blk
    if @values.fetch(name.to_sym, false)
      @values[name.to_sym]
    else
      super
    end
  end
end

class RubyCsv #no inheritance apart from mixins
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
p m.headers
p m.csv_contents
m.each {|row| p row.c}
