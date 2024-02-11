// class AppWriteConstants {
//   static const databaseId = '65b277f386b1120849f1';
//   static const projectId = '65b270da156bfa05300c';
//   static const endPoint = 'http://10.0.2.2:80/v1'; //emulator ip

//   static const imagesBucket = '65bb905be63a8aed58e7';

//   static const userCollections = '65b7b96f0c694c752402';
//   static const tweetCollections = '65bb2c4dd75bf23bda50';
//   static const notificationsCollection = '65c1abed68611744d4b8';

//   static String imageUrl(String imageId) {
//     return '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
//   }

//   // static const endPoint = 'http://localhost:80/v1'; // works forAPp
// }
class AppWriteConstants {
  
  static const databaseId = '65c61a5ef0172db81a3e';
  static const projectId = '65c6199c37e56265a2f2';
  static const endPoint = 'https://cloud.appwrite.io/v1'; //emulator ip

  static const imagesBucket = '65c61ff213d0b181cb20';

  static const userCollections = '65c61e823366616535a2';
  static const tweetCollections = '65c61b8af25f20bceb95';
  static const notificationsCollection = '65c61a74836de3e8a096';

  static String imageUrl(String imageId) {
    return '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
  }

}
