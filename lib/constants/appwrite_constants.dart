class AppWriteConstants {
  static const databaseId = '65b277f386b1120849f1';
  static const projectId = '65b270da156bfa05300c';
  static const endPoint = 'http://10.0.2.2:80/v1'; //emulator ip

  static const imagesBucket = '65bb905be63a8aed58e7';

  static const userCollections = '65b7b96f0c694c752402';
  static const tweetCollections = '65bb2c4dd75bf23bda50';
  static const notificationsCollection = '65c1abed68611744d4b8';

  static String imageUrl(String imageId) {
    return '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
  }

  // static const endPoint = 'http://localhost:80/v1'; // works forAPp
}

