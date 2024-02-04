import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/theme/pallete.dart';

class ExploreViewPage extends ConsumerStatefulWidget {
  const ExploreViewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExploreViewPageState();
}

class _ExploreViewPageState extends ConsumerState<ExploreViewPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTextFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        color: Pallete.searchBarColor,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.abc),
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10).copyWith(left: 20),
              fillColor: Pallete.searchBarColor,
              filled: true,
              enabledBorder: appBarTextFieldBorder,
              focusedBorder: appBarTextFieldBorder,
              hintText: 'Search Twitter',
            ),
          ),
        ),
      ),
    );
  }
}
