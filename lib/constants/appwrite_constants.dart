
import 'package:twitter_clone/secrets.dart';

class AppWriteConstants {
  
  static const databaseId = Secrets.databaseId;
  static const projectId = Secrets.projectId;
  static const endPoint = Secrets.endPoint; //emulator ip

  static const imagesBucket = Secrets.imagesBucket;

  static const userCollections = Secrets.userCollections ;
  static const tweetCollections = Secrets.tweetCollections;
  static const notificationsCollection = Secrets.notificationsCollection;

  static String imageUrl(String imageId) {
    return '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
  }

}
