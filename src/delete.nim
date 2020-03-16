# Imports
import cligen
import json
import strformat

# Locals
from add import filePath

# Find a command and delete it
proc deleteCommand*(args: seq[string]) =
  if len(args) > 0:
    let alias = args[0]
    let commandsJson = json.parseFile(filePath)
    if commandsJson.hasKey(alias):
      commandsJson.delete(alias)
      let file = open(filePath, mode = fmWrite)
      defer: close(file)
      file.write(commandsJson)
      echo &"You have deleted {alias}"
    else:
      echo &"Alias {alias} is not found :("
  else:
    echo "You didn't enter an alias :("
    echo "TIP: run mmm d {YOUR ALIAS THAT SHALL BE DELETED -add quotes if it's more than one word-}"

# Test
when isMainModule:
  dispatch(deleteCommand)