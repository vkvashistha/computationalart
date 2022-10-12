import java.util.*;
public class Grammer {
    Symbol start;
    ArrayList<Symbol> terminalSymbols = new ArrayList<>();
    ArrayList<Symbol> nonTerminalSymbols = new ArrayList<>();
    HashMap<SymbolString, ArrayList<SymbolString>> productionRules = new HashMap<SymbolString, ArrayList<SymbolString>>();
    Random rnd = new Random();

    public Grammer(String grammerString) {
        String []lines = grammerString.split("\n");
        String state = null;
        for(String line : lines) {
            if(line.equalsIgnoreCase( "start:")||line.equalsIgnoreCase( "symbols:")||line.equalsIgnoreCase( "terminals:")||line.equalsIgnoreCase( "rules:")) {
                state = line;
                continue;
            }
            if(state.equalsIgnoreCase( "start:")) {
                start = new Symbol(line.trim());
            } else if (state.equalsIgnoreCase( "symbols:")) {
                String []symbols = line.split(",");
                for(String symbol : symbols) {
                    nonTerminalSymbols.add(new Symbol(symbol.trim()));
                }
            } else if (state.equalsIgnoreCase( "terminals:")) {
                String []symbols = line.split(",");
                for(String symbol : symbols) {
                    terminalSymbols.add(new Symbol(symbol.trim()));
                }
            } else if (state.equalsIgnoreCase( "rules:")) {
                String[]tokens = line.split("->");
                addRule(new SymbolString(tokens[0]), new SymbolString(tokens[1]));
            }
        }
    }

    private void addRule(SymbolString left, SymbolString right) {
        ArrayList<SymbolString> rightList = productionRules.computeIfAbsent(left, k -> new ArrayList<SymbolString>());
        rightList.add(right);
    }

    public SymbolString generateRandomString(int depth) {
        SymbolString currentString = null;
        SymbolStringBuilder result = new SymbolStringBuilder(start);
        while (depth > 0) {
            depth--;
            currentString = result.toSymbolString();
            System.out.println("depth:"+(depth+1) + ":" + currentString);
            result = new SymbolStringBuilder();
            for(Symbol ch : currentString.toSymbolArray()) {
                if(terminalSymbols.contains(ch)) {
                    result.append(ch);
                } else if(nonTerminalSymbols.contains(ch)) {
                    result.append(getRandom(productionRules.get(new SymbolString(new Symbol[] {ch})), depth == 0));
                }
            }
        }
        return result.toSymbolString();
    }
    

    public SymbolString getRandom(List<SymbolString> list, boolean preferTerminalSymbol) {
        int size = list.size();
        if(preferTerminalSymbol) {
            ArrayList<SymbolString> ts = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).length() == 1 && terminalSymbols.contains(list.get(i).symbolAt(0))) {
                    ts.add(list.get(i));
                }
            }
            if(ts.size() > 0) {
                size = ts.size();
                return ts.get(rnd.nextInt(size));
            }
        } else {
            ArrayList<SymbolString> nts = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                if (!(list.get(i).length() == 1 && terminalSymbols.contains(list.get(i).symbolAt(0)))) {
                    nts.add(list.get(i));
                }
            }
            if(nts.size() > 0) {
                size = nts.size();
                return nts.get(rnd.nextInt(size));
            }
        }
        return list.get(rnd.nextInt(size));
    }
}
