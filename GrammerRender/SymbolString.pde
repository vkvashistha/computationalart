public class SymbolString {
    Symbol [] symbols;
    public SymbolString(Symbol []symbols) {
        this.symbols = symbols;
    }
    public SymbolString(String []symbols) {
        ArrayList<Symbol> symbolList = new ArrayList<>();
        for(String symbol : symbols) {
            symbolList.add(new Symbol(symbol.trim()));
        }
        this.symbols = symbolList.toArray(new Symbol[]{});
    }

    public SymbolString(String symbolString) {
        this(symbolString.split(" "));
    }

    public Symbol[] toSymbolArray() {
        return symbols;
    }

    public Symbol symbolAt(int i) {
        return symbols[i];
    }
    public int length() {
        return symbols.length;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        for(Symbol symbol : symbols) {
            builder.append(symbol).append(" ");
        }
        return builder.toString().trim();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SymbolString that = (SymbolString) o;
        return Arrays.equals(symbols, that.symbols);
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(symbols);
    }
}
