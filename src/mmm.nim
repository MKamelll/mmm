# Imports
import cligen

# Local package
import add
import run

# Dispatch
when isMainModule:
  dispatchMulti([addCommand, cmdName = "a"],
                [runCommand, cmdName = "r"])
