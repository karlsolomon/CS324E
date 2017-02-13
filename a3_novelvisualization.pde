String[] uniqueWords;
PFont f;
void setup() {
  size(700,600);
  uniqueWords = loadStrings("uniquewords.txt");
  noLoop();
  
}

void mouseClicked() {
  redraw();
}

public void createWordCloud() {
  f = createFont("Copperplate .ttf",32);
  int words_width = 3;
  int spacing = 34; 
  int numOfNewLines = 1;
  fill(0);
  textFont(f);
  
  ArrayList<Integer> exceptions = new ArrayList<Integer>();
  while (spacing*numOfNewLines <= 600) {
    int index = (int)random(0, uniqueWords.length);
    
    if (exceptions.contains(index)) {
      continue;
    } 
    exceptions.add(index); 
        
    String word = uniqueWords[index];
    char firstWord;
    try {
      firstWord = word.charAt(0);
    } catch (StringIndexOutOfBoundsException e) {
      continue;
    }
    if ((int)firstWord >= 97 && (int)firstWord <= 104) { 
      fill(#814D5B);
    } else if ((int)word.charAt(0) > 104 && (int)word.charAt(0) <= 113) {
      fill(#8D91A2); 
    } else {
      fill(#093F67);
    }
    
    if (words_width + textWidth(word) > 697) {
      numOfNewLines += 1;
      words_width = 3;
    
    } else { 
      text(word, words_width, spacing*numOfNewLines);
      words_width += textWidth(word) + 7;
    }
    
  }
}

void draw() {
  background(252,250,234);
  createWordCloud();
  
}

