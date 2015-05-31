function myEach(arr, f) {
  for (var i = 0; i < arr.length; i++) {
    f(arr[i])
  }

  return arr;
}

function myMap(arr, f) {
  var output = [];

  myEach(arr, function(el) {
    output.push(f(el));
  });

  return output;
}

var my_array = [1, 6, 9, 11]

console.log(myEach([1, 4, 6, 9], function(a) { console.log(a * 2); }));
console.log(myMap(my_array, function(a) { return (a * 2); }));
console.log(my_array);
