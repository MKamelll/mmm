#TODOS
#TODO: use sql instead of json
#TODO: find a better way instead of \""""\
#TODO: add -d to delete & -l to list

# Imports
import cligen

# Local package
import add
import run
import delete

# Dispatch
when isMainModule:
  dispatchMulti([addCommand, cmdName = "a"],
                [runCommand, cmdName = "r"],
                [deleteCommand, cmdName = "d"])
