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
import 'package:froshApp/util/snackbar_helper.dart';
import 'package:froshApp/virtualTour/virtualTour.dart';
import 'package:froshApp/widgets/colorLoader.dart';
import 'package:froshApp/widgets/horizontal_place_item.dart';
import 'package:froshApp/widgets/parallaxCard.dart';
import 'package:froshApp/widgets/vertical_place_item.dart';
import 'package:froshApp/util/const.dart';
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

  @override
  void initState() {
    super.initState();
    this.dio = new Dio();
  }

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withAlpha(220),
        child: Icon(
          LineAwesomeIcons.codepen,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VirtualTour()));
        },
      ),
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
                          image: "$apiUrl/imageassets/frosh.png",
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
                title: "Frosh Starter Kit",
                imageAddress: '$apiUrl/imageassets/starter.png',
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
                imageAddress: '$apiUrl/imageassets/team.png',
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
                      imageAddress: '$apiUrl/imageassets/society.png',
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
                      imageAddress: '$apiUrl/imageassets/event.png',
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
