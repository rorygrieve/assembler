class Main
  def initialize(parser:, translator:)
    @parser = parser
    @translator = translator
  end

  attr_reader :parser, :translator
  private :parser, :translator

  def call(file)
    parsed_code = parser.call(file)
    translator.call(parsed_code)
  end
end
