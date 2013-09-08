// Generated by CoffeeScript 1.6.2
(function() {
  Crafty.c("LevelLoader", {
    init: function() {
      this.requires("Persist");
      this.currentLevel = -1;
      this.currentLives = 5;
      return this.ef = Crafty.e('EntityFactory');
    },
    nextLevel: function() {
      this.currentLevel += 1;
      if (this.currentLevel >= LEVELS.length) {
        return Crafty.scene("YouWin");
      } else {
        return this.loadCurrentLevel();
      }
    },
    reloadCurrentLevel: function() {
      this.currentLives -= 1;
      if (this.currentLives <= 0) {
        return Crafty.scene("GameOver");
      } else {
        return this.loadCurrentLevel();
      }
    },
    loadCurrentLevel: function() {
      var c, cl, e, t, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref, _ref1, _ref2, _ref3, _ref4;

      console.log("Current Level: ", this.currentLevel);
      cl = LEVELS[this.currentLevel];
      this.ef.createBG();
      this.ef.createTimer();
      this.ef.createLivesLeft(this.currentLives);
      this.ef.createPlayer(cl.player.x, cl.player.y);
      console.log(cl);
      _ref = cl.enemies;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        e = _ref[_i];
        this.ef.createSoldier(e.x, e.y, e.patrol, e.speed, e.framesToPatrol);
      }
      _ref1 = cl.crates;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        c = _ref1[_j];
        this.ef.createCrate(c.x, c.y);
      }
      _ref2 = cl.trees;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        t = _ref2[_k];
        this.ef.createTree(t.x, t.y);
      }
      _ref3 = cl.choppa;
      for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
        c = _ref3[_l];
        this.ef.createChoppa(c.x, c.y);
      }
      _ref4 = cl.entities;
      for (_m = 0, _len4 = _ref4.length; _m < _len4; _m++) {
        e = _ref4[_m];
        this.ef.createEntity(e.components, e.attrs);
      }
    }
  });

  Crafty.c('EntityFactory', {
    init: function() {
      return this.requires("Persist");
    },
    createPlayer: function(x, y) {
      var mouseClickListener, player;

      player = Crafty.e("Player");
      player.attr({
        x: x,
        y: x,
        w: 46,
        h: 63
      });
      player.fourway(2);
      player.startPosition(x, y);
      mouseClickListener = Crafty.e("ViewportMouseListener");
      mouseClickListener.attr({
        x: 0,
        y: 0,
        w: Game.STAGE_WIDTH,
        h: Game.STAGE_HEIGHT
      });
      return mouseClickListener.areaMap([0, 0], [Game.STAGE_WIDTH, 0], [Game.STAGE_WIDTH, Game.STAGE_HEIGHT], [0, Game.STAGE_HEIGHT]);
    },
    createSoldier: function(x, y, patrol, patrolSpeed, patrolFrames) {
      var enemy;

      enemy = Crafty.e("Enemy, Soldier, TimedShot, " + patrol);
      enemy.attr({
        x: x,
        y: y,
        w: 46,
        h: 63
      });
      enemy.patrolSpeed(patrolSpeed);
      enemy.patrolFrames(patrolFrames);
      return enemy.pewPewSetup(50, Crafty("Player"), "white", 3);
    },
    createCrate: function(x, y) {
      var crate;

      crate = Crafty.e("Obstacle, CrateSprite");
      return crate.attr({
        x: x,
        y: y,
        w: 75,
        h: 75
      });
    },
    createTree: function(x, y) {
      var tree;

      tree = Crafty.e("Obstacle, TreeSprite");
      return tree.attr({
        x: x,
        y: y,
        w: 101,
        h: 104
      });
    },
    createLivesLeft: function(val) {
        var livesleft, livesleftBG;
        livesleft = Crafty.e("LivesLeft");
        livesleft.attr({
            x: 800-300,
            y: 20,
            w: 200,
            h: 100
        });
        livesleft.textColor("yellow");
        livesleft.textFont({
            family: "Arial",
            size: "20px",
        });
        livesleft.updateLivesLeft(val);
        livesleftBG = Crafty.e("2D, DOM, Color");
        livesleftBG.color('white');
        return livesleftBG.attr({
            x: livesleft._x,
            y: livesleft._y,
            w: 150,
            h: 25,
            z: -10
        });
    },
    createTimer: function() {
      var timer, timerBG;

      timer = Crafty.e("Timer");
      timer.attr({
        x: 800 - 70,
        y: 20,
        w: 200,
        h: 100
      });
      timer.textFont({
        family: "Arial",
        size: "20px"
      });
      timer.textColor("red");
      timerBG = Crafty.e("2D, DOM, Color");
      timerBG.color('white');
      return timerBG.attr({
        x: timer._x,
        y: timer._y,
        w: 50,
        h: 25,
        z: -10
      });
    },
    createBG: function() {
      var bg;

      return bg = Crafty.e("GameBG");
    },
    createChoppa: function(x, y) {
      var choppa;

      choppa = Crafty.e("Goal, Choppa");
      return choppa.attr({
        x: x,
        y: y,
        w: 121,
        h: 52
      });
    },
    createEntity: function(components, attrs) {
      var e;

      e = Crafty.e(components);
      return e.attr(attrs);
    },
    createBarriers: function() {
      var tree;

      tree = Crafty.e("Obstacle");
      tree.attr({
        x: -100,
        y: -100,
        w: 1000,
        h: 90
      });
      tree = Crafty.e("Obstacle");
      tree.attr({
        x: -100,
        y: -100,
        w: 90,
        h: 800
      });
      tree = Crafty.e("Obstacle");
      tree.attr({
        x: -100,
        y: 700,
        w: 1000,
        h: 90
      });
      tree = Crafty.e("Obstacle");
      return tree.attr({
        x: -800,
        y: -100,
        w: 90,
        h: 800
      });
    }
  });

}).call(this);