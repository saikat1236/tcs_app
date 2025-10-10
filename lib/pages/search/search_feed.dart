import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcs_app_fixed/core/controller/search_controller.dart';

import '../../core/common/error_text.dart';
import '../../core/common/loader.dart';
import 'feed_screen.dart';

class SearchFeed extends ConsumerStatefulWidget {
  final Map query;
  const SearchFeed({required this.query, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  // TODO: implement build
  // throw UnimplementedError();
  // }
}

class _SearchPageState extends ConsumerState<SearchFeed> {
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
    //   appBar: AppBar(
    //     backgroundColor: Color.fromARGB(255, 255, 255, 255),
    //     elevation: 1,

    //   ),
    //   drawer: const ProfileDrawer(),

    //   body: Column(
    //     children: [
    //       Text(widget.query, style: TextStyle(color: Colors.black),),

    //       Expanded(child: FeedScreen())
    //     ],
    //   ),
    // );
    return ref.watch(jobSearchProvider(widget.query)).when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: currentTheme.canvasColor,
                    color: Color.fromARGB(236, 253, 253, 253),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(5, 10),
                    //     blurRadius: 15,
                    //     color: currentTheme.backgroundColor,
                    //   )
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align children to the top
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.info_outline,
                          color: Color.fromRGBO(232, 26, 26, 1)),
                          // Spacer(),
                      Expanded(
                        // Wrap the Text widget with Expanded
                        child: Text(
                          "Sorry, no posts available right now in the category you're looking for. Please check again later.",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final jobPost = data[index];
                // debugPrint(jobPost.toString());
                // return Container(
                // child: Text('list of latest jobs: ' + jobPost.toString()),
                // );
                // if (jobPost.isEmpty) return const SizedBox();
                return JobPostCard(
                    jobPost: jobPost, ref: ref, context: context);
              },
            );
          },
          error: (error, stackTrace) {
            return SizedBox(
              height: 300,
              child: ErrorText(
                error: error.toString(),
              ),
            );
          },
          loading: () => const Loader(),
        );
  }
}
