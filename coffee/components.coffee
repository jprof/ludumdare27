Crafty.c 'Actor',
  init: ()->
    @requires '2D, Canvas, Collision, Color'
    return @

Crafty.c 'Enemy',
  init: ()->
    @requires 'Actor'
    return @

Crafty.c 'Obstacle',
  init: ()->
    @requires 'Actor'

    @onHit 'Player', @_onHit
    return @

  _onHit: (colliders) ->
    for collider in colliders
      collider.obj.x += -1 * collider.obj._movement.x
      collider.obj.y += -1 * collider.obj._movement.y

    return

Crafty.c 'Bullet',
  init: ()->
    @requires 'Actor'
    return @

Crafty.c 'Choppa',
  init: ()->
    @requires 'Actor'
    return @

Crafty.c 'Timer',
  init: ()->
    @requires '2D, DOM, Color'
    return @
