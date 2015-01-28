window.PIXI = require '../lib/pixi.min'
window.Physics = require '../lib/physicsjs-full.min'
Platform = require './platform.coffee'
Player = require './player.coffee'

VIEWPORT = 
  width: window.innerWidth - 100
  height: window.innerHeight - 100

Physics (world) ->
  renderer = Physics.renderer 'pixi',
    el: 'viewport'
    width: VIEWPORT.width
    height: VIEWPORT.height
    autoResize: false
    meta: true
    
  window._stage = renderer.stage
  window._world = world
  world.add renderer

  world.$ = 
    player: null
    platforms : []

  Platform.setWorld world
  Player.setWorld world
  
  Platform.spawn 500, 590, 2000, 10
  Platform.spawn 500, 430, 90, 60

  Player.spawn 500, 300

  world.add Physics.behavior 'constant-acceleration',
    acc: {x: 0, y: 0.001}
#  edgeCollisionBox = Physics.behavior 'edge-collision-detection',
#    aabb: Physics.aabb 0, 0, 1000, 500
#    restitution: 0
#  edgeCollisionBox.body.labels = ['edge']
#  world.add edgeCollisionBox
  world.add Physics.behavior 'body-impulse-response'
  world.add Physics.behavior 'body-collision-detection'
  world.add Physics.behavior 'sweep-prune'

  Physics.util.ticker.on (time, dt) ->
    world.step time
  Physics.util.ticker.start()
  world.on 'step', ->
    world.render()

  world.on 'collisions:detected', (data) ->
    for collision in data.collisions
      collision.bodyA.collide? collision.bodyB, collision
      collision.bodyB.collide? collision.bodyA, collision
