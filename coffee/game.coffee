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
    obstacle.attr { x: 60, y: 60, w: 20, h: 20 }
    obstacle.color "blue"

    return

    # Load assets here! Something like this:
    #  Crafty.sprite(100, 100, 'assets/img/building1.gif', {
    #    building1: [0, 0]
    #  })

    #Crafty.scene "main"

