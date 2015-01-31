RESTITUTION = 0
COF = 0

world = null

module.exports =
  setWorld: (_world) ->
    world = _world
    world.$.platforms = []
    @
  spawn: (x, y, width, height) ->
    body = Physics.body 'rectangle',
      x: x
      y: y
      width: width
      height: height

    body.treatment = 'static'
    body.restitution = RESTITUTION
    body.cof = COF
    body.labels = ['platform']
    world.add body
    
    world.$.platforms.push body
    body