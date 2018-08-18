require "main"
require "parser"
require "translator"

RSpec.describe "Translate files" do
  context "a file without symbols is loaded"  do
    context "without jump commands" do
      it "is translated into machine code" do
        main = Main.new(parser: Parser.new, translator: Translator.new)
        main.call("spec/fixtures/Add.asm")

        expect(IO.read("lib/output/Add.hack")).to eq(IO.read("spec/fixtures/Add.hack"))
      end
    end

    context "with jump commands" do
      it "is translated into machine code", wip: true do
        main = Main.new(parser: Parser.new, translator: Translator.new)
        main.call("spec/fixtures/MaxL.asm")

        expect(IO.read("lib/output/MaxL.hack")).to eq(IO.read("spec/fixtures/MaxL.hack"))
      end
    end

    after do
      Dir["lib/output/*"].each do |file|
        File.delete(file)
      end
    end
  end
end
