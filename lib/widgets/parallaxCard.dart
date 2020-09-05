import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParallaxCard extends StatefulWidget {
  int sizeOfCard = 1;
  String title = "no title supplied";
  String subtitle = "no subtitle supplied";
  String imageAddress = "no image address";
  Function onTapFunction = () {};
// TODO replace by some " " for final app
  ParallaxCard(
      {this.sizeOfCard,
      this.title,
      this.subtitle,
      this.imageAddress,
      this.onTapFunction});
  @override
  _ParallaxCardState createState() => _ParallaxCardState();
}

class _ParallaxCardState extends State<ParallaxCard> {
  double localX = 0;
  double localY = 0;
  // bool defaultPosition = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double percentageX = (localX / (size.width - 40)) * 100;
    double percentageY = (localY / 230) * 100;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          // color: Color(0xFFCCCCCC),

          boxShadow: [
            BoxShadow(
                offset: Offset(0, 30),
                color: Colors.black54,
                blurRadius: 22,
                spreadRadius: -20),
          ],
        ),
        child: GestureDetector(
          onTap: widget.onTapFunction,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Image.network(
                      widget.imageAddress,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: widget.sizeOfCard == 1
                              ? GoogleFonts.creepster(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                )
                              : GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 28)),
                        ),
                        widget.sizeOfCard == 1
                            ? Text(widget.subtitle,
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ))
                            : SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
