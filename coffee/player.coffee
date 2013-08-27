Crafty.c 'Player',
  init: () ->
    @requires 'Actor, Fourway, TheHero'
    @startX = @startY = 0
    return

  startPosition: (x, y)->
    @startX = x
    @startY = y
    return

  backToStart: ()->
    @attr { x: @startX, y: @startY }
    # attr worked here, but doing this didn't.
    #   @x = @startX
    #   @y = @starty
    # Why?
    return

  die: () ->
    return

# Component representing the animations and necessary state for animations of
# the player.
Crafty.c 'TheHero',
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
    @requires 'HeroSprite, SpriteAnimation'
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

    @bind "NewDirection", @_newDirection
    @bind "EnterFrame", @_enterFrameActive
    return

  # Fourway fires the "NewDirection" event. It passes an event object to the
  # callback with x and y fields representing the speed in each direction.
  # We can use this to change the directional state of the Player, and with
  # that we can animate the sprite using the "EnterFrame" event.
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
    #console.log @playerState, @moving

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
  
