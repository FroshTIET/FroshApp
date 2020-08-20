import 'package:flutter/material.dart';
import 'package:froshApp/screens/faq.dart';
import 'package:froshApp/widgets/profileContent.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:RetailAssistant/utilities/sizeConfig.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            color: Colors.blueGrey[900],
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 10 * MediaQuery.of(context).size.height / 100),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 11 * MediaQuery.of(context).size.height / 100,
                        width: 22 * MediaQuery.of(context).size.width / 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/1.jpeg"))),
                      ),
                      SizedBox(
                        width: 5 * MediaQuery.of(context).size.width / 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Text(
                              "Naman Monga",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5 *
                                      MediaQuery.of(context).size.width /
                                      100,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height:
                                1 * MediaQuery.of(context).size.height / 100,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.alternate_email,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "elephants@gmail.com",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 1.8 *
                                        MediaQuery.of(context).size.height /
                                        100,
                                    fontWeight: FontWeight.bold),
                              ),
                              //     Row(
                              //       children: <Widget>[
                              //         Icon(
                              //           Icons.shopping_cart,
                              //           color: Colors.white,
                              //           size: 15,
                              //         ),
                              //         SizedBox(
                              //           width: 1 *
                              //               MediaQuery.of(context).size.width /
                              //               100,
                              //         ),
                              //         Text(
                              //           "5 Orders",
                              //           style: TextStyle(
                              //             color: Colors.white60,
                              //             fontSize: 2 *
                              //                 MediaQuery.of(context).size.height /
                              //                 100,
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 3 *
                              //               MediaQuery.of(context).size.width /
                              //               100,
                              //         ),
                              //         Icon(
                              //           Icons.language,
                              //           color: Colors.white,
                              //           size: 15,
                              //         ),
                              //         SizedBox(
                              //           width: 1 *
                              //               MediaQuery.of(context).size.width /
                              //               100,
                              //         ),
                              //         Text(
                              //           "English",
                              //           style: TextStyle(
                              //             color: Colors.white60,
                              //             fontSize: 2 *
                              //                 MediaQuery.of(context).size.height /
                              //                 100,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3 * MediaQuery.of(context).size.height / 100,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "69420",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5 *
                                      MediaQuery.of(context).size.width /
                                      100,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Total Frosh Score",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                    3 * MediaQuery.of(context).size.width / 100,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "3rd",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5 *
                                      MediaQuery.of(context).size.width /
                                      100,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Event Ranking",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                    3 * MediaQuery.of(context).size.width / 100,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MentorPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Refresh Stats",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 3 *
                                        MediaQuery.of(context).size.width /
                                        100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 35 * MediaQuery.of(context).size.height / 100),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0),
                  )),
              child: Container(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: HomeDrawer()),
            ),
          )
        ],
      ),
    );
  }
}
