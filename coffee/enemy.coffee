Crafty.c 'Enemy',
  init: ()->
    @requires 'Actor'
    @onHit "Player", @_resetPlayer
    return
  
  # Move the player back to where they started when an enemy touches them.
  _resetPlayer: (targets)->
    for target in targets
      target.obj.backToStart()
    return
    
Crafty.c "HorizontalPatrol",
  init: ()->
    @countX = 0
    @framesToPatrol = 25
    @speed = 1
    @switchDirX = 0

    @countY = 0
    @switchDirY = 0

    @bind "EnterFrame", @_horizontalPatrol

  patrolSpeed: (speed)->
    @speed = speed

  patrolFrames: (frames)->
    @framesToPatrol = frames

  # Random horizontal patrolling
  _horizontalPatrol: ()->
    if @switchDirX == 0
      @x += @speed
      @countX++
      if @countX >= @framesToPatrol
        @switchDirX = 1
    else
      @x -= @speed
      @countX--
      if @countX <= 0
        @switchDirX = 0
    return

Crafty.c "VerticalPatrol",
  init: ()->
    @countY = 0
    @framesToPatrol = 25
    @speed = 1
    @switchDirY = 0

    @bind "EnterFrame", @_verticalPatrol

  patrolSpeed: (speed)->
    @speed = speed

  patrolFrames: (frames)->
    @framesToPatrol = frames

  _verticalPatrol: ()->
    # Random vertical patrolling
    if @switchDirY == 0
      @y += @speed
      @countY++
      if @countY >= @framesToPatrol
        @switchDirY = 1
    else
      @y -= @speed
      @countY--
      if @countY <= 0
        @switchDirY = 0
    return

# I tried to reuse the Horizontal and Vertical patrol components, but the way
# they update does not work with the way our animation is update.
Crafty.c "DiagonalPatrol",
  Directions:
    DownRight: { x: 1, y: 1}
    DownLeft:  { x: -1, y: 1}
    UpRight:   { x: 1, y: -1}
    UpLeft:    { x: -1, y: -1}

  init: ()->
    @framesToPatrol = 25
    @speed = 1
    @count = 0
    @switchDir = 0
    @patrolDir = @Directions.DownRight

    @bind "EnterFrame", @_patrolBoth

  patrolSpeed: (speed)->
    @speed = speed

  patrolFrames: (frames)->
    @framesToPatrol = frames

  _patrolBoth: ()->
    newX = newY = 0
    if @switchDir == 0
      @count += 1
      newX = @_x + @patrolDir.x
      newY = @_y + @patrolDir.y
      if @count >= @framesToPatrol
        @switchDir = 1
    else
      @count -= 1
      newX = @_x - @patrolDir.x
      newY = @_y - @patrolDir.y
      if @count <= 0
        @switchDir = 0
    @attr { x: newX, y: newY }
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
    @animate 'moveLeft', 0, 7, 1
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
  
