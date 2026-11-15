module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    indices = (0..self.length - 1)
    for index in indices
      yield(self[index]) unless self.is_a?(Hash)
      yield(index, self[index]) if self.is_a?(Hash)
    end

    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    indices = (0..self.length - 1)
    for index in indices
      yield(self[index], index)
    end

    self
  end

  def my_select
    selected = []
    return to_enum(:my_select) unless block_given?

    indices = (0..self.length - 1)
    for index in indices
      selected << self[index] if yield(self[index])
    end

    selected
  end
end

class Array
end
