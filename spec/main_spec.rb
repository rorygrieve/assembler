require "main"

RSpec.describe Main do
  subject(:main) { Main.new(parser: parser, translator: translator, symbol_adder: symbol_adder) }
  let(:parser) { double(:parser, call: "some parsed code") }
  let(:symbol_adder) { double(:symbol_adder, call: nil) }
  let(:translator) { double(:translator, call: "some binary") }

  describe "#call" do
    before do
      allow(File).to receive(:open).and_return("something")
      main.call("spec/fixtures/Add.asm")
    end

    it "passes the file to the parser" do
      expect(parser).to have_received(:call).with("spec/fixtures/Add.asm")
    end

    it "passes the parsed code to the symbol adder" do
      expect(symbol_adder).to have_received(:call).with("some parsed code")
    end

    it "passes the file to the translator" do
      expect(translator).to have_received(:call).with("some parsed code")
    end

    it "creates a file with translated code" do
      expect(File).to have_received(:open).with("lib/output/Add.hack", "w+")
    end
  end
end
