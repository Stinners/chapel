class Obj { var x : int; var y : int; var z : int;}
use CTypes;
proc fn(f : c_ptr(void)) {
	writeln(f : unmanaged Obj?);
}


var obj = new unmanaged Obj(1,2,3);
fn(obj : c_ptr(void));

var obj2 : unmanaged Obj = new unmanaged Obj(4,5,6);
fn(obj2 : c_ptr(void));

delete obj;
delete obj2;
