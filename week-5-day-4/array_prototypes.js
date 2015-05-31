Array.prototype.uniq = function() {
  var new_array = [];

  this.forEach(
    function(el) {
      if (new_array.indexOf(el) === -1) {
        new_array.push(el);
      }
    }
  );

  return new_array;
}

Array.prototype.two_sum = function() {
  var output = [];

  for (var i = 0; i < this.length - 1 ; i++) {
    for (var j = i + 1; j < this.length; j ++) {
      if (this[i] + this[j] === 0 ) {
        output.push([i, j]);
      }
    }
  }

  return output;
}

Array.prototype.transpose = function() {
  var transposed = [];

  for (var x = 0; x < this[0].length; x++) {
    transposed[x] = new Array(this.length)
  }

  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this[0].length; j++) {
      transposed[j][i] = this[i][j]
    }
  }

  return transposed;
}

Array.prototype.myEach = function(f) {
  for (var i = 0; i < this.length; i++) {
    f(this[i])
  }

  return this;
}

Array.prototype.myMap = function(f) {
  var output = [];

  this.myEach(function(el) {
    output.push(f(el));
  });

  // var cb = function(el) {
  //   output.push(f(el));
  // }
  // this.myEach(cb);

  return output;
}

Array.prototype.myInject = function(accum, f) {
  if (accum === "undefined") {
    accum = this[0];
    var rest = this.slice(1,this.length);
  } else {
    var rest = this;
  }

  rest.myEach(function(el) {
    accum = f(accum, el);
  }
  )
  return accum;
}
var my_array = [1, 6, 9, 11]

console.log([1, 4, 6, 9].myEach(function(a) { console.log(a * 2); }));
console.log(my_array.myMap(function(a) { return (a * 2); }));
console.log(my_array);

console.log([1, 1, 2, 3, 4, 1, 4, 5, 6].uniq());
console.log([-1, 0, 2, -2, 1].two_sum());
console.log([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [9, 9, 9]
  ].transpose());

  console.log([1,5,9,3].myInject(10, function(x,y) { return x - y }));
