window.Game =
  STAGE_WIDTH: 800
  STAGE_HEIGHT: 600
  start: ()->
    Crafty.init Game.STAGE_WIDTH, Game.STAGE_HEIGHT
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

      enemy1 = Crafty.e "Enemy, Soldier"
      enemy1.attr { x: 300, y: 20, w: 46, h: 63 }
      enemy1.color "white"
      moveEnemy = ()-> enemy1.verticalPatrol enemy1.y
      enemy1.bind "EnterFrame",moveEnemy

      enemy2 = Crafty.e "Enemy, Soldier"
      enemy2.attr { x: 100, y: 50, w: 46, h: 63 }
      enemy2.color "white"
      moveEnemy = ()-> enemy2.horizontalPatrol enemy2.x
      enemy2.bind "EnterFrame",moveEnemy

      obstacle = Crafty.e "Obstacle"
      obstacle.attr { x: 200, y: 200, w: 60, h: 60 }
      obstacle.color "blue"

      enemy = Crafty.e "Enemy, Soldier"
      enemy.attr { x: 300, y: 300, w: 46, h: 63 }

      timer = Crafty.e "Timer"
      timer.attr { x: 800 - 70, y: 20, w: 200, h:100 }
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

