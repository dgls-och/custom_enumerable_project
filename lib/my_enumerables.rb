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
end

class Array
end
