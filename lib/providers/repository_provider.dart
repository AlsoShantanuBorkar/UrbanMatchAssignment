import 'package:flutter/material.dart';
import 'package:urbarn_match_assignment/models/repository_model.dart';
import 'package:urbarn_match_assignment/services/github_api_service.dart';

class RepositoryProvider extends ChangeNotifier {
  late GitHubApiService _gitHubApiServiceInstance;
  RepositoryProvider(GitHubApiService gitHubApiServiceInstance) {
    _gitHubApiServiceInstance = gitHubApiServiceInstance;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<RepositoryModel> _repositoryList = [];
  List<RepositoryModel> get repositoryList => _repositoryList;

  void getAllRepositories() async {
    _isLoading = true;
    notifyListeners();
    await _gitHubApiServiceInstance.getAllRepos().then((value) {
      _repositoryList = _gitHubApiServiceInstance.repoList;

      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }
}
