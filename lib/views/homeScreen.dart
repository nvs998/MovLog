import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movlog/views/addMovie.dart';
import 'package:movlog/views/signUpScreen.dart';
import 'package:movlog/widgets/functions.dart';
import 'package:movlog/widgets/movie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widgets/globals.dart' as glb;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Movie currMovie;
  bool newMovieAdded = false;
  CarouselController carouselController = CarouselController();
  _HomeScreenState() {
    glb.films = [];
  }

  void _alertDialog(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      style: AlertStyle(
        backgroundColor: Colors.blue[100],
      ),
      title: "Sign Out?",
      buttons: [
        DialogButton(
          color: Color(0xff000428),
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () async {
            await glb.googleSignIn.disconnect();
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xff000428),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Opacity(
        opacity: glb.films.length > 0 ? 1 : 0.1,
        child: FloatingActionButton(
          onPressed: glb.films.length > 0
              ? () {
                  setState(() {
                    int temp = glb.films.indexOf(currMovie);
                    glb.films.remove(currMovie);
                    if (temp >= glb.films.length) {
                      temp = glb.films.length - 1;
                    }
                    if (temp < 0) {
                      currMovie = Movie(Image.asset("images/account.jpg"), "NA",
                          "NA", "NA", "0", 0, "NA");
                    } else {
                      currMovie = glb.films[temp];
                    }
                  });
                }
              : null,
          child: Icon(Icons.delete),
          backgroundColor: Colors.red[900],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff000000),
              Color(0xff000428),
              Color(0xff000000)
            ])),
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 30, bottom: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Image.asset('images/account.png'),
                    iconSize: 40,
                    onPressed: () => _alertDialog(context),
                  ),
                  Text(
                    "MovLog",
                    style: textDesignbold(20),
                  ),
                  SizedBox(height: 0, width: 60)
                ],
              ),
            ),
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: BouncingScrollPhysics(),
                height: 400.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage:
                    glb.films.isEmpty ? 0 : glb.films.indexOf(currMovie),
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (i, _) {
                  if (glb.films.isNotEmpty && newMovieAdded == false)
                    setState(() {
                      currMovie = glb.films[i];
                      print("ho rha hai " + i.toString());
                    });
                  if (newMovieAdded) newMovieAdded = false;
                },
                scrollDirection: Axis.horizontal,
              ),
              items: glb.films.isEmpty
                  ? [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.asset("images/emptyLast.png"),
                          ),
                        ),
                      )
                    ]
                  : glb.films.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: i.poster,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
            ),
            SizedBox(height: 10,),
            glb.films.isEmpty
                ? Expanded(
                    child: Text(
                    "Your Collection List is Empty !",
                    style: TextStyle(color: Colors.white,fontFamily: "Cabin",fontSize: 18),
                  ))
                : Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Text(
                            currMovie.name.toUpperCase(),
                            style: textDesignbold(18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              currMovie.year.toString(),
                              style: textDesign(16),
                            ),
                            Icon(
                              Icons.circle,
                              size: 14,
                              color: Colors.grey[700],
                            ),
                            Text(
                              currMovie.genre,
                              style: textDesign(16),
                            ),
                            Icon(
                              Icons.circle,
                              size: 14,
                              color: Colors.grey[700],
                            ),
                            Text(
                              currMovie.duration,
                              style: textDesign(16),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating: currMovie.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            unratedColor: Colors.grey[700],
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.lime[600],
                            ),
                            onRatingUpdate: (rating) {
                              currMovie.rating = rating;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Directed By : " + currMovie.director,
                            style: textDesign(18),
                          ),
                        ),
                      ],
                    ),
                  ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewMovie()))
                    .then((value) {
                  if (glb.films.isNotEmpty)
                    setState(() {
                      newMovieAdded = true;
                      currMovie = glb.films.last;
                      carouselController
                          .jumpToPage(glb.films.indexOf(currMovie));
                    });
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                child: Text(
                  "Add Movie",
                  style: textDesign(22),
                ),
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/button.png")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
