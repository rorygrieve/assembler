class Translator

  def call(code)
    code.map { |line| convert_to_binary(line) }
  end

  private

  def convert_to_binary(line)
    line[1..-1].to_i.to_s(2).rjust(16, "0")
  end
end
