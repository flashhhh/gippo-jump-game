M =
  platform: "#"
  player:   "@"
  coin:     "*"
  s_lava:   "X" # static lava
SCALE = 50 # recommended to set player width

Platform = require './platform.coffee'
Player = require './player.coffee'

module.exports =
  create: (world, level) ->
    Platform.setWorld world
    Player.setWorld world
    if typeof level is 'function'
      level world, Player, Platform
    else # we have a 2d string that represents level's structure
      level = levelStringToArray level
      level = wrapLevelByBorders level
      for line, i in level
        for type, j in line
          worldPos = getWorldPosByLevelIndexes j, i
          switch type
            when M.platform
              Platform.spawn worldPos.x, worldPos.y, SCALE, SCALE
            when M.player
              Player.spawn worldPos.x, worldPos.y, SCALE, SCALE

levelStringToArray = (levelAsString) ->
  result = []
  for line in levelAsString.split "\n"
    result.push line.split ""
  result

wrapLevelByBorders = (level) ->
  width = level[0].length
  lineOfPlatforms = arrayFill(M.platform, width)
  level.unshift lineOfPlatforms
  level.push    lineOfPlatforms
  for line, i in level
    line.unshift M.platform
    line.push M.platform
    level[i] = line

getWorldPosByLevelIndexes = (x, y) ->
  x: x * SCALE + SCALE / 2
  y: y * SCALE + SCALE / 2
  
arrayFill = (item, times) ->
  return new Array(times - 1).join(item).split('')