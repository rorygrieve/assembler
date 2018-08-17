require "main"

RSpec.describe Main do
  subject(:main) { Main.new(parser: parser, translator: translator) }
  let(:parser) { double(:parser, call: "some parsed code") }
  let(:translator) { double(:translator, call: nil) }

  describe "#call" do
    it "passes the file to the parser" do
      main.call("spec/fixtures/Add.asm")

      expect(parser).to have_received(:call).with("spec/fixtures/Add.asm")
    end

    it "passes the file to the translator" do
      main.call("spec/fixtures/Add.asm")

      expect(translator).to have_received(:call).with("some parsed code")
    end
  end
end
