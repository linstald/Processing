/*
*  QUICKSORT VISUALIZATION
 *
 *  This Processing Sketch visualizes the Quicksort Algorithm.
 *  All Information needed is written in the comments
 *
 *  Credits: Linus Stalder
 */



Key[] arr;//the array to be sorted (uses own Key class to easily color the columns different)
int w;//width of the columns (entries of the array); can be changed as you wish
ArrayList<Key[]> list; //list of Arrays used to store the stages of the array during quicksort, to draw the different stages
int index; //index for drawing the list


void setup() {
  //fullScreen();
  size(2000, 600); //change as you wish
  w = 50; //feel free to change
  index = 0;
  arr=new Key[width/w]; //width/w elements in array
  colorMode(HSB, 360, 100, 100);
  for (int i=0; i<arr.length; i++) { //initializing the array with random values (note that Key constructor is used as we use Key class)
    arr[i]=new Key((int)(random(1)*(height)), -1);
  }
  list = new ArrayList<Key[]>();
  quickSort(list, arr, 0, arr.length-1); //sorting the array using quickSort
  //println(list.size());
  //for (int i=0; i<list.size(); i++) {
  //  printArray(list.get(i));
  //}
}
void draw() {
  noStroke();
  frameRate(20); //feel free to change
  if (index<list.size()) {
    drawArray(list.get(index)); //drawing the different stages of the arrays in quicksort; each frame a new stage
    index++;
  } else {
    noLoop();
  }
}

void mouseClicked() {
  if (index>=list.size()) {
    setup();
    loop();
  }
}
/*
*This function prints a Key array as follows:
 * [key|status,...,key|status]
 *
 */
void printArray(Key[] arr) {
  if (arr.length==0) {
    print("[");
  } else {
    print("["+arr[0].key+"|"+arr[0].status);
  }
  for (int i =1; i<arr.length; i++) {
    print(", "+arr[i].key+"|"+arr[i].status);
  }
  println("]");
}

/*
* This function draws a Key array on the window as follows:
 * According to the position in the array, a column is drawn with the height of the key of the entry (arr[i].key)
 * The Color is determined by the status of the entry (arr[i].status)
 */
void drawArray(Key[] arr) {
  background(120);

  for (int i=0; i<arr.length; i++) {
    if (arr[i].status==0) {//left pointer (green)
      fill(130, 80, 100);
    } else if (arr[i].status==1) {//right pointer (yellow)
      fill(50, 80, 100);
    } else if (arr[i].status==2) {//pivot (red)
      fill(0, 100, 100);
    } else if (arr[i].status==3) {//old pivot (light red)
      fill(0, 50, 100);
    } else { //default (blue)
      fill(190, 50, 100);
    }

    rect(i*w, height, w, -arr[i].key);
  }
}



/*
*  Sorts an Array using QuickSort
 *  Parameters:
 *  list: an ArrayList of Key Arrays, it is used to store the different stages of the algorithm
 *  arr: an Key Array, it is the array to be sorted according to the entries key value (arr[i].key)
 *  start: starting point where quickSort should start sorting
 *  end: ending point where quickSort should stop sorting
 *  the latter two are used to the recurrence working
 *
 */
void quickSort(ArrayList<Key[]> list, Key[] arr, int start, int end) {
  if (start>=end) {
    return;
  }

  int p = partition(list, arr, start, end);
  quickSort(list, arr, start, p-1);
  quickSort(list, arr, p+1, end);
}

/*
*  Splits an array according to a pivot: all elements with key less than pivotkey are on the left of the pivot
 *  Parameters:
 
 *  list: an ArrayList of Key Arrays, it is used to store the different stages of the algorithm
 *  arr: an Key Array, it is the array to be split according to the entries key value (arr[i].key)
 *  start: starting point where partition should start working
 *  end: ending point where partition should stop working
 *  
 *  The algorithm used in this example is known as the "Hoare partition scheme":
 *  https://en.wikipedia.org/wiki/Quicksort#Hoare_partition_scheme
 */
int partition(ArrayList<Key[]> list, Key[] arr, int start, int end) {
  int pind = end; //pivotindex
  int p = arr[pind].key;//pivotkey

  int left = start; //index of left pointer
  int right = end-1; //index of right pointer

  arr[pind].setStatus(2); //status of pivotelement
  arr[left].setStatus(0); //status of left pointer
  arr[right].setStatus(1);//status of right pointer

  addToList(list, arr); //add first array to list

  int prevleft =left;
  int prevright=right;
  do {
    while ((left<end && arr[left].key<p) || (right>start && arr[right].key>=p)) { //slightly modified to always have both pointer's status in the staged array
      if (left<end && arr[left].key<p) {
        left++;
        arr[left].setStatus(0); //set status of new leftpointer
        arr[prevleft].setStatus(-1); //reset status of old leftpointer
        prevleft=left; //update old leftpointer
      }
      if (right>start && arr[right].key>=p) {
        right--;
        arr[right].setStatus(1); //set status of new rightpointer
        arr[prevright].setStatus(-1); //reset status of old rightpointer
        prevright=right; //update old rightpointer
      }
      addToList(list, arr); //store each iteration of pointers movement in list
    }

    if (left<right) {
      
      swap(list, arr, left, right);
      arr[left].setStatus(-1);
      arr[right].setStatus(-1);
    }
  } while (left<right);
  arr[pind].setStatus(3); //set status of pivotelement to old pivot
  arr[right].setStatus(-1); //reset status of leftpointer
  arr[left].setStatus(-1); //reset status of rightpointer
  swap(list, arr, left, pind);
  return left;
}

/*
*  swaps elements a and b in given array arr
 *  list is the ArrayList of Key Arrays to store the staged arrays in the algorithm
 */
void swap(ArrayList<Key[]> list, Key[] arr, int a, int b) {
  Key temp=arr[a];
  arr[a]=arr[b];
  arr[b]=temp;
  addToList(list, arr);
}


/*
*  adds a Key Array to the List
 *
 */
void addToList(ArrayList<Key[]> list, Key[] arr) {
  Key[] toAdd = new Key[arr.length];
  toAdd = copyOfArray(arr); //copy that not only references are stored which maybe already are in the list
  list.add(toAdd);
}


/*
*  copies an Array of Keys generating new Object to prevent that only references are copied
 *  returns the copy
 *
 */

Key[] copyOfArray(Key[] arr) {
  Key[] res=new Key[arr.length];
  for (int i=0; i<arr.length; i++) {
    res[i] = new Key(arr[i]);
  }
  return res;
}

/*
*  Key Class which stores a key and a status for each Key-Object
 *  
 */
class Key {
  int key;
  int status;
  //Constructor to generate Object from Scratch
  Key(int key, int status) {
    this.key=key;
    this.status=status;
  }
  //Constructor to generate a copy of a Key Object
  Key (Key k) {
    this.key =k.key;
    this.status=k.status;
  }
  //setter of status
  void setStatus(int status) {
    this.status=status;
  }
}
