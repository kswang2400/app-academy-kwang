function exponent(num, pow) {
  if (pow === 0) {
    return 1;
  } else {
    return num * exponent(num, pow-1);
  }
}


function fibonacci(n) {
  if (n < 3) {
    return [0,1].slice(0,n);
  } else {
    var last = fibonacci(n-1);
    var length = last.length;
    var next = [last[length - 1] + last[length -2]];
    return last.concat(next);
  }
}

function binary_search(arr, target) {
  var pivot = parseInt(arr.length / 2);

  if (arr.length === 1 && arr[0] != target) {
    return -1;
  } else if (arr[pivot] === target) {
    return pivot;
  } else if ( arr[pivot] > target ) {
    return binary_search(arr.slice(0, pivot), target);
  } else if ( arr[pivot] < target ) {
    var result =  binary_search(arr.slice(pivot, arr.length), target);
    if (result === -1) {
      return result
    }
    return result + pivot;
  }
}

function make_change(num, coins) {
  if (coins.prototype.includes(num)) {
    return [num];
  } else if ( coins[coins.length-1] > num) {
    return [];
  }
  var possible_coins = [];

  for (i = 0; i < coins.length; i ++) {

    if (num > coins[i]){
      remainder = num - coins[i];
      remaining_coins = make_change(remainder, coins);
      if (remaining_coins.length === 0) {i++;}
      remaining_coins.push(coin);
      possible_coins.push(remaining_coins);
    } else {
      i++;
    }
  }
  return possible_coins;
}

// console.log(exponent(5,4));
// console.log(fibonacci(20));
// console.log(binary_search([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20], 15));
