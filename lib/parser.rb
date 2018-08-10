class Parser

  def call(file)
    lines = IO.readlines(file)
    lines
      .reject { |line| strip_out_lines_starting_with_comments(line) }
      .map { |line| strip_out_inline_comments(line) }
      .reject { |line| strip_out_blank_lines(line) }
      .map { |line| strip_out_inline_space(line) }
  end

  private

  def strip_out_lines_starting_with_comments(line)
    line[0..1] == "//"
  end

  def strip_out_inline_comments(line)
    comment_index = line.index("//")
    if comment_index == nil
      return line
    end

    line[comment_index..-1] = ""
    line
  end

  def strip_out_blank_lines(line)
    line == "\n"
  end

  def strip_out_inline_space(line)
    line.gsub(/[[:space:]]/,'')
  end
end
