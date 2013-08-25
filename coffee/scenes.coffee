ASSETS = [
  'assets/images/arnold.png',
  'assets/images/choppa.png',
  'assets/images/crate.png',
  'assets/images/gameover.png',
  'assets/images/grass.png',
  'assets/images/pregame_spash1.png',
  'assets/images/pregame_spash2.png',
  'assets/images/soldier.png',
  'assets/images/sprites.png',
  'assets/images/tree.png'
]

Crafty.scene "load", ()->
  console.log "Loading started"

  Crafty.load ASSETS, ()->
    Crafty.scene "main"
    console.log "Loading assets"
  return
