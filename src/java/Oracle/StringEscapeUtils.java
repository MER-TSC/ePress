/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Oracle;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;

/**
 *
 * @author MERZAK
 */
public class StringEscapeUtils {
 
    private static Writer writer = new StringWriter();
    public static final HashMap m = new HashMap();
    static{
        m.put(34, "&quot;");        // " - quote
        m.put(37, "&percnt;");      // % - precent
        m.put(60, "&lt;");          // < - less-than
        m.put(62, "&gt;");          // > - greater-than
        m.put(61, "&equals;");      // = - equals
        m.put(160, "&nbsp;");       //   - non-breaking space
        m.put(167, "&sect;");       // § - section
        m.put(47, "&sol;");         // / - slash
        m.put(92, "&bsol;");        // \ - backslash
        m.put(8709, "&emptyset;");  // ∅ - empty set
        m.put(64, "&commat;");      // @ - at
        m.put(59, "&semi;");        // ; - semi-colon
        m.put(39, "&apos;");        // ' - apostrophe
        m.put(192, "&Agrave;");     // À - A grave
        m.put(224, "&agrave;");     // à - a grave
        m.put(225, "&acute;");      // à - a aigu
        m.put(226, "&acirc;");      // â - a chapeaux
        m.put(233, "&eacute;");     // é - e aigu
        m.put(232, "&egrave;");     // è - e grave
        m.put(234, "&ecirc;");      // ê - e chapeaux
        m.put(231, "&ccedil;");     // ê - c cédille
        m.put(339, "&oelig;");      // œ - grapheme
        m.put(181, "&micro;");      // µ - micro
        m.put(8364, "&euro;");      // € - euro
        m.put(36, "&dollar;");      // $ - dollar
        // User needs to map all html entities with their corresponding decimal values.
    }
 
    public static String escapeHtml(String str) throws IOException {
        if(str != null){
            writer = new StringWriter();
            for(int i = 0; i < str.length(); i++){
                char c = str.charAt(i);
                int ascii = (int) c;
                String entityName = (String) m.get(ascii);
                if(entityName == null){
                    if(c > 0x7F){
                        writer.write("&#");
                        writer.write(Integer.toString(c, 10));
                        writer.write(';');
                    }else{
                        writer.write(c);
                    }
                }else{
                    writer.write(entityName);
                }
            }
            return writer.toString();
        }else{
            return "";
        }
    }
}