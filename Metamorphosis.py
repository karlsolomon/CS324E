import re
allwords = []
file = open("metamorphosis.txt", "r")
line = file.readline()
while line != "":
  if line == "\n":
    line = file.readline()
  line.rstrip()
  line = line.lower()
  words = line.split(" ")
  for string in words:
    string = re.findall('[a-z]+',string)
    allwords.append("".join(str(elt) for elt in string))

  
  line = file.readline()

file.close()


w_file = open("allwords.txt", "w")
unique_file = open("uniquewords.txt", "w")
word_dict = {}
for elt in allwords:
  w_file.write(elt + "\n")
  if elt in word_dict:
    word_dict[elt] += 1
  else:
    word_dict[elt] = 1
    unique_file.write(elt + "\n")
    
print(word_dict)
w_file.close()
unique_file.close()


