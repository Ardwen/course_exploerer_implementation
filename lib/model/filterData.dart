import 'package:flutter/material.dart';

class Professor {
  String name;
  double avgGpa;
  List<Term> terms;


  Professor({this.name, this.avgGpa, this.terms
  });

  /*List<String> getTermName(){
    return this.terms.map((t) => t.term).toList();
  }*/

  factory Professor.fromJson(Map<String, dynamic> json) {
     return new Professor(
       name:json['professor_name'],
       avgGpa: json['professor_avg'],
       terms: TermList.fromTermsJson(json['terms']).termList
     );
  }
}

class Term {
  String term;
  int a;
  int b;
  int c;
  int d;
  int f;

  Term({this.term, this.a, this.b, this.c, this.d, this.f});

  factory Term.fromJson(Map<String, dynamic> json){
    return new Term(
        term:json['term_name'],
        a:json['A'],
        b:json['B'],
        c:json['C'],
        d:json['D'],
        f:json['F'],
    );
  }

}

class TermList {
  List<Term> termList;
  TermList({this.termList});
  factory TermList.fromTermsJson(List<dynamic> terms) {
    List<Term> _termList = terms.map((item) => Term.fromJson(item)).toList();
    return new TermList(termList: _termList);
  }
}