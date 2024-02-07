import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define your Appwrite constants
class AppWriteConstants {
  static const endPoint = 'Your Appwrite Endpoint';
  static const projectId = 'Your Appwrite Project ID';
}

// Provider for Appwrite Client
final appwriteClientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: false);
});

// Provider for Appwrite Account
final appwriteAccountProvider = Provider<Account>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

// Provider for checking if user is logged in
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final account = ref.watch(appwriteAccountProvider);
  try {
    await account.get();
    return true;
  } catch (e) {
    return false;
  }
});

// In your widget, you can use the isLoggedInProvider to check if the user is logged in
class YourWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedInAsyncValue = ref.watch(isLoggedInProvider);
    return isLoggedInAsyncValue.when(
      data: (isLoggedIn) {
        if (isLoggedIn) {
          return Container(); // Return your main app if the user is logged in
        } else {
          return Container(); // Return your login page if the user is not logged in
        }
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('An error occurred: $error'),
    );
  }
}
