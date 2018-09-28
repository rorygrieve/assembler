require_relative "./added_symbols"

class SymbolAdder
  def initialize
    @line_of_code = 0
  end

  attr_accessor :line_of_code
  private :line_of_code, :line_of_code=

  def call(code)
    code.each { |line|
      if line[0] == "(" && line[-1] == ")"
        pseudo_command_without_brackets = strip_out_brackets(line)

        ADDED_SYMBOLS.merge!( { pseudo_command_without_brackets => line_of_code } )
      else
        increment_line_of_code
      end
    }
  end

  private

  def strip_out_brackets(line)
    line[1..-2]
  end

  def increment_line_of_code
    @line_of_code += 1
  end
end
