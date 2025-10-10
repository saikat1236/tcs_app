import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/job_model.dart';
import '../constants/firebase_constants.dart';
import 'firebase_providers.dart';
final jobSearchRepositoryProvider = Provider((ref) {
  return JobSearchRepositories(firestore: ref.watch(firestoreProvider));
});
class JobSearchRepositories {
  final FirebaseFirestore _firestore;
  JobSearchRepositories({required FirebaseFirestore firestore})
      : _firestore = firestore;

List<String> getSubstrings(String text) {
 List<String> substrings = [];
 for (int i = 0; i < text.length - 2; i++) {
    substrings.add(text.substring(i, i + 3));
 }
 return substrings;
}

  Stream<List<JobModel>> searchQuery(Map query) {

    print('query0:'+query.toString());
    print('query1:'+query.keys.first.toString());
    print('query2:'+query.values.toString());

    // if(query.keys.first=='state'){
    //   debugPrint(query.toString());
    //   return _jobs
    //     .where( 'state',isGreaterThanOrEqualTo: query.values.first.toString().toLowerCase().trim())
    //     // .where('jobLocation', isGreaterThanOrEqualTo: query.values.first)
    //     // .orderBy('createdAt', descending: false)
    //     .get()
    //     .then((value) => value.docs.map((event) {
    //           return JobModel.fromMap(event.data() as Map<String, dynamic>);
    //         }).toList()).asStream();
    // }
if (query.keys.first == 'state') {
  if(query.values.first.toString() == 'other'){
    return _jobs
    .where('state', isNotEqualTo: 'tripura')
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
        .map((document) => JobModel.fromMap(document.data() as Map<String, dynamic>))
        .toList());
  }
  return _jobs
    .where('state', isEqualTo: query.values.first.toString().toLowerCase().trim())
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
        .map((document) => JobModel.fromMap(document.data() as Map<String, dynamic>))
        .toList());
}

    // if(query.keys.first=='age'){
    //   debugPrint(query.values.first.toString());
    //   return _jobs
    //     .where('ageLimit',isEqualTo: query.values.first.toString().trim())
    //     // .where('jobLocation', isGreaterThanOrEqualTo: query.values.first)
    //     // .orderBy('createdAt', descending: false)
    //     .get()
    //     .then((value) => value.docs.map((event) {
    //           debugPrint(value.docs.toString());
    //           return JobModel.fromMap(event.data() as Map<String, dynamic>);
    //         }).toList()).asStream();
    // }

    if (query.keys.first == 'age') {
  return _jobs
    .where('ageLimit', isEqualTo: int.parse(query.values.first.toString().trim()))
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
        .map((document) => JobModel.fromMap(document.data() as Map<String, dynamic>))
        .toList());
}


    if(query.keys.first=='category'){
      debugPrint(query.toString());
      return _jobs
        .where( 'category',isLessThan: query.values.first.toString().trim() + '\uf8ff')
        .where('category', isGreaterThanOrEqualTo: query.values.first.toString().trim())
        // .orderBy('createdAt', descending: false)
        .get()
        .then((value) => value.docs.map((event) {
              return JobModel.fromMap(event.data() as Map<String, dynamic>);
            }).toList()).asStream();
    }

    if (query.keys.first == 'education') {
  return _jobs
    .where('EducationQualification', isEqualTo: query.values.first.toString().trim())
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
        .map((document) => JobModel.fromMap(document.data() as Map<String, dynamic>))
        .toList());
}

  //   return _jobs
  //       .where( 'description',isGreaterThanOrEqualTo: query.values.first.toString().trim())
  //       // .where('examName', isEqualTo: query)
  //       // .orderBy('createdAt', descending: false)
  //       .get()
  //       .then((value) => value.docs.map((event) {
  //             return JobModel.fromMap(event.data() as Map<String, dynamic>);
  //           }).toList()).asStream();
  // }
 return _jobs
//  .where('searchData', arrayContainsAny: getSubstrings(query.values.first.toString().trim()))
        .where( 'description',isGreaterThanOrEqualTo: query.values.first.toString().trim())
 .where('description', isLessThan: query.values.first.toString().trim() + '\uf8ff')
 .snapshots()
 .map((querySnapshot) => querySnapshot.docs
      .map((document) => JobModel.fromMap(document.data() as Map<String, dynamic>))
      .toList());


  //  return _jobs
  //   .where((job) {
  //     String description = job['description'] ?? '';
  //     String jobName = job['jobName'] ?? '';
  //     String examName = job['examName'] ?? '';
  //     String postName = job['postName'] ?? '';
  //     String organization = job['orgainzation'] ?? '';
  //     String category = job['category'] ?? '';
  //     String eligibilityCriteria = job['EligibilityCriteria'] ?? '';
  //     String selectionProcess = job['selectionProcess'] ?? '';
  //     String applicationMode = job['applicaitonMode'] ?? '';
  //     String applicationDate = job['applicationDate'] ?? '';
  //     String examDate = job['examDate'] ?? '';
  //     String linkNoti = job['linkNoti'] ?? '';
  //     String linkApplication = job['linkApplication'] ?? '';

  //     String queryValue = query.values.first.toString().trim();
      
  //     return (description.isNotEmpty && description.compareTo(queryValue) >= 0 && description.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (jobName.isNotEmpty && jobName.compareTo(queryValue) >= 0 && jobName.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (examName.isNotEmpty && examName.compareTo(queryValue) >= 0 && examName.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (postName.isNotEmpty && postName.compareTo(queryValue) >= 0 && postName.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (organization.isNotEmpty && organization.compareTo(queryValue) >= 0 && organization.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (category.isNotEmpty && category.compareTo(queryValue) >= 0 && category.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (eligibilityCriteria.isNotEmpty && eligibilityCriteria.compareTo(queryValue) >= 0 && eligibilityCriteria.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (selectionProcess.isNotEmpty && selectionProcess.compareTo(queryValue) >= 0 && selectionProcess.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (applicationMode.isNotEmpty && applicationMode.compareTo(queryValue) >= 0 && applicationMode.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (applicationDate.isNotEmpty && applicationDate.compareTo(queryValue) >= 0 && applicationDate.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (examDate.isNotEmpty && examDate.compareTo(queryValue) >= 0 && examDate.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (linkNoti.isNotEmpty && linkNoti.compareTo(queryValue) >= 0 && linkNoti.compareTo(queryValue + '\uf8ff') < 0) ||
  //         (linkApplication.isNotEmpty && linkApplication.compareTo(queryValue) >= 0 && linkApplication.compareTo(queryValue + '\uf8ff') < 0);
  //   })
  //   .snapshots()
  //   .map((querySnapshot) => querySnapshot.docs
  //       .map((document) => JobModel.fromMap(document.data() as Map<String, dynamic>))
  //       .toList());

  }
  
  CollectionReference get _jobs =>
      _firestore.collection(FirebaseConstants.postsCollection);
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../models/job_model.dart';
// import '../constants/firebase_constants.dart';
// import 'firebase_providers.dart';

