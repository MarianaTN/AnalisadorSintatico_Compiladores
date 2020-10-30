/*
Autores:
Mariana Trevizani Nocelli  - 201535033
Seany Caroliny Oliveira Silva - 201665566C
*/
package lang.parser;

import lang.ast.SuperNode;
import lang.ast.Node;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.IOException;

public class ParserLang implements ParseAdaptor {

    @Override
    public SuperNode parseFile(String path) throws IOException {
        CharStream stream = CharStreams.fromFileName(path);
        langLexer lexer = new langLexer(stream);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        langParser parser = new langParser(tokens);

        try {
            lexer.removeErrorListeners();
            lexer.addErrorListener(new BaseErrorListener() {
                @Override
                public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
                    throw new RuntimeException(e.getCause());
                }
            });

            ParseTree tree = parser.prog();
            if (parser.getNumberOfSyntaxErrors() > 0)
                return null;
            else {
                SuperNode node = new Node(parser.getCurrentToken().getLine(), parser.getCurrentToken().getCharPositionInLine());
                return node;
            }
        }catch (RuntimeException e) {
            return null;
        }
    }
}