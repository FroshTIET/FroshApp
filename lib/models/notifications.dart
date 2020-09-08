class NotificationItem {
  String title;
  String description;
  String eventDate;
  String imageLink;
  String redirectUrl;
  bool sound;

  NotificationItem(
      {this.title,
      this.description,
      this.eventDate,
      this.imageLink,
      this.redirectUrl,
      this.sound});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    eventDate = json['event_date'];
    imageLink = json['image_link'];
    redirectUrl = json['redirect_url'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['event_date'] = this.eventDate;
    data['image_link'] = this.imageLink;
    data['redirect_url'] = this.redirectUrl;
    data['sound'] = this.sound;
    return data;
  }
}