// final jobSearchRepositoryProvider = Provider((ref) {
//   return JobSearchRepositories(firestore: ref.watch(firestoreProvider));
// });

// class JobSearchRepositories {
//   final FirebaseFirestore _firestore;

//   JobSearchRepositories({required FirebaseFirestore firestore})
//       : _firestore = firestore;

//   Future<List<JobModel>> fetchJobs(QuerySnapshot querySnapshot) async {
//     List<JobModel> jobs = [];

//     for (QueryDocumentSnapshot document in querySnapshot.docs) {
//       JobModel job =
//           JobModel.fromMap(document.data() as Map<String, dynamic>);
//       jobs.add(job);
//     }

//     return jobs;
//   }
// Future<List<JobModel>> fetchJobsByField(
//     String field, String queryValue) async {
//   // Print the field and query value being used for the query
//   debugPrint('Fetching jobs for field: $field, query value: $queryValue');

//   QuerySnapshot querySnapshot = await _firestore
//       .collection('jobs')
//       .where(field, isGreaterThanOrEqualTo: queryValue)
//       // .where(field, isLessThan: queryValue + '\uf8ff')
//       .get();

//   // Print the number of documents fetched
//   debugPrint('Fetched ${querySnapshot.docs.length} documents');

//   // Print the data of each document
//   querySnapshot.docs.forEach((doc) {
//     debugPrint(doc.data().toString());
//   });

//   // Return the list of jobs fetched
//   return fetchJobs(querySnapshot);
// }


//   Future<List<JobModel>> fetchJobsByQuery(String queryValue) async {
//   List<JobModel> jobs = [];

//   List<String> fieldsToQuery = [
//     'description',
//     'jobName',
//     // 'examName',
//     // 'postName',
//     // 'orgainzation',
//     // 'category',
//     // 'EligibilityCriteria',
//     // 'selectionProcess',
//     // 'applicaitonMode'
//   ];

//   for (String field in fieldsToQuery) {
//     // Print the field being queried
//     debugPrint('Querying field: $field');

//     List<JobModel> fieldJobs = await fetchJobsByField(field, queryValue);
//     jobs.addAll(fieldJobs);

//     // Print the number of jobs fetched for the current field
//     debugPrint('Fetched ${fieldJobs.length} jobs for field $field');
//   }

//   // Print the total number of jobs fetched
//   debugPrint('Total jobs fetched: ${jobs.length}');

//   // Print the list of jobs
//   debugPrint('Jobs: $jobs');

//   return jobs;
// }


//   Stream<List<JobModel>> searchQuery(Map query) {
//     if (query.keys.first == 'state') {
//       return _firestore
//           .collection('jobs')
//           .where('state',
//               isEqualTo: query.values.first.toString().toLowerCase().trim())
//           .snapshots()
//           .map((querySnapshot) => querySnapshot.docs
//               .map((document) =>
//                   JobModel.fromMap(document.data() as Map<String, dynamic>))
//               .toList());
//     }

//     if (query.keys.first == 'age') {
//       return _firestore
//           .collection('jobs')
//           .where('ageLimit',
//               isEqualTo: int.parse(query.values.first.toString().trim()))
//           .snapshots()
//           .map((querySnapshot) => querySnapshot.docs
//               .map((document) =>
//                   JobModel.fromMap(document.data() as Map<String, dynamic>))
//               .toList());
//     }

//     if (query.keys.first == 'education') {
//       return _firestore
//           .collection('jobs')
//           .where('EducationQualification',
//               isEqualTo: query.values.first.toString().trim())
//           .snapshots()
//           .map((querySnapshot) => querySnapshot.docs
//               .map((document) =>
//                   JobModel.fromMap(document.data() as Map<String, dynamic>))
//               .toList());
//     }

//     // Default to searching by description
//         return Stream.fromFuture(fetchJobsByQuery(query.values.first.toString().trim()));

//     // return _firestore
//     //     .collection('jobs')
//     //     .where('description',
//     //         isGreaterThanOrEqualTo: query.values.first.toString().trim())
//     //     .where('description',
//     //         isLessThan: query.values.first.toString().trim() + '\uf8ff')
//     //     .snapshots()
//     //     .map((querySnapshot) => querySnapshot.docs
//     //         .map((document) =>
//     //             JobModel.fromMap(document.data() as Map<String, dynamic>))
//     //         .toList());
//   }
// }
