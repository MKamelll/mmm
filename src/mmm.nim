#TODOS
#TODO: use sql instead of json

# Imports
import cligen

# Local package
import add
import run
import delete
import list

# Dispatch
when isMainModule:
  dispatchMulti([addCommand, cmdName = "a"],
                [runCommand, cmdName = "r"],
                [deleteCommand, cmdName = "d"],
                [listCommands, cmdName = "l"])
