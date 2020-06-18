import 'package:flutter/material.dart';

class Professor {
  String name;
  double avgGpa;
  List<Term> terms;


  Professor({this.name, this.avgGpa, this.terms});

  List<String> getTermName(){
    return this.terms.map((t) => t.term).toList();
  }

  factory Professor.fromJson(Map<String, dynamic> json) {
     return new Professor(
       name:json['Instructor'],
       avgGpa: json['avgGpa'],
       terms: TermList.fromTermsJson(json['terms']).termList
     );
  }
}

class Term {
  final String term;
  //int aplus;
  final int a;
  //int aminus;
  //int bplus;
  final int b;
  //int bminus;
  //int cplus;
  final int c;
  //int cminus;
  //int dplus;
  final int d;
  //int dminus;
  final int f;

  const Term({this.term, this.a, this.b, this.c, this.d, this.f});
  //const Term(this.term, this.a, this.b, this.c, this.d, this.f);
  factory Term.fromJson(Map<String, dynamic> json){
    return new Term(
        term:json['term_name'],
        a:json['A'],
        b:json['B'],
        c:json['B'],
        d:json['B'],
        f:json['B'],
    );
  }
  /*fromTerm(Term another){
    this.term = another.term;
    this.a = another.a;
    this.b = another.b;
    this.c = another.c;
    this.d = another.d;
    this.f = another.f;
  }*/
}

class TermList {
  List<Term> termList;
  TermList({this.termList});
  factory TermList.fromTermsJson(List<dynamic> terms) {
    List<Term> _termList;
    Term t0 = new Term(term:'N/A', a:0,b:0,c:0,d:0,f:0);
    if (terms == null) {
      _termList.add(t0);
      return new TermList(termList: _termList);
    }
    _termList=terms.map((item) => Term.fromJson(item)).toList();
    _termList.add(t0);
    return new TermList(termList: _termList);
  }
}