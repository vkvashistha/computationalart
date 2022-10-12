public class SymbolStringBuilder {
    ArrayList<Symbol> symbols = new ArrayList<>();

    public SymbolStringBuilder() {

    }
    public SymbolStringBuilder(Symbol symbol) {
        symbols.add(symbol);
    }
    public SymbolStringBuilder(SymbolString symbolString) {
        symbols.addAll(List.of(symbolString.symbols));
    }

    public SymbolStringBuilder append(Symbol symbol) {
        symbols.add(symbol);
        return this;
    }

    public SymbolStringBuilder append(SymbolString symbolString) {
        symbols.addAll(List.of(symbolString.symbols));
        return this;
    }

    public SymbolString toSymbolString() {
        return new SymbolString(symbols.toArray(new Symbol[]{}));
    }
}
