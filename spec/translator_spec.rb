require "translator"

RSpec.describe Translator do
  subject(:translator) { Translator.new }

  describe "#call" do
    it "converts numeric symbols" do
      code = ["@5"]

      expect(translator.call(code)).to eq(["0000000000000101"])
    end

    context "c instructions" do
      it "converts C instructions with a destination" do
        code = ["D=A"]

        expect(translator.call(code)).to eq(["1110110000010000"])
      end

      it "converts c instructions with a jump" do
        code = ["D;JGT"]

        expect(translator.call(code)).to eq(["1110001100000001"])
      end
    end
  end
end
