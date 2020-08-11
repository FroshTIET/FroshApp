import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParallaxCard extends StatefulWidget {
  int sizeOfCard = 1;
  String title = "no title supplied";
  String subtitle = "no subtitle supplied";
  String imageAddress = "no image address";
  Function onTapFunction = () {};
//TODO replace by some " " for final app
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
  bool defaultPosition = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double percentageX = (localX / (size.width - 40)) * 100;
    double percentageY = (localY / 230) * 100;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(defaultPosition ? 0 : (0.3 * (percentageY / 50) + -0.3))
          ..rotateY(defaultPosition ? 0 : (-0.3 * (percentageX / 50) + 0.3)),
        alignment: FractionalOffset.center,
        child: Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
            color: Color(0xFFCCCCCC),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 60),
                  color: Color.fromARGB(120, 0, 0, 0),
                  blurRadius: 22,
                  spreadRadius: -20),
            ],
          ),
          child: GestureDetector(
            onTap: widget.onTapFunction,
            onPanCancel: () => setState(() => defaultPosition = true),
            onPanDown: (_) => setState(() => defaultPosition = false),
            onPanEnd: (_) => setState(() {
              localY = 115;
              localX = (size.width - 40) / 2;
              defaultPosition = true;
            }),
            onPanUpdate: (details) {
              if (mounted) setState(() => defaultPosition = false);
              if (details.localPosition.dx > 0 &&
                  details.localPosition.dy < 230) {
                if (details.localPosition.dx < size.width - 40 &&
                    details.localPosition.dy > 0) {
                  localX = details.localPosition.dx;
                  localY = details.localPosition.dy;
                }
              }
            },
            child: ClipRRect(
              child: Container(
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            defaultPosition
                                ? 0.0
                                : (8 * (percentageX / 50) + -8),
                            defaultPosition
                                ? 0.0
                                : (8 * (percentageY / 50) + -8),
                            0.0),
                      alignment: FractionalOffset.center,
                      child: Opacity(
                        opacity: 0.4,
                        child: Image.asset(
                          widget.imageAddress,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.translationValues(
                            (size.width - 90) - localX,
                            (230 - 50) - localY,
                            0.0,
                          ),
                          child: AnimatedOpacity(
                            opacity: defaultPosition ? 0 : 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.22),
                                  blurRadius: 100,
                                  spreadRadius: 40,
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            defaultPosition
                                ? 0.0
                                : (15 * (percentageX / 50) + -15),
                            defaultPosition
                                ? 0.0
                                : (15 * (percentageY / 50) + -15),
                            0.0),
                      alignment: FractionalOffset.center,
                      child: Padding(
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
                      ),
                    )
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
