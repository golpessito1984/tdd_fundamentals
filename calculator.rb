require "rspec/autorun"

# calc = Calculator.new
# calc.add(5, 10) # => 15

class Calculator 
  def add(num1, num2) 
    num1 + num2 
  end
end

describe Calculator do 
  describe "#add" do
    it "returns the sum of its two arguments" do 
      calc = Calculator.new
      expect(calc.add(5, 10)).to eq(15)
    end
  end
end
