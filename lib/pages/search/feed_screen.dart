import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/error_text.dart';
import '../../core/common/loader.dart';
import '../../core/controller/post_controller.dart';
import '../../models/job_model.dart';
// import '../../theme/pallete.dart';
import '../jobpost_page.dart';

class FeedScreen extends ConsumerWidget {
  static const String routeName = '/feeds';
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(jobPostProvider).when(
          data: (data) {
            debugPrint('err comming' + data.toString());
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final jobPost = data[index];
                return JobPostCard(
                    jobPost: jobPost, ref: ref, context: context);
              },
            );
          },
          error: (error, stackTrace) {
            return ErrorText(
              error: error.toString(),
            );
          },
          loading: () => const Loader(),
        );
  }
}

Widget JobPostCard(
    {required JobModel jobPost,
    required WidgetRef ref,
    required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: Card(
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              jobPost.orgainzation,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(),
            Text(
              'Post Background: ' + jobPost.jobName,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'Eligibility: ' + (jobPost.EligibilityCriteria ?? 'N/A'),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Text(
              'Date for online application: ' +
                  (jobPost.applicationDate ?? 'N/A'),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            Text(
              'Examination Date: ' + (jobPost.examDate ?? 'N/A'),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            Text(
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              'Post Description: ' + jobPost.description,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () => navigateToPostdetails(context, jobPost),
              child: Text(
                'Learn More',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}

navigateToPostdetails(BuildContext context, JobModel jobPost) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => JobPostPage(
                jobPost: jobPost,
              )));
}

class Responsive extends StatelessWidget {
  final Widget child;
  const Responsive({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
          // minWidth: 100
        ),
        child: child,
      ),
    );
  }
}
