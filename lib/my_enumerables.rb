module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    self.size.times do |index|
      yield(self[index]) unless self.is_a?(Hash)
      #yield(index, self[index]) if self.is_a?(Hash)
    end

    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    self.size.times do |index|
      yield(self[index], index)
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    self.size.times do |index|
      selected << self[index] if yield(self[index])
    end

    selected
  end

  def my_all?
    return true unless block_given?

    self.size.times do |index|
      return false unless yield(self[index])
    end

    true
  end

  def my_any?
    return self.empty? ? false : true unless block_given?

    self.size.times do |index|
      return true if yield(self[index])
    end

    false
  end

  def my_none?
    return self.empty? ? true : false unless block_given?

    self.size.times do |index|
      return false if yield(self[index])
    end

    true
  end

  def my_count
    return self.size unless block_given?

    counter = 0
    self.size.times do |index|
      counter += 1 if yield(self[index])
    end
    
    counter
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []
    self.size.times do |index|
      mapped << yield(self[index])
    end

    mapped
  end

  def my_inject(arg = nil)
    unless block_given?
      raise ArgumentError, 'no argument given (given 0, expected (1..2)' if arg.nil?
      
      unless arg.is_a?(String) || arg.is_a?(Symbol)
        raise TypeError, 'argument is not an instance of string or symbol'
      end
      
      if arg.is_a?(Symbol)
        #full implementation missing
        #for symbol to proc functionality
        return "Info: missing implementation for #{arg.class} to proc"
      end
      
      return nil
    end
    
    accumulator = arg.nil? ? self[0] : arg
    
    self.size.times do |i|
      break if self[i + 1].nil? && arg.nil?
      accumulator = yield(accumulator, self[i + 1]) if arg.nil?
      accumulator = yield(accumulator, self[i]) if accumulator.is_a?(Integer) || accumulator.is_a?(Float)
      accumulator = "#{yield(accumulator.to_i, self[i])}" if accumulator.is_a?(String) 
      #missing a hash and array usecase
    end
    
    accumulator
  end
end

class Array
end

a = [ 1, 2, 3, 4 ]
p a.my_inject('') { |acc, val| acc + val }