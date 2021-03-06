Crafty.c 'Enemy',
  init: ()->
    @requires 'Actor'
    @countX = 0
    @countY = 0
    @switchDirX = 0
    @switchDirY = 0
    #@_patrol()
    return
  
  horizontalPatrol: (x)->
    # Random horizontal patrolling
    #console.log "I'm patrolling horizontally!"
    if @switchDirX == 0
      @x+=1
      @countX++
      if @countX >= 25
        @switchDirX = 1
    else
      @x-=1
      @countX--
      if @countX <= 0
        @switchDirX = 0
    return

  verticalPatrol: (y)->
    # Random vertical patrolling
    #console.log "I'm patrolling vertically!"
    if @switchDirY == 0
      #@y += ((Math.random()*10) + 1)
      @y+=1
      @countY++
      if @countY >= 25
        @switchDirY = 1
    else
      #@y -= ((Math.random()*10) + 1)
      @y-=1
      @countY--
      if @countY <= 0
        @switchDirY = 0
    return

# Component representing the animations and necessary state for animations of
# the enemy soldiers. This was blatantly copy and pasted from the PlayerSprite
# component in player.coffee.
Crafty.c 'Soldier',
  PlayerDirections:
    right: 0
    left: 1
    up: 2
    down: 3
    upRight: 4
    upLeft: 5
    downRight: 6
    downLeft: 7

  init: ()->
    @requires 'SoldierSprite, SpriteAnimation'
    @playerState = @PlayerDirections.right
    @moving = false

    @animate 'moveRight', 0, 0, 1
    @animate 'moveDown', 0, 1, 2
    @animate 'moveLeft', 0, 0, 1
    @animate 'moveUp', 0, 2, 2
    @animate 'moveUpRight', 0, 3, 1
    @animate 'moveUpLeft', 0, 4, 1
    @animate 'moveDownLeft', 0, 5, 1
    @animate 'moveDownRight', 0, 6, 1

    @bind "Move", @_getChangedDirection
    @bind "EnterFrame", @_enterFrameActive
    return

  # The 2D components fire a "Move", and "Change" event that pass the the old
  # values of the 2D attributes to the callback. They look like this:
  #   { _x: old_x_value, _y: old_y_value, _w: old_w_value, _h: old_h_value  }
  #
  # I expect that "Move" is fired when the x and y change and "Change" is fired
  # when w and h change.
  _getChangedDirection: (e)->
    dx = @_x - e._x
    dy = @_y - e._y
    # Acheive the same results as the "NewDirection" binding in the
    # PlayerSprite component.
    @_newDirection { x: dx, y: dy }


  _newDirection: (e)->
    if e.x == 0 and e.y == 0
      @playerState = @playerState
      @moving = false
    else
      @moving = true
      if e.x > 0 and e.y == 0
        @playerState = @PlayerDirections.right
      else if e.x == 0 and e.y > 0
        @playerState = @PlayerDirections.down
      else if e.x == 0 and e.y < 0
        @playerState = @PlayerDirections.up
      else if e.x < 0 and e.y == 0
        @playerState = @PlayerDirections.left
      else if e.x > 0 and e.y > 0
        @playerState = @PlayerDirections.downRight
      else if e.x < 0 and e.y > 0
        @playerState = @PlayerDirections.downLeft
      else if e.x < 0 and e.y < 0
        @playerState = @PlayerDirections.upLeft
      else if e.x > 0 and e.y < 0
        @playerState = @PlayerDirections.upRight

  _enterFrameActive: ()->
    CHANGE_SPEED = 10
    if @moving
      switch @playerState
        when @PlayerDirections.right
          @animate('moveRight', CHANGE_SPEED, -1)
        when @PlayerDirections.down
          @animate('moveDown', CHANGE_SPEED, -1)
        when @PlayerDirections.left
          @animate('moveLeft', CHANGE_SPEED, -1)
        when @PlayerDirections.up
          @animate('moveUp', CHANGE_SPEED, -1)
        when @PlayerDirections.upRight
          @animate('moveUpRight', CHANGE_SPEED, -1)
        when @PlayerDirections.upLeft
          @animate('moveUpLeft', CHANGE_SPEED, -1)
        when @PlayerDirections.downLeft
          @animate('moveDownLeft', CHANGE_SPEED, -1)
        when @PlayerDirections.downRight
          @animate('moveDownRight', CHANGE_SPEED, -1)
    else
      @stop()
  
