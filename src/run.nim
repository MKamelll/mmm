# imports
import cligen, json, os, options, strutils, strformat

# Fetch command
proc fetchCommand*(alias: string): Option[seq[JsonNode]] =
  let fileName = "commands_alias_list.json"
  let filePath = os.getHomeDir() / fileName
  let commands = json.parseFile(filePath)
  if commands.hasKey(alias):
    result = some(commands[alias].getElems())
  else:
    echo "Not Found :("
    result = none(seq[JsonNode])

# Assemble
proc assembleCmd*(fetchCommand: string, additionalCmds: seq[string]): string =
  var finalCmd = &"{fetchCommand} "
  for additionalCmd in additionalCmds:
    var additionalCmdStr = additionalCmd.join("")
    # To distinguish the passed args if they're pure strings like the commit mrssages or regular commands
    if additionalCmdStr.startsWith("#"):
      additionalCmdStr = additionalCmdStr.strip(chars = {'#'})
      finalCmd.add(&"\"{additionalCmdStr}\" ")
    else:
      finalCmd.add(&"{additionalCmdStr} ")
  result = finalCmd

# Running cmds
proc runCommand*(args: seq[string]) =
  let argsNum = args.len()
  if argsNum > 0:
    let alias = args[0]
    
    # adding the rest 
    let additionalCmds = args[1..argsNum - 1]
    let fetchedCmd = fetchCommand(alias).get().join("").strip(chars = {'"'})
    let excCommand = assembleCmd(fetchedCmd, additionalCmds)
    discard os.execShellCmd(excCommand)
  else:
    echo "Not A Valid Alias :("
    echo "TIP: run mmm r {YOUR ALIAS -add quotes if it's more than one word-}"

# Test
when isMainModule:
  dispatch(runCommand)