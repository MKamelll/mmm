# Imports
import cligen
import json
import os
import strformat
import strutils

# Consts
const fileName = "commands_alias_list.json"
const filePath* = os.getHomeDir() / fileName

# A structured command
type
  Alias = ref object
    parsedAlias: string
    parsedCommand: seq[string]
  
# Checks command already in a file
proc checkCommandFileOrCreate*() =
  if not filePath.existsFile():
    var newFile = open(fileName = filePath, mode = fmWrite)
    defer: close(newFile)
    newFile.write("{}")
    
# Checks if a command is present or adds it
proc checkCommands*(alias: Alias) =
  var commandsJson = json.parseFile(filePath)
  let key = &"{alias.parsedAlias}"
  let value = %*(alias.parsedCommand)
  
  # triming the "" and space for printing out
  let valueStr = alias.parsedCommand[0..len(alias.parsedCommand) - 1].join(" ").strip()
  
  if not commandsJson.hasKey(key):
    commandsJson[key] = value
    var editedFile = open(filePath, fmWrite)
    defer: close(editedFile)
    editedFile.write(commandsJson)
    echo &"You have aliased \"{valueStr}\" with \"{key}\""
  else:
    echo &"You have already used \"{key}\" for: \"{valueStr}\""

# Adding new cmds 
proc addCommand*(args: seq[string]) =
  let argsLength = len(args)
  if argsLength > 0:
    let alias = args[0]
    # adding a trailing space in case the user fotgets
    let command = args[1..argsLength - 1] & " "
    let aliasObject = Alias(parsedAlias: alias, parsedCommand: command)
    checkCommands(aliasObject)
  else:
    echo "Not enough arguments :("
    echo r"""TIP: run mmm a {YOUR ALIAS -add quotes if it's more than one word-}
         {YOUR COMMAND -if it's literally a string \""{YOUR STRING}""\}"""

# Test
when isMainModule:
  dispatch(addCommand)