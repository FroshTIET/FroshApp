class TimelineEvent {
  String title;
  String date;
  String eventType;
  int duration;
  String color;
  String icon;

  TimelineEvent(
      {this.title,
      this.date,
      this.eventType,
      this.duration,
      this.color,
      this.icon});

  TimelineEvent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    eventType = json['event_type'];
    duration = json['duration'];
    color = json['color'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['event_type'] = this.eventType;
    data['duration'] = this.duration;
    data['color'] = this.color;
    data['icon'] = this.icon;
    return data;
  }
}
