enum NotificationType {
  alert,
  success,
  warning,
  system,
  read,
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String typeText;
  final String time;
  final NotificationType type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.typeText,
    required this.time,
    required this.type,
  });

  bool get isUnread => type != NotificationType.read;
}