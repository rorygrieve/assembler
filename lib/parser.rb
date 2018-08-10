class Parser

  def call(file)
    lines = IO.readlines(file)
    lines.reject { |line| strip_out_lines_starting_with_comments(line) }
  end

  private

  def strip_out_lines_starting_with_comments(line)
    line[0..1] == "//"
  end
end
