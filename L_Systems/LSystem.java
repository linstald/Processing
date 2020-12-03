public class LSystem {
  String axiom;
  String current;
  char[] alphabet;
  Rule[] rules;
  public LSystem(String axiom, char[] alphabet, Rule[] rules) {
    this.axiom = axiom;
    this.current = this.axiom;
    this.alphabet = alphabet; //rules must be in same order as alphabet... (rule to A must have same index as A in alphabet)
    this.rules = rules;
  }
  
  public String iterate(int n) {
    String next = "";
    for (int i = 0; i<current.length(); i++) { //iterate over current String
      char curchar = current.charAt(i);
      for (int j = 0; j<alphabet.length; j++) { //examine the rule corresponding to the found char
        if (curchar==alphabet[j]) {
          next = next + rules[j].rule();
        }
      }
    }
    current = next;
    if (n<=1) {    
      return next;
    }else {
      return iterate(n-1);
    }
    
  }
  
}
