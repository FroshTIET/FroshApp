import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:froshApp/screens/faq.dart';
import 'package:froshApp/screens/teampage.dart';
import 'package:froshApp/state/themeNotifier.dart';
import 'package:froshApp/util/places.dart';
import 'package:froshApp/widgets/horizontal_place_item.dart';
import 'package:froshApp/widgets/icon_badge.dart';
import 'package:froshApp/widgets/parallaxCard.dart';
import 'package:froshApp/widgets/search_bar.dart';
import 'package:froshApp/widgets/vertical_place_item.dart';
import 'package:froshApp/util/const.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeWrapper extends StatefulWidget {
  ThemeData currentTheme = Constants.lightTheme;
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _title = '';
  String _message = '';

  void _launchLogic(message) {
    message = Map.from(message);
    print(message);
    try {
      var notifAction = message['data']['url'];
      _launchURL(notifAction);
    } catch (e) {}
  }

  void setUpMessaging() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() {
        _title = message['notification']['title'];
        _message = message['notification']['body'];
      });
    }, onResume: (Map<String, dynamic> message) async {
      _launchLogic(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      _launchLogic(message);
    });

    FlutterError.onError = null;
    _firebaseMessaging.getToken().then((token) => print("tokenkey: " + token));
    _firebaseMessaging.subscribeToTopic("allusers");
  }

  @override
  void initState() {
    super.initState();
    setUpMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Provider.of<ThemeProvider>(context).theme,
      darkTheme: Constants.darkTheme,
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    List posts = [
      "https://img.wallpapersafari.com/desktop/1680/1050/61/10/9W7j8L.jpg",
      "https://i.ytimg.com/vi/woOzxGLqXL8/maxresdefault.jpg",
      "https://static.rfstat.com/media/Thumbnails/Gallery_2019/12_12_2019/73_Event_Teaser_Promo_Pack/244b3826-6963-4546-b71f-d4e75786c188.jpg"
    ];
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.settings),
      //       onPressed: Provider.of<ThemeProvider>(context).switchTheme,
      //     ),
      //   ],
      // ),

      // body: ListView(
      //   physics: BouncingScrollPhysics(),
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(20.0),
      //       child: Text(
      //         "Where are you \ngoing?",
      //         style: TextStyle(
      //           fontSize: 30.0,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ),
      //     // Padding(
      //     //   padding: EdgeInsets.all(20.0),
      //     //   child: SearchBar(),
      //     // ),
      //     buildHorizontalList(context),
      //     buildVerticalList(),
      //   ],
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      title: AnimatedOpacity(
                          opacity: top <= 100 ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Text("Frosh 2K20")),
                      centerTitle: true,
                      background: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              "https://i.ytimg.com/vi/qjDdb6u4iXM/maxresdefault.jpg",
                          fit: BoxFit.fill,
                        ),
                      ));
                },
              ),
            ),
          ];
        },
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ShowSelectorWidget(
              title: "Upcoming Events",
            ),
            CarouselSlider(
              enlargeCenterPage: true,
              autoPlay: true,
              height: 200.0,
              viewportFraction: 0.8,
              items: posts.map((post) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => WallpaperPage(
                        //                 heroId: '${post.name}',
                        //                 posts: posts,
                        //                 index: posts.indexOf(post),
                        //               )));
                        // },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: GestureDetector(
                            child: SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Center(
                                            child: Icon(
                                              Icons.error,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                          child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Theme.of(context)
                                                            .accentColor),
                                              ))),
                                        ),
                                    imageUrl: post),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 200,
              child: ParallaxCard(
                title: "Frosh Starter Kit",
                imageAddress: 'assets/starterkit.jpg',
                onTapFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StarterKit()));
                },
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: ParallaxCard(
                title: "Our Team",
                imageAddress: 'assets/images/1616109.jpg',
                onTapFunction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamPage(),
                      ));
                },
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: ParallaxCard(
                      title: "Societies",
                      imageAddress: 'assets/images/societies.jpg',
                      onTapFunction: () {
                        print("societies pressed");
                      },
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    child: ParallaxCard(
                      title: "Events",
                      imageAddress: 'assets/images/bg1.jpeg',
                      onTapFunction: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0.0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place);
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}

class ShowSelectorWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ShowSelectorWidget({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      trailing: Icon(Icons.info),
      hoverColor: Colors.grey,
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.clip,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
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
