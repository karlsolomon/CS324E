 //<>//
ArrayList<FrequencyPair> frequencies;
static int leftBuffer = 100;
int xUnit = 0;
int yUnit = 0;
static int w = 0;
static int h = 0;
String[] wordFrequency;
String[] allWords;
String[] uniqueWords;
static int pointWeight = 6;
int lineWeight = 4;
int tickTextSize = 12;
int axisLabelTextSize = 20;
static int bottomBuffer;
static int maxFrequency = 0;
static int maxNumberOfWords = 0;

void setup() {
  allWords = loadStrings("allwords.txt");  
  uniqueWords = loadStrings("uniquewords.txt");
  wordFrequency = loadStrings("wordfrequency.txt");
  frequencies = extractFrequencies(wordFrequency);
  noLoop();
  fill(0);
}

void settings() {
  w = displayWidth; 
  h = displayHeight;
  w = (int)(8 * w /9); 
  h = (int)(8 * h /9);
  size(w,h);
  bottomBuffer = h - leftBuffer;

}

void draw() {
  makeGraph();
}

ArrayList<FrequencyPair> extractFrequencies (String[] wordFrequency) {
  ArrayList<FrequencyPair> frequencies = new ArrayList<FrequencyPair>();
  Integer[] pair = new Integer[2];
  for(String i : wordFrequency) {
    pair[0] = Integer.parseInt(i.split(": ")[0]);
    pair[1] = Integer.parseInt(i.split(": ")[1]);    
    frequencies.add(new FrequencyPair(pair[0], pair[1]));
  }
  return frequencies;  
}

class FrequencyPair {
  private int frequency;
  private int numberOfWords;
  
  public FrequencyPair(int frequency, int numberOfWords) {
    this.frequency = frequency;
    this.numberOfWords = numberOfWords;
  }
  
  public int getFrequency() {
    return this.frequency;
  }
  public int getNumberOfWords() {
    return this.numberOfWords;
  }
  
  public int getXPixel() {
    return LinearToLog.getXPixel(frequency); //<>//
  }
  
  public int getYPixel() {
    return LinearToLog.getYPixel(numberOfWords);
  }  
}

void makeGraph() {
  for(FrequencyPair i : frequencies) {
    if(i.getFrequency() > maxFrequency)
      maxFrequency = i.getFrequency();
    if(i.getNumberOfWords() > maxNumberOfWords)
      maxNumberOfWords = i.getNumberOfWords();
  }

 // HashMap<Integer, Integer> coordinates = new HashMap<Integer,Integer>();
  strokeWeight(pointWeight);
  stroke(255,0,0);
  for(FrequencyPair i : frequencies) {
    point(i.getXPixel(), i.getYPixel());
  }
  stroke(0);
  strokeWeight(lineWeight);
  
  makeYAxis(leftBuffer, bottomBuffer, maxNumberOfWords); //<>//
  makeXAxis(leftBuffer, bottomBuffer);
}

void makeYAxis(int leftBuffer, int bottomBuffer, int maxNumberOfWords) {
  textSize(axisLabelTextSize);  
  float rightShift = leftBuffer/2;
  float downShift = (bottomBuffer)/2;  
  textAlign(CENTER,BOTTOM);
  pushMatrix();
  translate(rightShift,downShift);
  rotate(-HALF_PI);
  text("Number of Words",0,0);
  popMatrix();
  
  line(leftBuffer-pointWeight, 0, leftBuffer-pointWeight, bottomBuffer);

  ArrayList<YTick> yAxisMarks = new ArrayList<YTick>();
  for(int numberOfWords = 1; numberOfWords < maxNumberOfWords; numberOfWords *=10) {
    yAxisMarks.add(new YTick(numberOfWords));
  }
  textSize(tickTextSize);
  for(YTick y : yAxisMarks) {
    y.displayYTick();
  }
}

void makeXAxis(int leftBuffer, int bottomBuffer) {
  textAlign(CENTER,BOTTOM);
  line(leftBuffer, bottomBuffer+pointWeight, w, bottomBuffer+pointWeight);
  textSize(axisLabelTextSize);
  text("Frequency",(leftBuffer+w)/2,bottomBuffer + (h-bottomBuffer)/2);

  ArrayList<XTick> xAxisMarks = new ArrayList<XTick>();
  for(int frequency = 1; frequency < maxFrequency; frequency *= 10) {
    xAxisMarks.add(new XTick(frequency));
  }
  textSize(tickTextSize);
  for(XTick x : xAxisMarks) {
    x.displayXTick();
  }
}

class YTick {
  String value;
  int yPixel;
  int lineLength = 10;

  public YTick(int value) {
    this.value = Integer.toString(value);
    this.yPixel = LinearToLog.getYPixel(value);
  }

  void displayYTick() {
    line(leftBuffer-lineLength-pointWeight, yPixel, leftBuffer-pointWeight, yPixel);
    text(value, leftBuffer - (lineLength + textWidth(value)), yPixel);
  }
}

static class LinearToLog {
  static int getXPixel(int frequency) {
    Double xPixel = new Double(leftBuffer);
    xPixel += Math.log(frequency)/Math.log(new Double(maxFrequency))*(w-(pointWeight/2)-leftBuffer);
    return xPixel.intValue();
  }
  
  static int getYPixel(int numberOfWords) {
    Double yPixel = new Double(bottomBuffer);
    yPixel -= Math.log(numberOfWords)/Math.log(new Double(maxNumberOfWords))*(bottomBuffer-pointWeight/2);
    return yPixel.intValue();
  }
}

class XTick {
  String value;
  int xPixel;
  int lineLength = 10;

  public XTick(int value) {
    this.value = Integer.toString(value);
    this.xPixel = LinearToLog.getXPixel(value);
  }

  void displayXTick() {
    line(xPixel,bottomBuffer + pointWeight,xPixel,bottomBuffer+lineLength+pointWeight);
    text(value, xPixel, bottomBuffer + 2*lineLength + textAscent() + lineWeight);
  }
}