Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  }
}

var func = function () { return ("I am " + this)};
var obj = {};

a = func.myBind(obj);
console.log(a());
console.log(func());
