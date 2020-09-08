import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/models/student.dart';
import 'package:froshApp/util/getProfileInfo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardTwoPage extends StatelessWidget {
  static final String path = "lib/src/pages/misc/dash2.dart";
  final TextStyle whiteText = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "ACADEMICS",
          style: GoogleFonts.openSans(letterSpacing: 3, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 50.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        _launchURL("https://ln-k.cf/timetable");
                      },
                      child: Container(
                        height: 190,
                        color: Color(0xff2e77c3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text("How to",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              trailing: Icon(
                                FontAwesomeIcons.table,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'read the Timetable',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () async {
                        Student _student = await getProfileDetails(userToken);
                        _launchURL(_student.whatsappLink);
                      },
                      child: Container(
                        height: 120,
                        color: Color(0xff00c8e9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text("Join",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              trailing: Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Whatsapp Group',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _launchURL("https://ln-k.cf/lmsupdate");
                      },
                      child: Container(
                        height: 120,
                        color: Color(0xff00c8e9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "LMS",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.users,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('Student Portal',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 15)),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _launchURL("https://ln-k.cf/studymat");
                      },
                      child: Container(
                        height: 190,
                        color: Color(0xff2e77c3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text("Study",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              trailing: Icon(
                                FontAwesomeIcons.book,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Material',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final today = DateTime.now();
    final startClass = DateTime(2020, 09, 22);
    int difference = startClass.difference(today).inDays;
    if (difference < 0) difference = 0;
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            value: difference / 20,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Initiation of Classes",
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 15.0),
              Text(
                "$difference day" + ((difference != 1) ? "s to go" : " to go"),
                style: TextStyle(
                    color: Colors.black.withAlpha(200), fontSize: 16.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
