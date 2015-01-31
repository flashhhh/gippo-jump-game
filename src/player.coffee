util = require './util.coffee'
KEYMAP = require './keycodes'

MASS = 0.01
RESTITUTION = 1
COF = 1
JUMPFORCE = 1
WIDTH = 30
HEIGHT = 50
MOVESPEED = 0.3

CONTROLS =
  left: [KEYMAP.left_arrow, KEYMAP.a]
  up: [KEYMAP.up_arrow, KEYMAP.w]
  right: [KEYMAP.right_arrow, KEYMAP.d]

body = null
view = null
world = null
initiated = false
movements = []
canJump = false
canMove = true

jump = (modifier = 1) ->
  body.applyForce y: -1 * (JUMPFORCE * modifier) / (100000 * MASS)

module.exports =
  setWorld: (_world) ->
    world = _world
    world.$.player = null
    @
    
  spawn: (x, y) ->
    if body
      world.remove body
    body = Physics.body 'rectangle',
      x: x
      y: y
      width: WIDTH
      height: HEIGHT
    view = body.view
    body.restitution = RESTITUTION
    body.cof = COF
    body.mass = MASS
    body.labels = ['player']
    body.collide = (otherBody) ->
      position = util.positionToBody body, otherBody
      if not canJump and
      'platform' in otherBody.labels and
      position.y is 'over' and
      position.x is 'inside'
        canJump = true
    world.add body
    world.$.player = body

    unless initiated
      initiated = true
      world.on 'step', ->
        if body.state.angular.pos isnt 0
          body.state.angular.pos =
            body.state.angular.vel = 0
        body.sleep false
        body.state.vel.x = 0
        if canMove and 'left' in movements and 'right' not in movements
          body.state.vel.x = -MOVESPEED
        if canMove and 'right' in movements and 'left' not in movements
          body.state.vel.x = MOVESPEED
        if canJump and 'up' in movements
          jump()
          canJump = false
        
      document.addEventListener 'keydown', (event) ->
        if event.keyCode in CONTROLS.left and 'left' not in movements
          movements.push 'left'
        if event.keyCode in CONTROLS.right and 'right' not in movements
          movements.push 'right'
        if event.keyCode in CONTROLS.up and 'up' not in movements
          movements.push 'up'

      document.addEventListener 'keyup', (event) ->
        if event.keyCode in CONTROLS.left
          movements = Physics.util.filter movements, (value) ->
            value isnt 'left'
        if event.keyCode in CONTROLS.right
          movements = Physics.util.filter movements, (value) ->
            value isnt 'right'
        if event.keyCode in CONTROLS.up
          movements = Physics.util.filter movements, (value) ->
            value isnt 'up'
            
