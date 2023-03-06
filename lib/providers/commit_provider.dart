import 'package:flutter/material.dart';
import 'package:urbarn_match_assignment/models/commit_model.dart';
import 'package:urbarn_match_assignment/services/github_api_service.dart';

class CommitProvider extends ChangeNotifier {
  late GitHubApiService _gitHubApiServiceInstance;
  CommitProvider(GitHubApiService gitHubApiServiceInstance) {
    _gitHubApiServiceInstance = gitHubApiServiceInstance;
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<CommitModel> _commitList = [];
  List<CommitModel> get commitList => _commitList;

  Future<void> getAllCommits(String commitsUrl) async {
    _isLoading = true;
    notifyListeners();
    await _gitHubApiServiceInstance.getAllCommits(commitsUrl).then((value) {
      _commitList = _gitHubApiServiceInstance.commitList;

      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }
}
