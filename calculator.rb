require "rspec/autorun"

# calc = Calculator.new
# calc.add(5, 10) # => 15

class Calculator 
  def add(num1, num2) 
    num1 + num2 
  end
  
  def factorial(n)
    # Recursive solution problem with large numbers
    #return 1 if n <= 0
    #return n * factorial(n-1)
    return 1 if n <= 0
    (1 .. n).reduce(:*)
  end
end

describe Calculator do 
  describe "#add" do
    it "returns the sum of its two arguments" do 
      calc = Calculator.new
      expect(calc.add(5, 10)).to eq(15)
    end
    it "returns the sum of tow differents arguments" do 
      calc = Calculator.new
      expect(calc.add(34,12)).to eq(46)
    end
  end
  
  describe "#factorial" do 
    it "returns 1 when given 0" do 
      calc = Calculator.new
      expect(calc.factorial(0)).to eq(1)
 
    end

    it "returns 120 when given 5" do 
      calc = Calculator.new
      expect(calc.factorial(5)).to eq(120)
    end
  end
end
