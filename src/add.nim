# Imports
import cligen
import json
import os
import strformat
import strutils

# A structured command
type
  Alias = ref object
    parsedAlias: string
    parsedCommand: seq[string]
  
# Checks command already in a file
proc checkCommandFileOrCreate*(): string =
  let fileName = "commands_alias_list.json"
  let filePath = os.getHomeDir() / fileName
  if not filePath.existsFile():
    var newFile = open(fileName = filePath, mode = fmWrite)
    defer: close(newFile)
    newFile.write("{}")
  result = filePath
    
# Checks if a command is present or adds it
proc checkCommands*(filePath: string, alias: Alias) =
  var commandsJson = json.parseFile(filePath)
  let key = &"{alias.parsedAlias}"
  let value = %*(alias.parsedCommand)
  let valueStr = value.getElems().join(" ")
  if not commandsJson.hasKey(key):
    commandsJson[key] = value
    var editedFile = open(filePath, fmWrite)
    defer: close(editedFile)
    editedFile.write(commandsJson)
    echo &"You have aliased {valueStr} with {key}"
  else:
    echo &"You have already used {key} for: {valueStr}"

# Adding new cmds 
proc addCommand*(alias: string, command: seq[string]) =
  let filePath = checkCommandFileOrCreate()
  let aliasObject = Alias(parsedAlias: alias, parsedCommand: command)
  checkCommands(filePath, aliasObject)

# Test
when isMainModule:
  dispatch(addCommand)