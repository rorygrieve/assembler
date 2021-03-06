require_relative "./symbol_table"
STARTING_POINT_FOR_AVAILABLE_RAM_ADDRESSES = 16

class Translator

  def initialize(symbol_table:)
    @symbol_table = symbol_table
    @next_available_ram_address = STARTING_POINT_FOR_AVAILABLE_RAM_ADDRESSES
  end

  attr_reader :symbol_table, :next_available_ram_address
  private :symbol_table, :next_available_ram_address

  def call(code)
    code.map { |line| convert_to_binary(line) }.compact
  end

  private

  def convert_to_binary(line)
    if line[0] == "@"
      convert_symbol_to_binary(line)
    elsif line[0] == "("
      nil
    else
      convert_c_instruction_to_binary(line)
    end
  end

  def convert_symbol_to_binary(line)
    symbol = line[1..-1]

    if symbol.to_i.to_s == symbol
      format_number(symbol)
    elsif symbol_table.all_symbols[symbol] != nil
      get_binary_from_symbol_table(symbol)
    else
      add_to_added_symbols(symbol)
      convert_symbol_to_binary(line)
    end
  end

  def get_binary_from_symbol_table(symbol)
    number = symbol_table.all_symbols[symbol]

    format_number(number)
  end

  def add_to_added_symbols(symbol)
    ADDED_SYMBOLS.merge!( {symbol => next_available_ram_address } )
    @next_available_ram_address += 1
  end

  def format_number(number)
    number.to_i.to_s(2).rjust(16, "0")
  end

  def convert_c_instruction_to_binary(line)
    if line.include?("=")
      parts = line.split("=")
      comp = look_up_comp(parts[1])
      dest = look_up_dest(parts[0])
      jump = "000"
    else
      parts = line.split(";")
      comp = look_up_comp(parts[0])
      dest = "000"
      jump = look_up_jump(parts[1])
    end

    build_c_instruction(comp: comp, dest: dest, jump: jump)
  end

  def build_c_instruction(comp:, dest:, jump:)
    "111" + comp + dest + jump
  end

  def look_up_comp(comp)
    COMPS.fetch(comp)
  end

  def look_up_dest(dest)
    DEST.fetch(dest)
  end

  def look_up_jump(jump)
    JUMP.fetch(jump)
  end

  COMPS = {
    "0" => "0101010",
    "1" => "0111111",
    "-1" => "0111010",
    "D" => "0001100",
    "A" => "0110000",
    "!D" => "0001101",
    "!A" => "0110001",
    "-D" => "0001111",
    "-A" => "0110011",
    "D+1" => "0011111",
    "A+1" => "0110111",
    "D-1" => "0001110",
    "A-1" => "0110010",
    "D+A" => "0000010",
    "D-A" => "0010011",
    "A-D" => "0000111",
    "D&A" => "0000000",
    "D|A" => "0010101",
    "M" => "1110000",
    "!M" => "1110001",
    "-M" => "1110011",
    "M+1" => "1110111",
    "M-1" => "1110010",
    "D+M" => "1000010",
    "D-M" => "1010011",
    "M-D" => "1000111",
    "D&M" => "1000000",
    "D|M" => "1010101",
  }

  DEST = {
    "M" => "001",
    "D" => "010",
    "MD" => "011",
    "A" => "100",
    "AM" => "101",
    "AD" => "110",
    "AMD" => "111",
  }

  JUMP = {
    "JGT" => "001",
    "JEQ" => "010",
    "JGE" => "011",
    "JLT" => "100",
    "JNE" => "101",
    "JLE" => "110",
    "JMP" => "111",
  }
end
