window.Game =
  STAGE_WIDTH: 800
  STAGE_HEIGHT: 600
  start: ()->
    Crafty.init Game.STAGE_WIDTH, Game.STAGE_HEIGHT
    Crafty.background "green"
    player = Crafty.e "Player"
    player.attr { x: 10, y: 10, w: 10, h:10 }
    player.fourway 5
    player.color "red"

    obstacle = Crafty.e "Obstacle"
    obstacle.attr { x: 200, y: 200, w: 60, h: 60 }
    obstacle.color "blue"

    timer = Crafty.e "Timer"
    timer.attr { x: @STAGE_WIDTH - 70, y: 20, w: 200, h:100 }
    timer.textFont { family: "Arial", size: "20px" }
    timer.textColor "red"

    mouseClickListener = Crafty.e "ViewportMouseListener"
    mouseClickListener.attr {x: 0, y:0, w: Game.STAGE_WIDTH, h: Game.STAGE_HEIGHT}
    mouseClickListener.bind 'Click', (e) ->
      console.log "Clicked the mouse at (" + e.x + ","+e.y+")"
      return
    mouseClickListener.areaMap [0,0],
                               [Game.STAGE_WIDTH, 0],
                               [Game.STAGE_WIDTH,  Game.STAGE_HEIGHT],
                               [0, Game.STAGE_HEIGHT]

    return

    # Load assets here! Something like this:
    #  Crafty.sprite(100, 100, 'assets/img/building1.gif', {
    #    building1: [0, 0]
    #  })

    #Crafty.scene "main"

