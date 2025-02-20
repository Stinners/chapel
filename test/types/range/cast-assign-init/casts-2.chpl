var rb = false..true;
tryCasts(rb);

var ri0 = 0..1;
var ri1 = 1..2;
var rin = -2..2;
tryCasts(ri0);
tryCasts(ri1);
tryCasts(rin);

var ru0 = 0:uint..1:uint;
var ru1 = 1:uint..2:uint;
var rup = (max(uint))-10..(max(uint))-9;
tryCasts(ru0);
tryCasts(ru1);
tryCasts(rup);

proc tryCasts(r) {
  type types = (bool, int, uint, int(8), uint(8));
  for param i in 0..<types.size do
    tryCast(r, types(i));
}
  
proc tryCast(r, type t) {
  writeln("casting ", r, " to range of ", t:string);
  var res = r: range(t);
  printRange(res);

  writeln("casting ", r, " to stridable range of ", t:string, ":");
  var resStr = r: range(t, strides=strideKind.any);
  printRange(resStr);
}

proc printRange(r) {
  writeln("  ", r, ": ", (r.low, r.high, r.stride, r.alignment));
  writeln();
}
