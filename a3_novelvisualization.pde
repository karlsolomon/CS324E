//Myeongin, I did most of the code for the display. You just need to mess with the variable Fontsize and maybe spacing, and change the
//colors. They are bad rn. If you need help, feel free to text me. Thanks, Dylan.
String[] uniqueWords;
void setup() {
  size(700,600);
  uniqueWords = loadStrings("uniquewords.txt");
  noLoop();
  
}

void mouseClicked() {
  redraw();
}

public void createWordCloud() {
  int font_Size = 32;
  int words_width = 3;
  int spacing = font_Size + 2; 
  int numSpacing = 1;
  fill(0);
  textSize(font_Size);
  ArrayList<Integer> exceptions = new ArrayList<Integer>();
  while (spacing*numSpacing <= 600) {
    int index = (int)random(0, uniqueWords.length);
    
    if (exceptions.contains(index)) {
      continue;
    } 
    exceptions.add(index); 
    if (index % 3 == 0) { 
      fill(255,0,0);
    } else if (index % 3 == 1) {
      fill(0,255,0); 
    } else {
      fill(0,0,255);
    }
    String word = uniqueWords[index];
    
    if (words_width + textWidth(word) > 697) {
      numSpacing += 1;
      words_width = 3;
    
    } else { 
      text(word, words_width, spacing*numSpacing);
      words_width += textWidth(word) + 7;
    }
    
  }
}

void draw() {
  background(255);
  createWordCloud();
 
 
  
}
    
  
