require "main"

RSpec.describe Main do
  subject(:main) { Main.new(parser: parser, translator: translator) }
  let(:parser) { double(:parser, call: nil) }
  let(:translator) { double(:translator) }

  describe "#call" do
    it "passes the file to the parser" do
      main.call("spec/fixtures/Add.asm")

      expect(parser).to have_received(:call).with("spec/fixtures/Add.asm")
    end
  end
end
