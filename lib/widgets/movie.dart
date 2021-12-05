import 'package:flutter/material.dart';

class Movie {
  Image poster;
  String name;
  String director;
  double rating;
  String genre;
  String year;
  String duration;

  Movie(this.poster, this.name, this.genre, this.director, this.year,
      this.rating,this.duration);
}
