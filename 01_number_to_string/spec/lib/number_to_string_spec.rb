require "number_to_string"

describe "NumberStringifier" do
  let(:stringifier) { NumberStringifier.new }

  describe "create_string" do
    it "should work with a single digit number" do
      expect(stringifier.create_string(1)).to eq("one")
    end

    it "should work with a double digit number" do
      expect(stringifier.create_string(64)).to eq("sixty four")
    end

    it "should work with a quadruple digit number" do
      expect(stringifier.create_string(3247)).to eq("three thousand two hundred forty seven")
    end

    it "should work with a number in the millions" do
      expect(stringifier.create_string(16924922)).to eq("sixteen million nine hundred twenty four thousand nine hundred twenty two")
    end

    it "should work with a float" do
      expect(stringifier.create_string(12.05)).to eq("twelve and 05/100")
    end
  end
end