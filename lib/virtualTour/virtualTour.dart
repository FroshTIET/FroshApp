import 'package:flutter/material.dart';
import 'package:froshApp/virtualTour/sphere3d.dart';

class VirtualTour extends StatefulWidget {
  @override
  _VirtualTourState createState() => _VirtualTourState();
}

class _VirtualTourState extends State<VirtualTour> {
  int currentPhoto = 0;
  bool interactive = false;
  List<String> _photos = [
    "https://i.imgur.com/4uTX1Jp.jpg",
    "https://i.imgur.com/KCsTLpt.jpg",
  ];

  int getNextIndex() {
    return currentPhoto + 1 > _photos.length - 1 ? 0 : currentPhoto + 1;
  }

  int getPreviousIndex() {
    return currentPhoto - 1 >= 0 ? currentPhoto - 1 : _photos.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottomBarItem(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              setState(() {
                this.currentPhoto = this.getPreviousIndex();
              });
              break;
            case 1:
              setState(() {
                interactive = !interactive;
              });
              break;
            case 2:
              setState(() {
                this.currentPhoto = this.getNextIndex();
              });
              break;
            default:
          }
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      );
    }

    Widget _bottomBar = SizedBox(
      height: 110,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _bottomBarItem(Icons.arrow_back_ios, 0),
                  Container(),
                  _bottomBarItem(
                      interactive ? Icons.settings_overscan : Icons.data_usage,
                      1),
                  Container(),
                  _bottomBarItem(Icons.arrow_forward_ios, 2)
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Prev',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(),
                  Text(
                    'Toggle Controls',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(),
                  Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Thapar Virtual Tour !"),
      ),
      body: Stack(
        children: [
          CameraClass(
            animSpeed: 0,
            interactive: interactive,
            sensorControl:
                interactive ? SensorControl.None : SensorControl.Orientation,
            child: Image.network(_photos[currentPhoto]),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              child: _bottomBar,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
