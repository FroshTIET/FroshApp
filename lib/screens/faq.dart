import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    var pixelheight = MediaQuery.of(context).size.height / 100;
    var pixelwidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 2 * pixelheight,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Text(
                  "FAQ",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                ),
              ),
              SizedBox(
                height: pixelwidth,
              ),
              Divider(
                endIndent: 10 * pixelwidth,
                thickness: 2,
              ),
              SizedBox(
                height: pixelheight * 3,
              ),
              Text(
                "What are the store timings ?",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "> The store is open 7 days a week, from 9AM to 9PM.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: pixelheight * 2,
              ),
              Text(
                "Where is the store located ?",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "> There are three Franchises of P&G Stores in India, one in Mumbai, one in Kolkata and one in Delhi.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: pixelheight * 2,
              ),
              Text(
                "What all can I purchase at the P&G Store ?",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "> You can buy all sorts of items ranging from cosmetics, groceries and decor to televisions, washing machines and Air Conditioners.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: pixelheight * 2,
              ),
              Text(
                "Are return accepted at P&G ?",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "> All non-cosmetics icons can be returned within a period of 7 days from purchase. No questions asked.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: pixelheight * 2,
              ),
              Text(
                "How can I apply for a P&G store card ?",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "> Invoke the Voice Assistant with the blue button below, and say 'I would like to purchase a new store card'. A representative will get in touch with you shortly.",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: pixelheight * 4,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    print("Chat page");
                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 1.0,
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Colors.black,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.085,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: Text(
                            "Chat with us",
                            style: TextStyle(fontSize: 25),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 130,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 12,
                      ),
                      materialCat(Icon(Icons.store_mall_directory), "Website",
                          () async {
                        _launchURL("https://froshtiet.com");
                      }),
                      SizedBox(
                        width: 12,
                      ),
                      materialCat(Icon(Icons.image), "Facebook", () {
                        print("Hello");
                        _launchURL("https://in.pg.com/");
                      }),
                      SizedBox(
                        width: 12,
                      ),
                      materialCat(Icon(Icons.call), "Contact Us", () {
                        _launchURL("tel:+91 9872466977");
                      }),
                      SizedBox(
                        width: 12,
                      ),
                      materialCat(Icon(Icons.chat), "Feedback", () {
                        _launchURL(
                            "mailto:feedback@pg.com?subject=AppFeedback");
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: pixelheight * 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

materialCat(icon, name, ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Material(
      color: Colors.white,
      elevation: 12.0,
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Color(0x802196F3),
      child: Container(
        height: 80,
        width: 80,
        child: Stack(
          children: <Widget>[
            Container(
              height: 60,
              width: 80,
              color: Colors.transparent,
              child: icon,
            ),
            Positioned(
              top: 45,
              child: Container(
                height: 30,
                width: 80,
                child: Center(
                    child: Text(
                  name,
                  style: TextStyle(fontSize: 12),
                )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
