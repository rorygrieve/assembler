require "main"
require "parser"
require "translator"
require "symbol_adder"
require "symbol_table"

RSpec.describe "Translate files" do
  let(:main) { Main.new(parser: Parser.new, translator: Translator.new(symbol_table: SymbolTable.new), symbol_adder: SymbolAdder.new) }

  context "a file without symbols is loaded"  do
    context "without jump commands" do
      it "is translated into machine code" do
        main.call("spec/fixtures/Add.asm")

        expect(IO.read("lib/output/Add.hack")).to eq(IO.read("spec/fixtures/Add.hack"))
      end
    end

    context "with jump commands" do
      it "is translated into machine code" do
        main.call("spec/fixtures/MaxL.asm")

        expect(IO.read("lib/output/MaxL.hack")).to eq(IO.read("spec/fixtures/MaxL.hack"))
      end
    end

    context "draws on screen" do
      it "is translated into machine code" do
        main.call("spec/fixtures/RectL.asm")

        expect(IO.read("lib/output/RectL.hack")).to eq(IO.read("spec/fixtures/RectL.hack"))
      end
    end

    context "more complex program" do
      it "is translated into machine code" do
        main.call("spec/fixtures/PongL.asm")

        expect(IO.read("lib/output/PongL.hack")).to eq(IO.read("spec/fixtures/PongL.hack"))
      end
    end

    after do
      ADDED_SYMBOLS = {}
      Dir["lib/output/*"].each do |file|
        File.delete(file)
      end
    end
  end

  context "a file with symbols is loaded"  do
    context "it is a simple program" do
      it "is translated into machine code" do
        main.call("spec/fixtures/Max.asm")

        expect(IO.read("lib/output/Max.hack")).to eq(IO.read("spec/fixtures/Max.hack"))
      end
    end

    context "draws on screen" do
      it "is translated into machine code" do
        main.call("spec/fixtures/Rect.asm")

        expect(IO.read("lib/output/Rect.hack")).to eq(IO.read("spec/fixtures/Rect.hack"))
      end
    end

    context "it is a more complex program" do
      it "is translated into machine code" do
        main.call("spec/fixtures/Pong.asm")

        expect(IO.read("lib/output/Pong.hack")).to eq(IO.read("spec/fixtures/Pong.hack"))
      end
    end

    after do
      ADDED_SYMBOLS = {}
      Dir["lib/output/*"].each do |file|
        File.delete(file)
      end
    end
  end
end
