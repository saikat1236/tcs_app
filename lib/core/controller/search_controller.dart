// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../models/job_model.dart';
// import '../providers/post_reposidtory.dart';
import '../providers/search_repository.dart';


final jobSearchControllerProvider =
    StateNotifierProvider<JobSearchController, bool>((ref) {
  final jobSearchRepository = ref.watch(jobSearchRepositoryProvider);
  return JobSearchController(jobSearchRepository: jobSearchRepository, ref: ref);
});

final jobSearchProvider = StreamProvider.family((ref, Map query
) {
  final jobSearchController = ref.watch(jobSearchControllerProvider.notifier);
  return jobSearchController.searchQuery(query);
});

class JobSearchController extends StateNotifier<bool> {
  final JobSearchRepositories _jobSearchRepository;
  // ignore: unused_field
  final Ref _ref;
  JobSearchController({
    required JobSearchRepositories jobSearchRepository,
    required Ref ref,
  })  : _jobSearchRepository = jobSearchRepository,
        _ref = ref,
        super(false);

  Stream<List<JobModel>> searchQuery(Map query) {
    return _jobSearchRepository.searchQuery( query);
  }
}
