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
  // static const endPoint = 'http://192.168.22.189:80/v1'; // --->works in webApp
}

class AppWriteConstantsOnline {
  static const databaseId = '65b6a5f0cfa707300eb8'; 
  static const projectId = '65b68bdfebca332becd9';
  static const endPoint = 'https://cloud.appwrite.io/v1';
  // static const endPoint = 'http://192.168.22.189:80/v1';
  // static const endPoint = 'ws://127.0.0.1:59814/F4OXFJNgaG4=/ws';
}
