import re
allwords = []
file = open("koranShort.txt", "r")
line = file.readline()
while True:
  line = file.readline()
  if(line == "\n"):
   continue
  if(line == ""):
    break
  line.rstrip()
  line = line.lower()
  words = line.split(" ")
  for string in words:
    string = re.findall('[a-z]+',string)
    allwords.append("".join(str(elt) for elt in string))

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
    
#print(word_dict)
w_file.close()
unique_file.close()


frequency_dict = {}
for word, frequency in word_dict.items():
    if frequency in frequency_dict:
        frequency_dict[frequency] += 1
    else:
        frequency_dict[frequency] = 1
        
    
f_file = open("wordfrequency.txt", "w")
for frequency, numberOfWords in sorted(frequency_dict.iteritems()):
    s =  str(frequency) + ": " + str(numberOfWords) + "\n"
    print s
    f_file.write(s)

f_file.close()
            



'''
word_dict = {}
word_dict["K"] = 1
print(word_dict)
elt = ""
if elt in word_dict:
  word_dict[elt] += 1
else:
  word_dict[elt] = 1
for key in word_dict.keys():
  print(key.lower())
'''