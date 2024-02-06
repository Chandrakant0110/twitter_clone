import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/notification_model.dart';

abstract class INotificationAPI {
  FutureEitherVoid createNotification(Notification notification);
}

class NotificationAPI extends INotificationAPI {
  final Databases _db;

  NotificationAPI({required Databases databases}) : _db = databases;

  @override
  FutureEitherVoid createNotification(Notification notification) async {
    try {
      await _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.notificationsCollection,
        documentId: ID.unique(),
        data: notification.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
