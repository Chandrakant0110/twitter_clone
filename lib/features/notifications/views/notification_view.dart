import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/notifications/controller/notification_controller.dart';
import 'package:twitter_clone/features/notifications/widgets/notification_tile.dart';
import 'package:twitter_clone/models/notification_model.dart' as model;

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
        ),
      ),
      body: currUser == null
          ? const Loader()
          : ref.watch(getNotificationsProvider(currUser.uid)).when(
                data: (notifications) {
                  return ref.watch(getLatestNotificationProvider).when(
                        data: (data) {
                          if (data.events.contains(
                              'databases.*.collections.${AppWriteConstants.notificationsCollection}.documents.*.create')) {
                            final latestNotification =
                                model.Notification.fromMap(data.payload);

                            if (latestNotification.uid == currUser.uid) {
                              // condition is above
                              notifications.insert(0, latestNotification);
                            }
                          }

                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final notifcation = notifications[index];
                              return NotificationTile(
                                notification: notifcation,
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () {
                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final notifcation = notifications[index];
                              return NotificationTile(
                                notification: notifcation,
                              );
                            },
                          );
                        },
                      );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
    );
  }
}
