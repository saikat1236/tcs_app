import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcs_app_fixed/models/job_model.dart';

class CreateJobPostPage extends StatefulWidget {
  @override
  _CreateJobPostPageState createState() => _CreateJobPostPageState();
}

class _CreateJobPostPageState extends State<CreateJobPostPage> {
  bool isLoading = false;

  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController examNameController = TextEditingController();
  final TextEditingController postNameController = TextEditingController();
  final TextEditingController vacancyNumberController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController eligibilityCriteriaController =
      TextEditingController();
  final TextEditingController educationQualificationController =
      TextEditingController();
  final TextEditingController ageLimitController = TextEditingController();
  final TextEditingController selectionProcessController =
      TextEditingController();
  final TextEditingController applicationModeController =
      TextEditingController();
  final TextEditingController applicationDateController =
      TextEditingController();
  final TextEditingController examDateController = TextEditingController();
  final TextEditingController linkNotiController = TextEditingController();
  final TextEditingController linkApplicationController =
      TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController uidController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();
  final TextEditingController isTripuraController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController additionalInfoController =
      TextEditingController();

  List<String> _createSearchData(List<String> fields) {
    return fields
        .expand((field) => field.split(RegExp(r'\s+'))) // Split by whitespace
        .map((word) => word
            .toLowerCase()) // Optional: convert to lowercase for case-insensitive search
        .toSet() // Remove duplicates
        .toList();
  }

  Future<void> _createJobPost() async {
    try {
      // Initialize Firebase if not already initialized
      await Firebase.initializeApp();

      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      List<String> searchData = _createSearchData([
        jobNameController.text,
        organizationController.text,
        examNameController.text,
        postNameController.text,
        categoryController.text,
        eligibilityCriteriaController.text,
        educationQualificationController.text,
        selectionProcessController.text,
        applicationModeController.text,
        applicationDateController.text,
        // examDateController.text,
        stateController.text,
        jobLocationController.text,
        descriptionController.text,
        // You can add more fields here if needed
      ]);

      // Create a new JobModel instance
      final JobModel jobModel = JobModel(
          jobName: jobNameController.text,
          orgainzation: organizationController.text,
          examName: examNameController.text,
          postName: postNameController.text,
          vacancyNumber: int.tryParse(vacancyNumberController.text) ?? 0,
          category: categoryController.text,
          EligibilityCriteria: eligibilityCriteriaController.text,
          EducationQualification: educationQualificationController.text,
          ageLimit: int.tryParse(ageLimitController.text) ?? 0,
          selectionProcess: selectionProcessController.text,
          applicaitonMode: applicationModeController.text,
          applicationDate: applicationDateController.text,
          examDate: examDateController.text,
          linkNoti: linkNotiController.text,
          linkApplication: linkApplicationController.text,
          website: websiteController.text,
          uid: uidController.text,
          createdAt: createdAtController.text,
          isTripura: isTripuraController.text.toLowerCase() == 'true',
          state: stateController.text,
          contactNo: contactNoController.text,
          contactName: contactNameController.text,
          jobLocation: jobLocationController.text,
          additionalInfo: additionalInfoController.text,
          description: descriptionController.text,
          searchData: searchData);
      isLoading = true;

      // Add the job post to Firebase
      await firestore.collection('posts').add(jobModel.toMap()).then((_) {
        // The job post was added successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Job post created successfully!'),
          ),
        );
      }).catchError((error) {
        // Handle any errors that occur during the process
        print('Error creating job post: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating job post. Please try again later.'),
          ),
        );
      });
    } catch (e) {
      // Handle any errors that occur before the Firestore call
      print('Error initializing Firebase: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error initializing Firebase. Please try again later.'),
        ),
      );
    } finally {
      // Set loading flag to false, whether the operation succeeded or not
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Job Post',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 14, 19, 100),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: jobNameController,
              decoration: InputDecoration(labelText: 'Job Name'),
            ),
            TextFormField(
              controller: organizationController,
              decoration: InputDecoration(labelText: 'Organization'),
            ),
            TextFormField(
              controller: examNameController,
              decoration: InputDecoration(labelText: 'Exam Name'),
            ),
            TextFormField(
              controller: postNameController,
              decoration: InputDecoration(labelText: 'Post Name'),
            ),
            TextFormField(
              controller: vacancyNumberController,
              decoration: InputDecoration(labelText: 'Vacancy Number'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: eligibilityCriteriaController,
              decoration: InputDecoration(labelText: 'Eligibility Criteria'),
            ),
            TextFormField(
              controller: educationQualificationController,
              decoration: InputDecoration(labelText: 'Education Qualification'),
            ),
            TextFormField(
              controller: ageLimitController,
              decoration: InputDecoration(labelText: 'Age Limit'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: selectionProcessController,
              decoration: InputDecoration(labelText: 'Selection Process'),
            ),
            TextFormField(
              controller: applicationModeController,
              decoration: InputDecoration(labelText: 'Application Mode'),
            ),
            TextFormField(
              controller: applicationDateController,
              decoration: InputDecoration(labelText: 'Application Date'),
            ),
            TextFormField(
              controller: examDateController,
              decoration: InputDecoration(labelText: 'Exam Date'),
            ),
            TextFormField(
              controller: linkNotiController,
              decoration: InputDecoration(labelText: 'Link to Notification'),
            ),
            TextFormField(
              controller: linkApplicationController,
              decoration:
                  InputDecoration(labelText: 'Link to Application Form'),
            ),
            TextFormField(
              controller: websiteController,
              decoration: InputDecoration(labelText: 'Website'),
            ),
            TextFormField(
              controller: uidController,
              decoration: InputDecoration(labelText: 'UID'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: createdAtController,
              decoration: InputDecoration(labelText: 'Created At'),
            ),
            TextFormField(
              controller: isTripuraController,
              decoration: InputDecoration(labelText: 'Is Tripura'),
            ),
            TextFormField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            TextFormField(
              controller: contactNoController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextFormField(
              controller: contactNameController,
              decoration: InputDecoration(labelText: 'Contact Name'),
            ),
            TextFormField(
              controller: jobLocationController,
              decoration: InputDecoration(labelText: 'Job Location'),
            ),
            TextFormField(
              controller: additionalInfoController,
              decoration: InputDecoration(labelText: 'Additional Info'),
            ),
            ElevatedButton(
              onPressed: _createJobPost,
              child: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(), // You can customize the loading indicator here
                    )
                  : Text('Create Job Post'),
            ),
          ],
        ),
      ),
    );
  }
}
