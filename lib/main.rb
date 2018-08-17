class Main
  def initialize(parser:, translator:)
    @parser = parser
    @translator = translator
  end

  attr_reader :parser, :translator
  private :parser, :translator

  def call(file)
    parsed_code = parser.call(file)
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
