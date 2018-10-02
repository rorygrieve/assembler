class Main
  def initialize(parser:, symbol_adder:, translator:)
    @parser = parser
    @symbol_adder = symbol_adder
    @translator = translator
  end

  attr_reader :parser, :translator, :symbol_adder
  private :parser, :translator, :symbol_adder

  def call(file)
    parsed_code = parser.call(file)
    symbol_adder.call(parsed_code)

    translated_code = translator.call(parsed_code)

    name_of_output_file = generate_name_of_output_file(file)

    create_output_file(file_name: name_of_output_file, code: translated_code)
  end

  private

  def generate_name_of_output_file(file)
    name_of_original_file = file.split("/").last
    name_of_original_file.split(".").first
  end

  def create_output_file(file_name:, code:)
    File.open("lib/output/#{file_name}.hack", "w+") do |f|
      f.puts(code)
    end
  end
end
