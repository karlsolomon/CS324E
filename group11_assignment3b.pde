ArrayList<FrequencyPair> frequencies; //<>// //<>//
int leftBuffer = 100;
int bottomBuffer = 100;
int xUnit = 0;
int yUnit = 0;
int w = 0;
int h = 0;
String[] wordFrequency;
String[] allWords;
String[] uniqueWords;
int pointWeight = 6;
int lineWeight = 4;
int tickTextSize = 12;
int axisLabelTextSize = 20;

void setup() { //<>//
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
  
}

void makeGraph() {
  int maxFrequency = 0;
  int maxNumberOfWords = 0;
  int leftBuffer = 100;
  int bottomBuffer = 100;

  for(FrequencyPair i : frequencies) {
    if(i.getFrequency() > maxFrequency)
      maxFrequency = i.getFrequency();
    if(i.getNumberOfWords() > maxNumberOfWords)
      maxNumberOfWords = i.getNumberOfWords();
  }

  Double xScale = Math.ceil((double) maxFrequency/(w-leftBuffer));
  Double yScale = Math.ceil((double) maxNumberOfWords/(h-bottomBuffer));
  xUnit = xScale.intValue();
  yUnit = yScale.intValue();

 // HashMap<Integer, Integer> coordinates = new HashMap<Integer,Integer>();
  strokeWeight(pointWeight);
  stroke(255,0,0);
  for(FrequencyPair i : frequencies) {
    point(leftBuffer + (i.getFrequency()/xUnit), (h-bottomBuffer) - (i.getNumberOfWords()/yUnit));
  }
  stroke(0);
  strokeWeight(lineWeight);
  
  makeYAxis(leftBuffer, bottomBuffer, maxNumberOfWords); //<>// //<>//
  makeXAxis(leftBuffer, bottomBuffer);
}

void makeYAxis(int leftBuffer, int bottomBuffer, int maxNumberOfWords) {
  textAlign(CENTER,BOTTOM);
  textSize(axisLabelTextSize);
  
  float rightShift = leftBuffer/2;
  float downShift = (h-bottomBuffer)/2;
  textAlign(CENTER,BOTTOM);

  pushMatrix();
  translate(rightShift,downShift);
  rotate(-HALF_PI);
  text("Number of Words",0,0);
  popMatrix();
  
  line(leftBuffer-pointWeight, 0, leftBuffer-pointWeight, h-bottomBuffer);

  ArrayList<YTick> yAxisMarks = new ArrayList<YTick>();
  for(int numberOfWords = 0; numberOfWords < maxNumberOfWords; numberOfWords += 100*yUnit) {
    yAxisMarks.add(new YTick(numberOfWords, (h-bottomBuffer)- (numberOfWords/yUnit)));
  }
  textSize(tickTextSize);
  for(YTick y : yAxisMarks) {
    y.displayYTick();
  }
}

void makeXAxis(int leftBuffer, int bottomBuffer) {
  textAlign(CENTER,BOTTOM);
  line(leftBuffer, h-bottomBuffer+pointWeight, w, h-bottomBuffer+pointWeight);
  textSize(axisLabelTextSize);
  text("Word Frequency",(leftBuffer+w)/2,h-(bottomBuffer/2));

  ArrayList<XTick> xAxisMarks = new ArrayList<XTick>();
  for(int xPixel = leftBuffer; xPixel < w; xPixel += 100) {
    xAxisMarks.add(new XTick(xPixel*xUnit-100, xPixel));
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

  public YTick(int value, int yPixel) {
    this.value = Integer.toString(value);
    this.yPixel = yPixel;
  }

  void displayYTick() {
    line(leftBuffer-lineLength, yPixel, leftBuffer, yPixel);
    text(value, leftBuffer - (lineLength + textWidth(value)), yPixel);
  }
}

class XTick {
  String value;
  int xPixel;
  int lineLength = 10;

  public XTick(int value, int xPixel) {
    this.value = Integer.toString(value);
    this.xPixel = xPixel;
  }

  void displayXTick() {
    line(xPixel,h-bottomBuffer,xPixel,h-bottomBuffer+lineLength);
    text(value, xPixel-textWidth(value)/2, h-bottomBuffer + lineLength + textAscent());
  }
}