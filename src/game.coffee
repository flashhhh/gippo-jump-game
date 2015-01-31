window.PIXI = require '../lib/pixi.min'
window.Physics = require '../lib/physicsjs-full.min'
configure = require './game.configure.coffee'

levelCreator = require './levelCreator.coffee'
level = require './levels/test.coffee'

Physics (world) ->
  configure world
  levelCreator.create world, level
  Physics.util.ticker.start()
