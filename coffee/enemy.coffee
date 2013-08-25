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
      @x+=5
      @countX++
      if @countX >= 5
        @switchDirX = 1
    else
      @x-=5
      @countX--
      if @countX <= 0
        @switchDirX = 0
    return

  verticalPatrol: (y)->
    # Random vertical patrolling
    #console.log "I'm patrolling vertically!"
    if @switchDirY == 0
      #@y += ((Math.random()*10) + 1)
      @y+=5
      @countY++
      if @countY >= 5
        @switchDirY = 1
    else
      #@y -= ((Math.random()*10) + 1)
      @y-=5
      @countY--
      if @countY <= 0
        @switchDirY = 0
    return

