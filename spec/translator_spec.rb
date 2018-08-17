require "translator"

RSpec.describe Translator do
  subject(:translator) { Translator.new }

  describe "#call " do
    it "converts numeric symbols" do
      code = ["@5"]

      expect(translator.call(code)).to eq(["0000000000000101"])
    end
  end
end
