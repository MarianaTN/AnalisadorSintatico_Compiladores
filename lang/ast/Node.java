/*
Autores:
Mariana Trevizani Nocelli  - 201535033
Seany Caroliny Oliveira Silva - 201665566C
*/
package lang.ast;
public class Node extends SuperNode {
    private int line, column;

    public Node(int l, int c) {
      line = l;
      column = c;
    }
    @Override
    public int getLine() {
        return line;
    }

    @Override
    public int getColumn() {
        return column;
    }
}