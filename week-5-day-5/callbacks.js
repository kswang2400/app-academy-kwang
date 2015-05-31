var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// TIMER
function Clock() {
}

var clock = new Clock();
Clock.TICK = 1000;

Clock.prototype.printTime = function() {
  console.log(this.time);
};

Clock.prototype.run = function() {
  var now = new Date();
  var hour = now.getHours();
  var min = now.getMinutes();
  var sec = now.getSeconds();

  this.time = (hour + ":" + min + ":" + sec);
  this.printTime();
  this._tick();
};

Clock.prototype._tick = function() {
  setTimeout(this.run.bind(clock), Clock.TICK);
};

// ADD NUMBERS
var addNumbers = function (sum, numLeft, completionCallback) {

  var callback = function(num) {
    sum = sum + parseInt(num);
    console.log("\nTotal:       " + sum + "\n")
    numLeft--;
    addNumbers(sum, numLeft, completionCallback);
  };

  if (numLeft > 0) {
    // var sum = sum;
    // var numLeft = numLeft;
    // var completionCallback = completionCallback;

    reader.question("Next number: ", callback);
  } else {
    completionCallback(sum);
  }
}

// BUBBLE SORT OPTIMIZED!
var slightlyLessAbsurdBubbleSort = function (arr, sortCompletionCallback) {
  // initiate first iteration
  var madeAnySwaps = true;
  var end = arr.length - 1;

  function outerBubbleSortLoop (madeAnySwaps, end) {
    if (madeAnySwaps) {
      // reset madeAnySwaps to check swaps during new iteration, start at i=0
      madeAnySwaps = false;
      var i = 0;
      innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop, end);
    } else {
      // no swaps made this iteration, sort complete
      sortCompletionCallback(arr);
    }
  }

  // sort!
  outerBubbleSortLoop(madeAnySwaps, end);
}

var askIfGreaterThan = function(el1, el2, callback) {
  // ask user to compare adjacent numbers
  reader.question(
    "Is " + el1 + " greater than " + el2 + "? (y,n)  ", function(answer) {
    if (answer == 'y') {
      callback(true);
    } else {
      callback(false);
    }
  });
}

var innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop, end) {
  if (i < end) {
    askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
      // callback for askIfGreaterThan to do swap
      // increments i, run iteration again
      if (isGreaterThan) {
        // if true, do swap, notify swap was made
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        madeAnySwaps = true;
      }
      i++;
      innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop, end);
    });
  } else {
    // check if swap was made this iteration, go back to the top
    end--;
    outerBubbleSortLoop(madeAnySwaps, end);
  }
}

clock.run();

addNumbers(0, 3, function (sum) {
  console.log("Total Sum:   " + sum);
});

// slightlyLessAbsurdBubbleSort([3, 2, 1, 8, 2, 3, 5, 0], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });
