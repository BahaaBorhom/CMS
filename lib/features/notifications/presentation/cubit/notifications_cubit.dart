import 'package:cms/core/entities/notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState()) {
    _loadNotifications();
  }

  final List<NotificationItem> _sampleNotifications = [
    NotificationItem(
      id: '1',
      title: 'You\'re late for your appointment',
      body: 'Your appointment with Dr. Folan Al-Folani was scheduled for 9:00 AM. Please arrive as soon as possible.',
      typeText: 'Alert',
      time: 'Now',
      type: NotificationType.alert,
    ),
    NotificationItem(
      id: '2',
      title: 'Appointment confirmed',
      body: 'Your appointment with Dr. Samira Al-Masri has been confirmed for tomorrow at 2:00 PM.',
      typeText: 'Success',
      time: '5 min ago',
      type: NotificationType.success,
    ),
    NotificationItem(
      id: '3',
      title: 'Your next appointment is in 2 hours',
      body: 'Your appointment with Dr. Khalid Al-Hassan is scheduled for 11:00 AM. Please arrive 15 minutes early.',
      typeText: 'Warning',
      time: '1 hour ago',
      type: NotificationType.warning,
    ),
    NotificationItem(
      id: '4',
      title: 'New clinic available',
      body: 'A new clinic has been added to your area. Check out the latest services near you.',
      typeText: 'Update',
      time: '2 hours ago',
      type: NotificationType.system,
    ),
    NotificationItem(
      id: '5',
      title: 'Appointment reminder',
      body: 'You have an appointment with Dr. Layla Al-Ali tomorrow at 3:30 PM. Don\'t forget!',
      typeText: 'Reminder',
      time: '3 hours ago',
      type: NotificationType.system,
    ),
    NotificationItem(
      id: '6',
      title: 'Payment successful',
      body: 'Your payment of \$50.00 has been processed successfully. Thank you for choosing our service.',
      typeText: 'Payment',
      time: '5 hours ago',
      type: NotificationType.success,
    ),
    NotificationItem(
      id: '7',
      title: 'Profile updated',
      body: 'Your profile information has been successfully updated. You can review your changes anytime.',
      typeText: 'System',
      time: '1 day ago',
      type: NotificationType.read,
    ),
  ];

  void _loadNotifications() {
    emit(state.copyWith(
      isLoading: false,
      allNotifications: _sampleNotifications,
      filteredNotifications: _sampleNotifications,
    ));
  }

  void setFilter(String filter) {
    emit(state.copyWith(selectedFilter: filter));

    if (filter == 'All') {
      emit(state.copyWith(filteredNotifications: state.allNotifications));
      return;
    }

    if (filter == 'Unread') {
      final unread = state.allNotifications
          .where((n) => n.isUnread)
          .toList();
      emit(state.copyWith(filteredNotifications: unread));
      return;
    }

    // Filter by type
    final filtered = state.allNotifications
        .where((n) => n.typeText == filter)
        .toList();
    emit(state.copyWith(filteredNotifications: filtered));
  }

  void markAllAsRead() {
    final updated = state.allNotifications.map((n) {
      return n.type == NotificationType.read
          ? n
          : NotificationItem(
              id: n.id,
              title: n.title,
              body: n.body,
              typeText: n.typeText,
              time: n.time,
              type: NotificationType.read,
            );
    }).toList();

    emit(state.copyWith(
      allNotifications: updated,
      filteredNotifications: updated.where((n) {
        if (state.selectedFilter == 'All') return true;
        if (state.selectedFilter == 'Unread') return n.isUnread;
        return n.typeText == state.selectedFilter;
      }).toList(),
    ));
  }
  void markAsRead(String id) {
  final updated = state.allNotifications.map((n) {
    if (n.id == id && n.isUnread) {
      return NotificationItem(
        id: n.id,
        title: n.title,
        body: n.body,
        typeText: n.typeText,
        time: n.time,
        type: NotificationType.read,
      );
    }
    return n;
  }).toList();

  final filtered = updated.where((n) {
    if (state.selectedFilter == 'All') return true;
    if (state.selectedFilter == 'Unread') return n.isUnread;
    return n.typeText == state.selectedFilter;
  }).toList();

  emit(state.copyWith(
    allNotifications: updated,
    filteredNotifications: filtered,
  ));
}
}