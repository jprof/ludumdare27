Crafty.c "LevelLoader",
  init: ()->
    @requires "Persist"
    @currentLevel = -1
    @currentLives = 5
    @ef = Crafty.e 'EntityFactory'

  nextLevel:()->
    @currentLevel += 1
    if @currentLevel >= LEVELS.length
      Crafty.scene "YouWin"
    else
      @loadCurrentLevel()

  reloadCurrentLevel: ()->
    @currentLives -= 1
    if @currentLives <= 0
      Crafty.scene "GameOver"
    else
      @loadCurrentLevel()

  loadCurrentLevel: ()->
    console.log "Current Level: ", @currentLevel
    # cl -> current level object
    cl = LEVELS[@currentLevel]
    @ef.createBG()
    @ef.createTimer()

    @ef.createPlayer cl.player.x, cl.player.y

    console.log cl

    for e in cl.enemies
      @ef.createSoldier e.x, e.y, e.patrol, e.speed, e.framesToPatrol

    for c in cl.crates
      @ef.createCrate c.x, c.y

    for t in cl.trees
      @ef.createTree t.x, t.y

    for c in cl.choppa
      @ef.createChoppa c.x, c.y

    for e in cl.entities
      @ef.createEntity e.components, e.attrs


    return

Crafty.c 'EntityFactory',
  init: ()->
    @requires "Persist"

  createPlayer: (x, y)->
    player = Crafty.e "Player"
    player.attr { x: x, y: x, w: 46, h:63 }
    player.fourway 2
    player.startPosition x, y

    mouseClickListener = Crafty.e "ViewportMouseListener"
    mouseClickListener.attr { x: 0, y:0, w: Game.STAGE_WIDTH, h: Game.STAGE_HEIGHT}
    mouseClickListener.areaMap [0,0],
                               [Game.STAGE_WIDTH, 0],
                               [Game.STAGE_WIDTH,  Game.STAGE_HEIGHT],
                               [0, Game.STAGE_HEIGHT]

  createSoldier: (x, y, patrol, patrolSpeed, patrolFrames)->
    enemy = Crafty.e "Enemy, Soldier, " + patrol
    enemy.attr { x: x, y: y, w: 46, h: 63 }
    enemy.patrolSpeed patrolSpeed
    enemy.patrolFrames patrolFrames

  createCrate: (x, y)->
    crate  = Crafty.e "Obstacle, CrateSprite"
    crate.attr { x: x, y: y, w: 75, h: 75 }

  createTree: (x, y)->
    tree = Crafty.e "Obstacle, TreeSprite"
    tree.attr { x: x, y: y, w: 101, h: 104 }

  createTimer: ()->
    timer = Crafty.e "Timer"
    timer.attr { x: 800 - 70, y: 20, w: 200, h:100 }
    timer.textFont { family: "Arial", size: "20px" }
    timer.textColor "red"

    timerBG = Crafty.e "2D, DOM, Color"
    timerBG.color 'white'
    timerBG.attr { x: timer._x, y: timer._y, w: 50, h: 25, z: -10 }

  createBG: ()->
    bg = Crafty.e "GameBG"

  createChoppa: (x, y)->
    choppa = Crafty.e "Goal, Choppa"
    choppa.attr { x: x, y: y, w: 121, h: 52 }

  createEntity: (components, attrs)->
    e = Crafty.e components
    e.attr attrs
