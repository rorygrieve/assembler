require "main"
require "parser"
require "translator"

RSpec.describe "Translate files" do
  context "a file without symbols is loaded", wip: true  do
    it "is translated into machine code" do
      main = Main.new(parser: Parser.new, translator: Translator.new)
      main.call("spec/fixtures/Add.asm")

      expect(IO.read("lib/output/Add.hack")).to eq(IO.read("spec/fixtures/Add.hack"))
    end
  end
end
