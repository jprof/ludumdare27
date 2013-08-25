window.Game =
  start: ()->
    @STAGE_WIDTH = 800
    @STAGE_HEIGHT = 600
    Crafty.init @STAGE_WIDTH, @STAGE_HEIGHT
    Crafty.background "green"

    Crafty.sprite(46, 63, 'assets/images/arnold.png', {
      TheHero: [0, 0]
    })

    Crafty.sprite(46, 63, 'assets/images/soldier.png', {
      Soldier: [0, 0]
    })

    Crafty.sprite(121, 50, 'assets/images/choppa.png', {
      Choppa1: [0, 0]
      Choppa2: [1, 0]
      Choppa3: [2, 0]
      Choppa4: [3, 0]
    })

    Crafty.scene "load"

    Crafty.scene "main", () ->
      player = Crafty.e "Player"
      player.attr { x: 10, y: 10, w: 46, h:63 }
      player.fourway 2

      obstacle = Crafty.e "Goal"
      obstacle.attr { x: 400, y: 400, w: 121, h: 52 }

      enemy = Crafty.e "Enemy, Soldier"
      enemy.attr { x: 300, y: 300, w: 46, h: 63 }

      timer = Crafty.e "Timer"
      timer.attr { x: 800 - 70, y: 20, w: 200, h:100 }
      timer.textFont { family: "Arial", size: "20px" }
      timer.textColor "red"
      return

    # Load assets here! Something like this:
    #  Crafty.sprite(100, 100, 'assets/img/building1.gif', {
    #    building1: [0, 0]
    #  })

    #Crafty.scene "main"

