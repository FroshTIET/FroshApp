import 'package:flutter/material.dart';
import 'package:froshApp/login/loginScreen.dart';
import 'package:froshApp/main.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/models/student.dart';
import 'package:froshApp/util/getProfileInfo.dart';
import 'package:froshApp/util/snackbar_helper.dart';
import 'package:froshApp/widgets/colorLoader.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
    with SingleTickerProviderStateMixin {
  List<DrawerList> drawerList;
  @override
  void initState() {
    setdDrawerListArray();
    super.initState();
  }

  void setdDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Naman Monga',
        icon: Icon(Icons.person),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'TIET-O-101903572',
        icon: Icon(Icons.art_track),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: 'Computer Engineering',
        icon: Icon(Icons.book),
      ),
      DrawerList(
          index: DrawerIndex.Invite,
          labelName: '29th January, 2001',
          icon: Icon(Icons.event),
          addDivider: true),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About Us',
        icon: Icon(Icons.info),
      ),
    ];
  }

  Future<List<DrawerList>> getDrawerList() async {
    Student _student = await getProfileDetails(userToken);

    List<DrawerList> drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: _student.fullName,
        icon: Icon(Icons.person),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: _student.rollNumber,
        icon: Icon(Icons.art_track),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: _student.branch == null ? "" : _student.branch,
        icon: Icon(Icons.book),
      ),
      DrawerList(
          index: DrawerIndex.Invite,
          labelName: _student.birthday == null ? "" : _student.birthday,
          icon: Icon(Icons.event),
          addDivider: true),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'Log out',
        icon: Icon(Icons.logout),
        redirectPage: MyApp(),
      ),
    ];
    // drawerList.add(DrawerList(
    //   index: DrawerIndex.HOME,
    //   labelName: _student.fullName,
    //   icon: Icon(Icons.person),
    // ));
    // print(drawerList.length);
    // drawerList.addAll([
    //   DrawerList(
    //     index: DrawerIndex.HOME,
    //     labelName: _student.fullName,
    //     icon: Icon(Icons.person),
    //   ),
    //   DrawerList(
    //     index: DrawerIndex.Help,
    //     labelName: _student.rollNumber,
    //     icon: Icon(Icons.art_track),
    //   ),
    //   DrawerList(
    //     index: DrawerIndex.Invite,
    //     labelName: _student.branch,
    //     icon: Icon(Icons.book),
    //   ),
    //   DrawerList(
    //       index: DrawerIndex.Invite,
    //       labelName: _student.birthday,
    //       icon: Icon(Icons.event),
    //       addDivider: true),
    //   DrawerList(
    //     index: DrawerIndex.Share,
    //     labelName: 'Rate the app',
    //     icon: Icon(Icons.share),
    //   ),
    //   DrawerList(
    //     index: DrawerIndex.About,
    //     labelName: 'About Us',
    //     icon: Icon(Icons.info),
    //   ),
    // ]);
    // print(drawerList);
    return drawerList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDrawerList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ColorLoader3(),
            );
          } else if (snapshot.data == null) {
            return Container(
              height: 900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.error,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text("Failed to load user information"),
                  )
                ],
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return inkwell(snapshot.data[index]);
                    },
                  ),
                ),
              ],
            );
          }
        });
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () async {
          if (listData.redirectPage != null) {
            userToken = "";
            firebaseToken = "";
            await prefs.setString("userToken", "");

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => listData.redirectPage),
                (Route<dynamic> route) => false);
          }
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Icon(
                    listData.icon.icon,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            listData.addDivider
                ? Divider(
                    thickness: 1,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList(
      {this.addDivider = false,
      this.labelName = '',
      this.icon,
      this.index,
      this.imageName = '',
      this.redirectPage});

  String labelName;
  Icon icon;
  bool addDivider;
  String imageName;
  DrawerIndex index;
  Widget redirectPage;
}
