import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/job_model.dart';
// import '../theme/pallete.dart';

class JobPostPage extends ConsumerWidget {
  final JobModel jobPost;
  const JobPostPage({super.key, required this.jobPost});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 253, 255),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 10),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            var url = jobPost.website;
            if (url != null &&
                await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                )) {
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Center(
            child: Text(
              "Apply",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
        elevation: 1,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              jobPost.orgainzation,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text(
              'Post Background: ' + jobPost.jobName,
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              'Post Description: ' + jobPost.description,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(height: 4),

            if (jobPost.postName != null)
              Text(
                'Post Title: ' + jobPost.postName!,
                style: TextStyle(
                  color: Colors.black,
                  height: 2,
                  fontSize: 18,
                ),
              ),
            if (jobPost.vacancyNumber != null)
              Text(
                'Number of vacancy: ' + jobPost.vacancyNumber!.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 2,
                ),
              ),
            if (jobPost.category != null)
              Text(
                'Job Type: ' + jobPost.category!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 2,
                ),
              ),
            Divider(
              height: 32,
            ),
            if (jobPost.EligibilityCriteria != null)
              Text(
                '⬤ Eligibility Criteria: ' + jobPost.EligibilityCriteria!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            if (jobPost.EducationQualification != null)
              Text(
                '⬤ Educational Qualiication: ' +
                    jobPost.EducationQualification!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            Text(
              '⬤ Age limit: ' + jobPost.ageLimit.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 1.5,
              ),
            ),
            if (jobPost.selectionProcess != null)
              Text(
                '⬤ Selection process: ' + jobPost.selectionProcess!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.8,
                ),
              ),
            Divider(
              height: 32,
            ),
            if (jobPost.applicaitonMode != null)
              Text(
                '⬤ Application Mode: ' + jobPost.applicaitonMode!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            if (jobPost.applicationDate != null)
              Text(
                '⬤ Date for online application: ' + jobPost.applicationDate!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            if (jobPost.examDate != null)
              Text(
                '⬤ Examination Date: ' + jobPost.examDate!,
                style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
            // if (jobPost.createdAt != null)
            Text(
              '⬤ Post Date: ' + jobPost.createdAt,
              style: TextStyle(
                color: Colors.black,
                height: 1.5,
                fontSize: 18,
              ),
            ),
            // SizedBox(height: 20,),
            Divider(
              height: 32,
            ),
            // Spacer(),
            Text(
              '⬤ State: ' + jobPost.state,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 1.5,
              ),
            ),
            Text(
              '⬤ Job Location: ' + jobPost.jobLocation,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 1.5,
              ),
            ),
            if (jobPost.contactName != null)
              Text(
                '⬤ Contact Name: ' + jobPost.contactName!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            if (jobPost.contactNo != null)
              Text(
                '⬤ Contact Number: ' + jobPost.contactNo!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            Divider(
              height: 32,
            ),
            // Spacer(),
            Text(
              '⬤ Additional Info: ${jobPost.additionalInfo}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
