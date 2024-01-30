import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  // initState() {}
  // setState() {
  //   Client client = Client();
  //   try {
  //     client
  //         .setEndpoint('https://cloud.appwrite.io/v1')
  //         .setProject('65b68bdfebca332becd9')
  //         .setSelfSigned(status: true);
  //   } on AppwriteException catch (e) {
  //     print('end ho gya --- > ${e.message} ----');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 100,
        ),
        const Text('main'),
        ElevatedButton(
          onPressed: () {
            setState() {
              print('clicked');
              Client client = Client();
              try {
                client
                    .setEndpoint('https://cloud.appwrite.io/v1')
                    .setProject('65b68bdfebca332becd9')
                    .setSelfSigned(status: true);
                print('run ended');
              } on AppwriteException catch (e) {
                print('end ho gya --- > ${e.message} ----');
              }
            }
          },
          child: const Text('Press'),
        )
      ]),
    );
  }
}
