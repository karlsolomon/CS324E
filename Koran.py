import re
allwords = []
file = open("koranShort.txt", "r")
line = file.readline()
while line != "":
  
  line.rstrip()
  line = line.lower()
  words = line.split(" ")
  for string in words:
    string = re.findall('[a-z]+',string)
    allwords.append("".join(str(elt) for elt in string))

  
  line = file.readline()

print(allwords)




'''
adict = {}
adict["K"] = 1
print(adict)
letter = ""
if letter in adict:
  adict[letter] += 1
else:
  adict[letter] = 1

for key in adict.keys():
  print(key.lower())
'''

