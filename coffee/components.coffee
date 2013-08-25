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

  fire: (start_x,start_y,target_x,target_y,speed_x,speed_y) ->
    @start_x = start_x
    @start_y = start_y
    @target_x = target_x
    @target_y = target_y
    @speed_x = speed_x
    @speed_y = speed_y
    @x = start_x
    @y = start_y
    @w = @h = 1 #hard code it for now
   
    
    @ang = Math.atan2( (@target_y - @start_y) , (@target_x - @start_x) )
    @cosAng = Math.cos(@ang)
    @sinAng = Math.sin(@ang)

    @bind 'EnterFrame', @_enterFrame

    return

  _enterFrame: () ->
    @x += @speed_x * @cosAng
    @y += @speed_y * @sinAng
    return
    

Crafty.c 'Choppa',
  init: ()->
    @requires 'Actor'
    return @

Crafty.c 'Timer',
  init: ()->
    @requires '2D, DOM, Color'
    return @
