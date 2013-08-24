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
    @requires '2D, DOM, Color, Text'
    @endTime = @_getEndTime 10
    @textColor "Blue"
    @bind "EnterFrame", ()->
      timeLeft = @_getTimeLeft()
      if timeLeft <= 0
        @text "0.0"
        @levelOver()
      else
        d = new Date(timeLeft)
        @text "" + d.getSeconds() + "." + d.getMilliseconds()

  _getEndTime: (val)->
    # Return time from UNIX epoch, val seconds into the future.
    currentTime = new Date().getTime()
    endTime = currentTime + (1000 * val)
    return endTime

  _getTimeLeft: ()->
    # Get the difference in time from @endTime to the current time.
    # Returned as time from UNIX epoch.
    currentTime = new Date().getTime()
    return @endTime - currentTime

  levelOver: ()->
    # You lost!
    @unbind "EnterFrame"
    Crafty("Player").color "pink"

