module Structure {
  use LinkedLists;

  class GrandParent {
    var gp_field: int;
    proc baz() {
      writeln("in GrandParent() baz");
    }
  }

  class Parent : GrandParent {
    param rank:int;
    type idxType;
    param strides: strideKind;

    proc foo( arg: rank*range(idxType, boundKind.both,strides) ) {
      writeln("in Parent(", rank, ") foo ", arg);
    }
    proc bar() {
      writeln("in Parent(", rank, ") bar ");
    }

  }

  class SubParent : Parent {
    type eltType;
  }


  class ListerGrandParent {
    var lst: LinkedList(unmanaged GrandParent);
  }

  class ListerParent : ListerGrandParent {
    param rank:int;
    type idxType;
    param strides: strideKind;

    proc getListedType() type {
      return unmanaged Parent(rank=rank, idxType=idxType, strides=strides);
    }
  }

  proc test(lhs:?t) where isSubtype(t, ListerParent) {
    type subType = lhs.getListedType();
    for e in lhs.lst {
      var eCast = e: subType?;
      if eCast == nil then
        halt("X");

      writeln("foo");
      (e:subType?)!.foo( (100..100,) );
      writeln("bar");
      eCast!.bar();
      writeln("baz");
      e.baz();
    }
  }


}

module Impl {
  use Structure;

  class Child : SubParent {
    var x:eltType;
    
    override proc foo( arg: rank*range(idxType, boundKind.both, strides) ) {
      writeln("in Child(", rank, ") foo ", arg, " " , x);
    }
    override proc bar() {
      writeln("in Child(", rank, ") bar ", x);
    }
    override proc baz() {
      writeln("in Child(", rank, ") baz ", x);
    }

  }


  proc main() {
    var aa = new unmanaged Child(rank=1, idxType=int, strides=strideKind.one, eltType=real);
    writeln(aa);

    var a = new unmanaged Child(rank=1, idxType=int, strides=strideKind.one, eltType=int);
    var ownD = new owned ListerParent(rank=1, idxType=int, strides=strideKind.one);
    var d = ownD.borrow();
    d.lst.append(a);

    test(d);

    delete a, aa;
  }
}
