import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/api/notification_api.dart';
import 'package:twitter_clone/core/enum/notification_type_enum.dart';
import 'package:twitter_clone/models/notification_model.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
  return NotificationController(ref.watch(notificationAPIProvider));
});

final getLatestNotificationProvider = StreamProvider((ref) {
  final norificationAPI = ref.watch(notificationAPIProvider);
  return norificationAPI.getLatestNotification();
});

final getNotificationsProvider = FutureProvider.family((ref, String uid) async {
  final notificationController =
      ref.watch(notificationControllerProvider.notifier);
  return notificationController.getNotifications(uid);
});

class NotificationController extends StateNotifier<bool> {
  final NotificationAPI _notificationAPI;

  NotificationController(NotificationAPI notificationAPI)
      : _notificationAPI = notificationAPI,
        super(false);

  void createNotification({
    required String text,
    required String postId,
    required NotificationType notificationType,
    required String uid,
  }) async {
    final notification = Notification(
      text: text,
      postId: postId,
      id: '',
      uid: uid,
      notificationType: notificationType,
    );
    final res = await _notificationAPI.createNotification(notification);
    res.fold((l) => print(l.message), (r) => null);
  }

  Future<List<Notification>> getNotifications(String uid) async {
    final notification = await _notificationAPI.getNotifications(uid);
    return notification.map((e) => Notification.fromMap(e.data)).toList();
  }
}
