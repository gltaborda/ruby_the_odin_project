require './lib/calculator'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end
  
    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end
  describe "#multiply" do
    it "returns the product of two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(5,2)).to eql(10)
    end
    it "returns the product of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(5,2,3)).to eql(30)
    end
  end
  describe "#substract" do
    it "returns the result of a minus b" do
      calculator = Calculator.new
      expect(calculator.substract(5,2)).to eql(3)
    end
  end
  describe "#divide" do
    it "returns the result of a divided by b" do
      calculator = Calculator.new
      expect(calculator.divide(5,2)).to eql(2)
    end
  end
end