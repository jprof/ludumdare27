ASSETS = [
  'assets/images/arnold.png',
  'assets/images/choppa.png',
  'assets/images/crate.png',
  'assets/images/gameover.png',
  'assets/images/grass.png',
  'assets/images/pregame_splash1.png',
  'assets/images/pregame_splash2.png',
  'assets/images/soldier.png',
  'assets/images/tree.png'
]
Crafty.scene "load", ()->
  console.log "Loading started"

  Crafty.load ASSETS, ()->
    Crafty.scene "title"
    console.log "Loading assets"
  return


Crafty.scene "title", ()->
  proceedToMain = ()->
    console.log "Loading Main"
    Crafty.scene "main"


  displayTitle = () ->
    title = Crafty.e "Title"
    text = Crafty.e "2D, DOM, Color, Text, Keyboard"

    text.attr { x: 750, y: 10, w: 300, h: 100 }
    text.textFont { family: "Arial", size: "30px" }
    text.textColor "white", 1
    text.css { "font-size": "30px", "font-weight": "bold", "color": "white" }
    text.text "Get to the Choppa!"
    text.bind "EnterFrame", ()->
      text.x -= 2

    # if no keyboard input is received, proceed to main in 10 seconds.
    proceedTimeout = setTimeout proceedToMain, 10000

    # if keyboard input is received, clear the timeout and proceed to main
    text.bind 'KeyDown', () ->
      console.log "KeyDown"
      clearTimeout proceedTimeout
      proceedToMain()
  
  displayTitle()

  return
