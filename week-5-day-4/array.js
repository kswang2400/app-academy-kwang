function uniq(arr) {
  var new_array = [];

  arr.forEach(
    function(el) {
      if (new_array.indexOf(el) === -1) {
        new_array.push(el);
      }
    }
  );

  return new_array;
}

function two_sum(arr) {
  var output = [];

  for (var i = 0; i < arr.length - 1 ; i++) {
    for (var j = i + 1; j < arr.length; j ++) {
      if (arr[i] + arr[j] === 0 ) {
        output.push([i, j]);
      }
    }
  }

  return output;
}

function transpose(arr) {
  var transposed = [];

  for (var x = 0; x < arr[0].length; x++) {
    transposed[x] = new Array(arr.length)
  }

  for (var i = 0; i < arr.length; i++) {
    for (var j = 0; j < arr[0].length; j++) {
      transposed[j][i] = arr[i][j]
    }
  }

  return transposed;
}

console.log(uniq([1, 1, 2, 3, 4, 1, 4, 5, 6]));
console.log(two_sum([-1, 0, 2, -2, 1]));
console.log(transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [9, 9, 9]
  ]));
