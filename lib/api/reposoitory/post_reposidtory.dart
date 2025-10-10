import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/firebase_constants.dart';
import '../../core/providers/firebase_providers.dart';
import '../../models/job_model.dart';


final jobPostRepositoryProvider = Provider((ref) {
  return jobPostRepository(firestore: ref.watch(firestoreProvider));
});

class jobPostRepository {
  final FirebaseFirestore _firestore;
  jobPostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _jobPost =>
      _firestore.collection(FirebaseConstants.postsCollection);

  Stream<List<JobModel>> fetchUserJobs() {
    var jp =
        _jobPost.orderBy('createdAt', descending: false).get().then((value) {
      return value.docs.map((e) {
        debugPrint('err' + e.data().toString());
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
