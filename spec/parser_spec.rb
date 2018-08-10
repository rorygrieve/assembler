require "parser"

RSpec.describe Parser do
  subject(:parser) { Parser.new }

  describe "#call" do
    it "reads the file" do
      asm_file = "somefile.asm"
      allow(IO).to receive(:readlines).with(asm_file).and_return([])
      parser.call(asm_file)

      expect(IO).to have_received(:readlines).with(asm_file)
    end
  end
end
