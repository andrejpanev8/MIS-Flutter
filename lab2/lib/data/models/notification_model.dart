class NotificationModel {
  final String token;
  final String title;
  final String body;
  final String time;

  NotificationModel({
    required this.token,
    required this.title,
    required this.body,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      token: json['token'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'title': title,
      'body': body,
      'time': time,
    };
  }
}
