import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:urbarn_match_assignment/models/commit_model.dart';
import 'package:urbarn_match_assignment/models/repository_model.dart';

class GitHubApiService {
  final BuildContext context;

  http.Client client = http.Client();

  GitHubApiService(this.context);

  List<RepositoryModel> _repoList = [];
  List<RepositoryModel> get repoList => _repoList;

  List<CommitModel> _commitList = [];
  List<CommitModel> get commitList => _commitList;

  final String reposURL =
      "https://api.github.com/users/AlsoShantanuBorkar/repos";

  final String commitBaseURL =
      "https://api.github.com/users/AlsoShantanuBorkar/repos/";

  final SnackBar errorSnackBar = const SnackBar(
    content: Text("Esrror While Fetching Data"),
  );

  Future getAllRepos() async {
    List data = [];
    try {
      data = await _makeGetRequest(reposURL);
      List<RepositoryModel> rl = [];
      if (data.isNotEmpty) {
        for (var element in data) {
          rl.add(RepositoryModel.fromJson(element));
        }
        _repoList = rl;
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getAllCommits(String commitsUrl) async {
    List data = [];
    String url = commitsUrl.replaceAll(RegExp(r'{/sha}'), '');
    try {
      data = await _makeGetRequest(url);
      List<CommitModel> cl = [];
      if (data.isNotEmpty) {
        for (var element in data) {
          cl.add(CommitModel.fromJson(element));
        }
        _commitList = cl;
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future _makeGetRequest(String urlString) async {
    List data = [];
    try {
      http.Response response = await client.get(
        Uri.parse(
          urlString,
        ),
      );

      if (response.statusCode == 200) {
        List decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as List;

        data = decodedResponse;

        return data;
      }
    } on SocketException catch (_) {
      throw 'Error whilst getting the data: no internet connection.';
    } on HttpException catch (_) {
      throw 'Error whilst getting the data: requested data could not be found.';
    } on FormatException catch (_) {
      throw 'Error whilst getting the data: bad format.';
    } on TimeoutException catch (_) {
      throw 'Error whilst getting the data: connection timed out.';
    } catch (err) {
      throw 'An error occurred whilst fetching the requested data: $err';
    }
  }
}
