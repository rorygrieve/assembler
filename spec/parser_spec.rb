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

    it "stips out lines starting with comments" do
      expect(parser.call("spec/fixtures/the_one_with_comments.asm"))
        .to eq(["@2"])
    end

    it "strips out text after comments" do
      expect(parser.call("spec/fixtures/the_one_with_inline_comments.asm"))
        .to eq(["@2", "@3", "@4", "@5"])
    end

    it "strips out inline space" do
      expect(parser.call("spec/fixtures/the_one_with_inline_space.asm"))
        .to eq(["@2"])
    end

    it "strips out blank lines" do
      expect(parser.call("spec/fixtures/the_one_with_blank_lines.asm"))
        .to eq(["@2", "@3"])
    end
  end
end
