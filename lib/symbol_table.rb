require_relative "./built_in_symbols"
require_relative "./added_symbols"

class SymbolTable
  def all_symbols
    built_in_symbols.merge(added_symbols)
  end

  private

  def built_in_symbols
    BUILT_IN_SYMBOLS
  end

  def added_symbols
    ADDED_SYMBOLS
  end
end
