
function bubbleSort(arr) {
  var count = 0
  var end = arr.length

  for (var c = 0; c < arr.length; c++) {
    for (var i = 0; i < end - 1; i++) {
      count++;
      if (arr[i] > arr[i+1]) {
        temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
      }
    }
    end--
  }

  console.log(count)
  return arr
}

var arr = [ 1220, 560, 200, 134, 123, 106, 46, 22, 4, 3, 1];
console.log(bubbleSort(arr));

function substrings(str) {
  var output = [];

  for (var i = 0; i < str.length; i++) {
    for (var j = i + 1; j < str.length + 1; j++) {
      output.push(str.slice(i, j))
    }
  }

  return output;
}

console.log(substrings("cat"))
