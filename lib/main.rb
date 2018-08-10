class Main
  def initialize(parser:, translator:)
    @parser = parser
    @translator = translator
  end

  attr_reader :parser
  private :parser

  def call(file)
    parser.call(file)
  end
end
