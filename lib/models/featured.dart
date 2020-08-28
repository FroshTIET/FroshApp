class FeaturedEvent {
  String title;
  String imageLink;
  String redirectUrl;

  FeaturedEvent({this.title, this.imageLink, this.redirectUrl});

  FeaturedEvent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageLink = json['image_link'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image_link'] = this.imageLink;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
