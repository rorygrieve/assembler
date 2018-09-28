require "symbol_adder"

RSpec.describe SymbolAdder do
  subject(:symbol_adder) { SymbolAdder.new }

  after do
    ADDED_SYMBOLS = {}
  end

  describe "#call" do
    let(:parsed_code) { ["D=M", "(LOOP)", "M=D", "@LOOP"] }

    it "send pseudo commands to SymbolTable" do
      symbol_adder.call(parsed_code)

      expect(ADDED_SYMBOLS).to eq( { "LOOP" => 1 } )
    end
  end
end
