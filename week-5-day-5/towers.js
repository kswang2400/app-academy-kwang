
var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Hanoi(name) {
  this.name = name;
  this.towers = [[1, 2, 3],[],[]];
  this.winNow = [[],[1, 2, 3],[]];
}

Hanoi.prototype.askUser = function (callback, endCallback) {
  var game = this;
  reader.question("Pick a from pile    \n", function(fromPick) {
    reader.question("Pick a to pile      \n", function(toPick) {
      var fromPile = game.towers[fromPick];
      var toPile   = game.towers[toPick];

      if (game.validMove(fromPile, toPile)) {
        callback(fromPick, toPick);
      } else {
        if (toPick === "Power Overwhelming!!") {
          game.cheat();
        }
        console.log("invalid move");
      }
      game.play(endCallback);
    });
  });
};

Hanoi.prototype.cheat = function () {
  this.towers = this.winNow;
};

Hanoi.prototype.move = function(fr, to) {
  this.towers[to].unshift(this.towers[fr].shift());
};

Hanoi.prototype.play = function (endCallback) {
  this.print();
  if (this.win()) {
    endCallback.bind(this)();
  } else {
    this.askUser(this.move.bind(this), endCallback);
  }
};


Hanoi.prototype.print = function() {
  console.log("------------------------");
  console.log(this.towers);
  console.log("------------------------");
};

Hanoi.prototype.validMove = function(fr, to) {
  if (to === undefined) {
    console.log("\nPick a move!\n");
  } else if (fr.length === 0) {
    console.log("\nEmpty Pile\n");
  } else if ((fr[0] > to[0]) &&
            (to.length >= 1)) {
    console.log("\nInvalid Move, Disk Size no Good\n");
  } else {
    return true;
  }

  return false;
};

Hanoi.prototype.win = function () {
  if ((this.towers[0].length === 0) &&
     ((this.towers[1].length === 3) || (this.towers[2].length === 3))) {
    return true;
  } else {
    return false;
  }
};

function startGame() {
  reader.question("Welcome to Towers of Hanoi! Enter your name:  ", function(name) {
    var towers = new Hanoi(name);
    towers.play(endGame);
  });
}

function endGame () {
  console.log("\nGood Job " + this.name);
  reader.close();
}


startGame();
