require "symbol_table"

RSpec.describe SymbolTable do
  subject(:symbol_table) { SymbolTable.new }
  let(:built_in_symbols) {
    {
      "R0" => 0,
      "R1" => 1,
      "R2" => 2,
      "R3" => 3,
      "R4" => 4,
      "R5" => 5,
      "R6" => 6,
      "R7" => 7,
      "R8" => 8,
      "R9" => 9,
      "R10" => 10,
      "R11" => 11,
      "R12" => 12,
      "R13" => 13,
      "R14" => 14,
      "R15" => 15,
      "SCREEN" => 16384,
      "KBD" => 24576,
      "SP" => 0,
      "LCL" => 1,
      "ARG" => 2,
      "THIS" => 3,
      "THAT" => 4,
    }
  }

  describe "#all_symbols" do
    context "with no extra symbols" do
      it "returns built in symbols" do
        expect(symbol_table.all_symbols).to eq(built_in_symbols)
      end
    end

    context "with an added symbol" do
      after do
        ADDED_SYMBOLS = {}
      end

      it "returns built in symbols and any added symbols" do
        ADDED_SYMBOLS = { "OUTPUT_FIRST" => 111 }

        expect(symbol_table.all_symbols)
          .to eq(built_in_symbols.merge( { "OUTPUT_FIRST" => 111 } ))
      end
    end
  end
end
