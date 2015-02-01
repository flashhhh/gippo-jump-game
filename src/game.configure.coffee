VIEWPORT =
  width: window.innerWidth - 100
  height: window.innerHeight - 100

module.exports = (world) ->
  renderer = Physics.renderer 'pixi',
    el: 'viewport'
    width: VIEWPORT.width
    height: VIEWPORT.height
    autoResize: false
    meta: true

  window._stage = renderer.stage
  window._world = world
  world.add renderer
  
  world.$ = {}
  
  world.add Physics.behavior 'constant-acceleration',
    acc: {x: 0, y: 0.001}
  world.add Physics.behavior 'body-impulse-response',
    mtvThreshold: 0.001
    bodyExtractDropoff: 0.001
  world.add Physics.behavior 'body-collision-detection'
  world.add Physics.behavior 'sweep-prune'

  Physics.util.ticker.on (time, dt) ->
    world.step time
  world.on 'step', ->
    world.render()

  world.on 'collisions:detected', (data) ->
    for collision in data.collisions
      collision.bodyA.collide? collision.bodyB, collision
      collision.bodyB.collide? collision.bodyA, collision
