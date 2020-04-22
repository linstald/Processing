/**
*  This class is used to create custom classes which inherit this
*  Function class, which then have a custom generate() function to
*  then call this method via polymorphism.
*/

abstract class Function {
  void generate() {
    System.err.println("You have to override the generate() method inherited from Function");
    toPlot = (toPlot+1)%myFuncs.size();
  }
  void reset() {
    System.err.println("You have to override the reset() method inherited from Function");
  }
}
