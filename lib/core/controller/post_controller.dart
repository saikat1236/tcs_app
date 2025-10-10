import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../models/job_model.dart';
import '../providers/post_reposidtory.dart';


final jobPostControllerProvider =
    StateNotifierProvider<JobPostController, bool>((ref) {
  final jobPostRepository = ref.watch(jobPostRepositoryProvider);
  return JobPostController(jobPostRepository: jobPostRepository, ref: ref);
});

final jobPostProvider = StreamProvider((ref) {
  final jobPostController = ref.watch(jobPostControllerProvider.notifier);
  return jobPostController.fetchUserJobs();
});

class JobPostController extends StateNotifier<bool> {
  final jobPostRepository _jobPostRepository;
  // ignore: unused_field
  final Ref _ref;
  JobPostController({
    required jobPostRepository jobPostRepository,
    required Ref ref,
  })  : _jobPostRepository = jobPostRepository,
        _ref = ref,
        super(false);

  Stream<List<JobModel>> fetchUserJobs() {
    return _jobPostRepository.fetchUserJobs();
  }
}
