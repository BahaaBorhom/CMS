import 'package:cms/core/entities/notifications.dart';

class NotificationsState {
  final bool isLoading;
  final List<NotificationItem> allNotifications;
  final List<NotificationItem> filteredNotifications;
  final String selectedFilter;

  const NotificationsState({
    this.isLoading = false,
    this.allNotifications = const [],
    this.filteredNotifications = const [],
    this.selectedFilter = 'All',
  });

  NotificationsState copyWith({
    bool? isLoading,
    List<NotificationItem>? allNotifications,
    List<NotificationItem>? filteredNotifications,
    String? selectedFilter,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      allNotifications: allNotifications ?? this.allNotifications,
      filteredNotifications: filteredNotifications ?? this.filteredNotifications,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}