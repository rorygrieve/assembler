require "translator"

RSpec.describe Translator do
  subject(:translator) { Translator.new }

  describe "#call" do
    it "converts numeric symbols" do
      code = ["@5"]

      expect(translator.call(code)).to eq(["0000000000000101"])
    end

    it "converts C instructions" do
      code = ["D=A"]

      expect(translator.call(code)).to eq(["1110110000010000"])
    end
  end
end
