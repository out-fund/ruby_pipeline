# frozen_string_literal: true

class TestSuccessStep
  def self.process(number)
    number * 2
  end
end

class TestFailureStep
  def self.process(_number)
    nil
  end
end
