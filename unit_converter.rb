require "rspec/autorun"

# UnitConverter.new.convert(2, :cup, :liter) # => 0.473
# UnitConverter.new.convert(2, :cup, :gram) # => DimensionMismatchError!!!

DimensionMismatchError = Class.new(StandardError)
Quantity = Struct.new(:amount, :unit)

class UnitConverter
  def initialize(initial_quantity, target_unit)
    @initial_quantity = initial_quantity
    @target_unit = target_unit
  end

  def convert
    Quantity.new(
    @initial_quantity.amount * (conversion_factor(from: @initial_quantity.unit, to: @target_unit)),
    @target_unit)
  end

  private

  CONVERSION_FACTORS = {
    liter: {
      cup: 4.226775,
      liter: 1,
      pint: 2.11338
    },
    gram: {
      gram: 1,
      kilgram: 0.001
    }
  }

  def conversion_factor(from:, to:)
    dimension = common_dimension(from, to)
    raise(DimensionMismatchError, "Can't convert from #{from} to #{to}!") unless dimension
    CONVERSION_FACTORS[dimension][to] / CONVERSION_FACTORS[dimension][from]
  end

  def common_dimension(from, to)
    CONVERSION_FACTORS.keys.find do |canonical_unit|
      CONVERSION_FACTORS[canonical_unit].keys.include?(from) &&
      CONVERSION_FACTORS[canonical_unit].keys.include?(to)
    end
  end

end

describe UnitConverter do
  describe "#convert" do

    it "can convert between quantities of the same unit" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :cup)
      result = converter.convert
      expect(result.amount).to be_within(0.001).of(2)
      expect(result.unit).to eq(:cup)
    end

    it "translates between objects of the same dimension" do
      # First test
      # converter = UnitConverter.new(2, :cup, :liter)
      # expect(converter.convert).to be_within(0.001).of(0.473)

      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :liter)
      result = converter.convert
      expect(result.amount).to be_within(0.001).of(0.473)
      expect(result.unit).to eq(:liter)
    end

    it "raises a error if the two quantities are of differing dimensions" do
      # First test
      # converter = UnitConverter.new(2, :cup, :gram)
      # expect{ converter.convert }.to raise_error(DimensionMismatchError)

      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :gram)
      expect{ converter.convert }.to raise_error(DimensionMismatchError)
    end
  end
end
