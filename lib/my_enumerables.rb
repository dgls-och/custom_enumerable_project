module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    (self.length - 1).times do |index|
      yield(self[index]) unless self.is_a?(Hash)
      yield(index, self[index]) if self.is_a?(Hash)
    end

    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    (self.length - 1).times do |index|
      yield(self[index], index)
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    (self.length - 1).times do |index|
      selected << self[index] if yield(self[index])
    end

    selected
  end

  def my_all?
    return to_enum(:my_all) unless block_given?

    (self.length - 1).times do |index|
      return false unless yield(self[index])
    end

    true
  end
end

class Array
end
