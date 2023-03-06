import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbarn_match_assignment/models/repository_model.dart';
import 'package:urbarn_match_assignment/providers/commit_provider.dart';
import 'package:urbarn_match_assignment/widgets/commit_data_dialog.dart';

class RepoListTile extends StatelessWidget {
  const RepoListTile({super.key, required this.repositoryModel});
  final RepositoryModel repositoryModel;

  @override
  Widget build(BuildContext context) {
    final CommitProvider commitProvider = Provider.of<CommitProvider>(context);
    return ListTile(
      shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8)),
      title: Text(
        repositoryModel.name!,
      ),
      onTap: () async {
         commitProvider.getAllCommits(repositoryModel.commitsUrl!);
        showDialog(
            context: context, builder: (context) => const CommitDataDialog());
      },
    );
  }
}
