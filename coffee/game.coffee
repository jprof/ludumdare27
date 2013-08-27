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

    Crafty.sprite(800, 600, 'assets/images/gameover.png', {
      GameOverScreen: [0, 0]
    })

    Crafty.sprite(800, 600, 'assets/images/winner.png', {
      WinnerScreen: [0, 0]
    })

    Crafty.scene "load"


    Crafty.scene "main", () ->
      game = Crafty.e 'LevelLoader'
      game.nextLevel()
      return


