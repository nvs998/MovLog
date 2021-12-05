import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:movlog/widgets/movie.dart';
import '../widgets/globals.dart' as glb;
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:movlog/widgets/functions.dart';

class NewMovie extends StatefulWidget {
  @override
  _NewMovieState createState() => _NewMovieState();
}

class _NewMovieState extends State<NewMovie> {
  final _movieNameController = TextEditingController();
  final _directorNameController = TextEditingController();
  final _genreController = TextEditingController();
  final _yearController = TextEditingController();
  final _durHController = TextEditingController();
  final _durMController = TextEditingController();

  String pickedFilePath;
  String fileStatus = "No File Uploaded";
  bool retry = false;
  double rating = 5.0;

  void _submitData() {
    final enteredTitle = _movieNameController.text;
    final enteredDirector = _directorNameController.text;
    final enteredGenre = _genreController.text;
    final enteredHour = _durHController.text;
    final enteredMin = _durMController.text;
    final enteredYear = _yearController.text;

    if (enteredTitle.isEmpty ||
        enteredDirector.isEmpty ||
        pickedFilePath == null ||
        enteredGenre.isEmpty ||
        enteredYear.isEmpty ||
        enteredHour.isEmpty ||
        enteredMin.isEmpty) {
      glb.showSnackBar('One or more fields are empty !', context);
      return;
    }
    String duration = enteredHour + "h " + enteredMin + "m";
    Movie newMovie = Movie(Image.file(File(pickedFilePath)), enteredTitle,
        enteredGenre, enteredDirector, enteredYear, 0, duration);
  
    glb.films.add(newMovie);
    Navigator.of(context).pop();
  }

  uploadFile() async {
    if (await Permission.storage.request().isGranted) {
      final FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);
      pickedFilePath = pickedFile.paths.last;
      setState(() {
        retry = false;
        fileStatus = "Image Uploaded";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "MovLog",
          style: textDesignbold(20),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xff000000),
                Color(0xff000428),
                Color(0xff000000)
              ])),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset:
                                  Offset(1, 7),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Movie name',
                        ),
                        controller: _movieNameController,
                        onSubmitted: (_) => _submitData(),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset:
                                  Offset(1, 7),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(hintText: 'Director name'),
                        controller: _directorNameController,
                        onSubmitted: (_) => _submitData(),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset:
                                  Offset(1, 7),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Year',
                        ),
                        controller: _yearController,
                        onSubmitted: (_) => _submitData(),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset:
                                  Offset(1, 7),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Genre',
                        ),
                        controller: _genreController,
                        onSubmitted: (_) => _submitData(),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Duration : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Cabin",
                              fontSize: 18),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(1, 7), 
                                  )
                                ]),
                            child: TextField(
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Hours',
                              ),
                              controller: _durHController,
                              onSubmitted: (_) => _submitData(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(1, 7), 
                                  )
                                ]),
                            child: TextField(
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Minutes',
                              ),
                              controller: _durMController,
                              onSubmitted: (_) => _submitData(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 43, bottom: 10),
                      child: Center(
                        child: Text(
                          "Upload Movie Poster",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Cabin"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            uploadFile();
                          },
                          child: Text(
                            "Choose a File",
                            style: textDesign(16),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              fileStatus + "  ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Visibility(
                              visible: fileStatus == "Image Uploaded",
                              child: Image.asset(
                                'images/fileUploaded.png',
                                height: 20,
                                width: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      child: Text(
                        'Add Movie',
                        style: textDesign(18),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        padding: MaterialStateProperty.all(EdgeInsets.all(13)),
                        elevation: MaterialStateProperty.all(10),
                      ),
                      onPressed: _submitData,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
