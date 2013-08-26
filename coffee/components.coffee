Crafty.c 'Actor',
  init: ()->
    @requires '2D, Canvas, Collision'
    return @

Crafty.c 'Obstacle',
  init: ()->
    @requires 'Actor'

    @onHit 'Player', @_onHit
    @onHit 'Bullet', @_bulletHitsObstacle
    return @

  _onHit: (colliders) ->
    for collider in colliders
      collider.obj.x += -1 * collider.obj._movement.x
      collider.obj.y += -1 * collider.obj._movement.y

    return
  
  _bulletHitsObstacle: (bullets) ->
    for bullet in bullets
      bullet.obj.destroy()
    return

Crafty.c 'Bullet',
  init: ()->
    @requires '2D, Canvas, Collision, Color'
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
    @w = @h = 2 #hard code it for now
   
    
    @ang = Math.atan2( (@target_y - @start_y) , (@target_x - @start_x) )
    @cosAng = Math.cos(@ang)
    @sinAng = Math.sin(@ang)

    @bind 'EnterFrame', @_enterFrame

    return

  _enterFrame: () ->
    @x += @speed_x * @cosAng
    @y += @speed_y * @sinAng
    return

Crafty.c 'Goal',
  init: ()->
    @requires 'Actor'
    return @

Crafty.c 'Choppa',
  init: ()->
    @requires 'ChoppaSprite, SpriteAnimation'
    @animate 'ChoppaSpin', 0, 0, 3
    @animate 'ChoppaSpin', 10, -1
    return


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
    #clearInterval @enemyInterval
    @unbind "EnterFrame"
    Crafty.scene "main"

    return @

# so we can click to shoot
Crafty.c 'ViewportMouseListener',
  init: () ->
    @requires '2D, DOM, Mouse'
    @areaMap [0,0],
             [Game.STAGE_WIDTH, 0],
             [Game.STAGE_WIDTH,  Game.STAGE_HEIGHT],
             [0, Game.STAGE_HEIGHT]
    @bind 'Click', @_mouseClick
    return @

  _mouseClick: (e) ->
    Player = Crafty("Player")
    playerCenterX = Player.x + Player.w / 2
    playerCenterY = Player.y + Player.h / 2

    #adjust for fact that Crafty stage won't start at window's 0,0
    targX = e.x - Crafty.stage.x
    targY = e.y - Crafty.stage.y

    console.log "Clicked the mouse at (" + e.x + ","+e.y+")"
    console.log "Target at (" + targX + ","+targY+")"
    bullet = Crafty.e "Bullet"
    bullet.color "white"
    bullet.fire playerCenterX, playerCenterY, targX, targY, 5, 5

    return

Crafty.c 'Title',
  init: ()->
    @requires '2D, DOM, TitleScreen'
    @attr { x: 0, y: 0, w: 800, h: 600 }
    @frameCount = 0
    @bind 'EnterFrame', ()->
      if @frameCount > 15
        @toggleScreen()
        @frameCount = 0
      @frameCount += 1

  # Switch between the two sprites!
  toggleScreen: ()->
    @toggleComponent 'TitleScreen, TitleScreen2'

    return @

Crafty.c 'GameBG',
  init: ()->
    @requires '2D, Canvas, Image'
    @attr { x: 0, y: 0, w: 800, h: 600 }
    @image 'assets/images/grass.png'
    return @

