public class VarsLSystem {
public String make(int i) {
  Rule[] rules = new Rule[] {
      new Rule() { //F-Rule
        public String rule() {
          return "F-G+F+G-F";
        }
      }
    , new Rule() { //G-Rule
        public String rule() {
          return "GG";
        }
      }
    , new Rule() { //H-Rule
        public String rule() {
          return "";
        }
      }
      //Constants
    , new Rule() { //+-Rule
        public String rule() {
          return "+";
        }
      }
    , new Rule() { //--Rule
        public String rule() {
          return "-";
        }
      }
    , new Rule() { //[-Rule
        public String rule() {
          return "[";
        }
      }
    , new Rule() { //]-Rule
        public String rule() {
          return "]";
        }
      }
  };
LSystem l = new LSystem("F-G-G", new char[] {'F', 'G', 'H', '+', '-', '[', ']'}, rules);

  return(l.iterate(i));
}
}
