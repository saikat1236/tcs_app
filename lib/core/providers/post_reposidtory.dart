import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/job_model.dart';
import '../constants/firebase_constants.dart';
import 'firebase_providers.dart';

final jobPostRepositoryProvider = Provider((ref) {
  return jobPostRepository(firestore: ref.watch(firestoreProvider));
});

class jobPostRepository {
  final FirebaseFirestore _firestore;
  jobPostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _jobPost =>
      _firestore.collection(FirebaseConstants.postsCollection);

//   Stream<List<JobModel>> fetchUserJobs() {
//     var jp =
//         _jobPost.orderBy('createdAt', descending: false).get().then((value) {
//       return value.docs.map((e) {
//         debugPrint('err' + e.data().toString());
//         DocumentSnapshot? snapshot = e.data() as DocumentSnapshot<Object?>?;
// Map<String, dynamic> data = snapshot as Map<String, dynamic>;
// var job = JobModel.fromMap(data);

//         // var job = JobModel.fromMap(e.data() as Map<String, dynamic>);
//                 // debugPrint('err job' + job.toString());
//         return job;
//       }).toList();
//     }).asStream();
Stream<List<JobModel>> fetchUserJobs() {
    var jp =
        _jobPost.
        // orderBy('createdAt', descending: false).
        get().then((value) {
      return value.docs.map((e) {
        debugPrint('err' + e.data().toString());
        // Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        // var job = JobModel.fromMap(data);
        // return job;
        return JobModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    }).asStream();

    // .snapshots()
    // .docs()
    // .map((event) => JobModel.fromMap(event as Map<String, dynamic>))
    // .toList()
    /// .asStream();
    // debugPrint(jp.toString());
    return jp;
  }
}
