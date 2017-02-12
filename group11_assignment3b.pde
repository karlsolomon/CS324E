ArrayList<FrequencyPair> frequencies;

void setup() { //<>//
  String[] allWords = loadStrings("allwords.txt");  
  String[] uniqueWords = loadStrings("uniquewords.txt");
  String[] wordFrequency = loadStrings("wordfrequency.txt");
  frequencies = extractFrequencies(wordFrequency);
  
}

void draw() {
  
}

ArrayList<FrequencyPair> extractFrequencies (String[] wordFrequency) {
  ArrayList<FrequencyPair> frequencies = new ArrayList<>();
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