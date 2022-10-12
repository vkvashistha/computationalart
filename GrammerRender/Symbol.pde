public class Symbol {
    private String s;
    public Symbol(String s) {
        this.s = s;
    }

    @Override
    public String toString() {
        return s;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Symbol symbol = (Symbol) o;
        return Objects.equals(s, symbol.s);
    }

    @Override
    public int hashCode() {
        return Objects.hash(s);
    }
}
