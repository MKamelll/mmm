#TODOS
#TODO: use sql instead of json
#TODO: add colors

# Imports
import os

# Local package
import add
import run
import delete
import list

# Usage
const USAGE = """

usage: mmm [command] [options]
------------------------------

commands:
  r     Run stored aliases
  d     Delete an alias
  a     Add an alias
  l     list all aliases
"""

proc main(args: seq[string]) =
  if len(args) >= 1:
    let 
      command = args[0]
      argsWithoutCommand = args[1..high(args)]
    case command:
      of "r":
        runCommand(argsWithoutCommand)
      of "d":
        deleteCommand(argsWithoutCommand)
      of "a":
        addCommand(argsWithoutCommand)
      of "l":
        listCommands()
      else:
        echo USAGE
  else:
    echo USAGE
    

# Dispatch
when isMainModule:
  main(os.commandLineParams())
