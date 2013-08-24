window.Game =
  start: ()->
    @STAGE_WIDTH = 800
    @STAGE_HEIGHT = 600
    Crafty.init @STAGE_WIDTH, @STAGE_HEIGHT
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
    return

    # Load assets here! Something like this:
    #  Crafty.sprite(100, 100, 'assets/img/building1.gif', {
    #    building1: [0, 0]
    #  })

    #Crafty.scene "main"

