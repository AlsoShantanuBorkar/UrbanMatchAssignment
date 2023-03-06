import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbarn_match_assignment/providers/commit_provider.dart';
import 'package:urbarn_match_assignment/providers/repository_provider.dart';
import 'package:urbarn_match_assignment/services/github_api_service.dart';
import 'package:urbarn_match_assignment/widgets/repo_list_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GitHubApiService gitHubApiServiceInstance = GitHubApiService(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RepositoryProvider(gitHubApiServiceInstance),
        ),
        ChangeNotifierProvider(
          create: (context) => CommitProvider(gitHubApiServiceInstance),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'GitHub Commit Fetcher'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RepositoryProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.repositoryList.isEmpty
                  ? const Center(
                      child: Text("Load data from GitHub"),
                    )
                  : ListView.builder(
                      itemCount: value.repositoryList.length,
                      itemBuilder: ((context, index) {
                        log(value.repositoryList.length);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RepoListTile(
                            repositoryModel: value.repositoryList[index],
                          ),
                        );
                      }),
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              value.getAllRepositories();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
