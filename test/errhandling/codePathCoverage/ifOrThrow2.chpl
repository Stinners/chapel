proc testit2(d:domain) {
  return d;
}

proc testit(r: range(stridable=?)) throws {
  var dom: domain(1, strides=strideKind.any);
  if r.bounds != boundKind.both {
    throw new owned IllegalArgumentError('input range must be bounded');
    // unfortunate workaround: dom = {1..2};
  } else {
    dom = {r};
  }
  return testit2(dom);  // return dom;  <-- this works
}

writeln(testit(1..));
