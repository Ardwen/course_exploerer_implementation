import 'package:flutter/material.dart';

class Professor {
  String name;
  double avgGpa;
  List<Term> terms;


  Professor(this.name, this.avgGpa, this.terms);

  List<String> getTermName(){
    return this.terms.map((t) => t.term).toList();
  }

  /*factory Professor.fromJson(Map<String, dynamic> json) {
     return new Professor(
       name:json['Instructor'],
       avgGpa: json['avgGpa'],
       terms:

     );
  }*/
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

  const Term(this.term, this.a, this.b, this.c, this.d, this.f);

  /*fromTerm(Term another){
    this.term = another.term;
    this.a = another.a;
    this.b = another.b;
    this.c = another.c;
    this.d = another.d;
    this.f = another.f;
  }*/



/*Term(this.term, this.aplus, this.a, this.aminus, this.bplus, this.b, this.bminus,
      this.cplus, this.c, this.cminus, this.dplus, this.d, this.dminus, this.f);*/

  /*factory Term.fromJson(Map<String, dynamic> json){
    return new Term(
      term:json[];

    )
  }*/
}