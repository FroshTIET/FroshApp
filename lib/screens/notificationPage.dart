import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/models/notifications.dart';
import 'package:froshApp/widgets/colorLoader.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<List<NotificationItem>> getNotifications() async {
    List<NotificationItem> _notList = [];
    Dio dio = new Dio();
    Response _response = await dio.get("$apiUrl/app/notifications");
    for (var item in _response.data) {
      _notList.add(NotificationItem.fromJson(item));
    }

    return await _notList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Previous Notifications"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Container(
            child: FutureBuilder(
              future: getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return ColorLoader3();
                else if (snapshot.data == null)
                  return Text("An error occured");
                else
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListItem(
                        data: snapshot.data[index],
                      );
                    },
                  );
              },
            ),
          ),
        ));
  }
}

class ListItem extends StatelessWidget {
  ListItem({Key key, this.data}) : super(key: key);

  final NotificationItem data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        elevation: 2.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        child: new InkWell(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ClipRRect(
                child: new Image.network(
                  data.imageLink ?? 'https://via.placeholder.com/400x200',
                ),
                borderRadius: BorderRadius.only(
                  topLeft: new Radius.circular(16.0),
                  topRight: new Radius.circular(16.0),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(16.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(data.title,
                        style: Theme.of(context).textTheme.title),
                    new SizedBox(height: 16.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(data.description),
                        new Text(
                            "${DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(int.parse(data.eventDate) * 1000))}"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            _launchURL(data.redirectUrl);
          },
        ),
      ),
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
