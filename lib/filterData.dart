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
  String term;
  //int aplus;
  int a;
  //int aminus;
  //int bplus;
  int b;
  //int bminus;
  //int cplus;
  int c;
  //int cminus;
  //int dplus;
  int d;
  //int dminus;
  int f;

  Term(this.term, this.a, this.b, this.c, this.d, this.f);


/*Term(this.term, this.aplus, this.a, this.aminus, this.bplus, this.b, this.bminus,
      this.cplus, this.c, this.cminus, this.dplus, this.d, this.dminus, this.f);*/

  /*factory Term.fromJson(Map<String, dynamic> json){
    return new Term(
      term:json[];

    )
  }*/
}