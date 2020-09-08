import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/models/featured.dart';
import 'package:froshApp/screens/faq.dart';
import 'package:froshApp/screens/teampage.dart';
import 'package:froshApp/state/themeNotifier.dart';
import 'package:froshApp/util/places.dart';
import 'package:froshApp/util/sendFirebaseToken.dart';
import 'package:froshApp/util/snackbar_helper.dart';
import 'package:froshApp/virtualTour/virtualTour.dart';
import 'package:froshApp/widgets/colorLoader.dart';
import 'package:froshApp/widgets/horizontal_place_item.dart';
import 'package:froshApp/widgets/parallaxCard.dart';
import 'package:froshApp/widgets/vertical_place_item.dart';
import 'package:froshApp/util/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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

  void setUpMessaging() async {
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
    _firebaseMessaging.getToken().then((token) async {
      await sendFirebaseToken(userToken, token);
    });
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio;

  Future<List<FeaturedEvent>> getPosts() async {
    List<FeaturedEvent> _list = null;
    try {
      Response response = await this.dio.get("$apiUrl/app/featured/");
      _list = response.data
          .map<FeaturedEvent>((i) => FeaturedEvent.fromJson(i))
          .toList();
    } catch (e) {}
    await new Future.delayed(const Duration(milliseconds: 500));
    return _list;
  }

  Future<List<String>> getVirtTourImages() async {
    try {
      Dio dio = new Dio();
      Response _response = await dio.get("$apiUrl/app/virtualtour");
      return await (_response.data
          .map((x) => x['image_link'])
          .toList()
          .cast<String>());
    } catch (e) {
      showErrorToast(context,
          "Failed to fetch virtual tour images. Please check your internet connection.");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    this.dio = new Dio();
  }

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white.withAlpha(220),
      //   child: Icon(
      //     LineAwesomeIcons.codepen,
      //     color: Colors.black,
      //     size: 30,
      //   ),
      //   onPressed: () async {
      //     List<String> _imageLists = await getVirtTourImages();

      //     _imageLists == null
      //         ? null
      //         : Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => VirtualTour(_imageLists)));
      //   },
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
                          child: Text(
                            "FROSH  2020",
                            style: GoogleFonts.openSans(
                              letterSpacing: 5,
                              color: Colors.black.withAlpha(180),
                            ),
                          )),
                      centerTitle: true,
                      background: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        child: Image.asset(
                          "assets/homepage/banner3.jpg",
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
            GestureDetector(
              onTap: () => this.getPosts(),
              child: ShowSelectorWidget(
                title: "Upcoming Events",
              ),
            ),
            FutureBuilder(
                future: getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: ColorLoader3(),
                    );
                  } else if (snapshot.data == null) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: Icon(
                          Icons.error,
                          size: 40,
                        ),
                      ),
                    );
                  } else {
                    return CarouselSlider(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      height: 200.0,
                      viewportFraction: 0.8,
                      items: snapshot.data.map<Widget>((post) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => _launchURL(post.redirectUrl),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                            errorWidget: (context, url,
                                                    error) =>
                                                Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  ),
                                                ),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
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
                                                                Theme.of(
                                                                        context)
                                                                    .accentColor),
                                                      ))),
                                                ),
                                            imageUrl: post.imageLink),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 200,
              child: ParallaxCard(
                title: "",
                imageAddress: 'assets/homepage/starter_kit.jpg',
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
                title: "",
                imageAddress: 'assets/homepage/ourteam.png',
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
                      title: "",
                      imageAddress: 'assets/homepage/societies.jpg',
                      onTapFunction: () {
                        _launchURL(
                            "https://froshtiet.com/starter-kit/SocietiesInThapar.html");
                      },
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    child: ParallaxCard(
                      title: "Events",
                      imageAddress: 'assets/homepage/events.jpg',
                      onTapFunction: () {
                        _launchURL("https://froshtiet.com/events/");
                      },
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
      trailing: Icon(Icons.info_outline),
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
