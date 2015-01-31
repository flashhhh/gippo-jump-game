module.exports =
  positionToBody: (bodyA, bodyB, correction = 0.1) ->
    # correction: When bodies collide,
    # they intersect a bit. We need to ignore it.
    
    bodyATopLeft =
      x: bodyA.state.pos.x - bodyA.width / 2
      y: bodyA.state.pos.y - bodyA.height / 2
      
    bodyBTopLeft =
      x: bodyB.state.pos.x - bodyB.width / 2
      y: bodyB.state.pos.y - bodyB.height / 2
      
    bodyABottomRight =
      x: bodyA.state.pos.x + bodyA.width / 2
      y: bodyA.state.pos.y + bodyA.height / 2

    bodyBBottomRight =
      x: bodyB.state.pos.x + bodyB.width / 2
      y: bodyB.state.pos.y + bodyB.height / 2

    horisontalPosition =
      if bodyABottomRight.x - correction < bodyBTopLeft.x then 'left'
      else if bodyATopLeft.x + correction > bodyBBottomRight.x then 'right'
      else 'inside'

    verticalPosition =
      if bodyABottomRight.y - correction < bodyBTopLeft.y then 'over'
      else if bodyATopLeft.y + correction > bodyBBottomRight.y then 'under'
      else 'inside'

    x: horisontalPosition
    y: verticalPosition
