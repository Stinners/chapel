class MyClass {
  var x:int;
}

record GenericCollection {
  var field;
}

{
  var a = new GenericCollection(new owned MyClass());
  writeln("a ", a.type:string, " has field ", a.field.type:string);
}

{
  var b:GenericCollection(owned MyClass)
        = new GenericCollection(new owned MyClass());
  writeln("b ", b.type:string, " has field ", b.field.type:string);
}

{
  var ownInner = new owned MyClass();
  var c:GenericCollection(borrowed MyClass)
        = new GenericCollection(ownInner.borrow());
  writeln("(borrowed) c ", c.type:string, " has field ", c.field.type:string);
}

{
  var a:GenericCollection(owned MyClass?);
  a.field = new owned MyClass();
  writeln("a ", a.type:string, " has field ", a.field.type:string);
}

{
  var b:GenericCollection(owned MyClass?);
  b.field = new owned MyClass();
  writeln("b ", b.type:string, " has field ", b.field.type:string);
}

{
  var c:GenericCollection(borrowed MyClass?);
  var other = new owned MyClass();
  c.field = other;
  writeln("(borrowed) c ", c.type:string, " has field ", c.field.type:string);
}
