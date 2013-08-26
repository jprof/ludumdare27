window.Game =
  STAGE_WIDTH: 800
  STAGE_HEIGHT: 600
  start: ()->
    Crafty.init Game.STAGE_WIDTH, Game.STAGE_HEIGHT

    Crafty.sprite(46, 63, 'assets/images/arnold.png', {
      HeroSprite:[0, 0]
    })

    Crafty.sprite(46, 63, 'assets/images/soldier.png', {
      SoldierSprite: [0, 0]
    })

    Crafty.sprite(121, 50, 'assets/images/choppa.png', {
      ChoppaSprite: [0, 0]
    })

    Crafty.sprite(101, 104, 'assets/images/tree.png', {
      TreeSprite: [0, 0]
    })

    Crafty.sprite(75, 75, 'assets/images/crate.png', {
      CrateSprite: [0, 0]
    })

    Crafty.sprite(800, 600, 'assets/images/pregame_splash1.png', {
      TitleScreen: [0, 0]
    })

    Crafty.sprite(800, 600, 'assets/images/pregame_splash2.png', {
      TitleScreen2: [0, 0]
    })

    Crafty.scene "load"

    Crafty.scene "main", () ->
      bg = Crafty.e "GameBG"

      player = Crafty.e "Player"
      player.attr { x: 10, y: 10, w: 46, h:63 }
      player.fourway 2

      choppa = Crafty.e "Goal, Choppa"
      choppa.attr { x: 400, y: 400, w: 121, h: 52 }

      enemy1 = Crafty.e "Enemy, Soldier"
      enemy1.attr { x: 300, y: 20, w: 46, h: 63 }
      moveEnemy = ()-> enemy1.verticalPatrol enemy1.y
      enemy1.bind "EnterFrame", moveEnemy

      enemy2 = Crafty.e "Enemy, Soldier"
      enemy2.attr { x: 100, y: 50, w: 46, h: 63 }
      moveEnemy = ()-> enemy2.horizontalPatrol enemy2.x
      enemy2.bind "EnterFrame", moveEnemy

      tree = Crafty.e "Obstacle, TreeSprite"
      tree.attr { x: 200, y: 200, w: 101, h: 104 }

      crate  = Crafty.e "Obstacle, CrateSprite"
      crate.attr { x: 600, y:400 , w: 75, h: 75 }

      enemy = Crafty.e "Enemy, Soldier"
      enemy.attr { x: 300, y: 300, w: 46, h: 63 }

      timer = Crafty.e "Timer"
      timer.attr { x: 800 - 70, y: 20, w: 200, h:100 }
      timer.textFont { family: "Arial", size: "20px" }
      timer.textColor "red"

      timerBG = Crafty.e "2D, DOM, Color"
      timerBG.color 'white'
      timerBG.attr { x: timer._x, y: timer._y, w: 50, h: 25, z: -10 }

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


