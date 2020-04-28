# Imports
import json
import strutils
import colors
import colec

# Locals
from add import filePath

# Convert array of JsonNode to string
proc getStringFromJarray*(arr: JsonNode): string =
  let jsonNodeToArray = arr.getElems()
  
  var arrString = ""
  for str in jsonNodeToArray.items():
    arrString = arrString & str.getStr()
  
  # remove the white space added previously in add.nim
  arrString = arrString.strip()
  result = arrString

# List all aliases you've stored
proc listCommands* =
  let commandsJson = json.parseFile(filePath)
  for key, value in commandsJson.pairs():
    let valueStr = getStringFromJarray(value)
    echo (key @ colForestGreen) & "\t" & (valueStr @ colYellow)
  
