import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbarn_match_assignment/models/commit_model.dart';
import 'package:urbarn_match_assignment/providers/commit_provider.dart';

class CommitDataDialog extends StatelessWidget {
  const CommitDataDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CommitProvider>(builder: (context, value, child) {
      return Dialog(
          child: value.isLoading
              ? Container(
                  padding: const EdgeInsets.all(8),
                  height: 200,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "SHA : ${value.commitList[0].sha!}",
                      ),
                      Text(
                        "Author : ${value.commitList[0].commit!.author!.name!}",
                      ),
                      Text(
                        "Date : ${value.commitList[0].commit!.author!.date!}",
                      ),
                    ],
                  ),
                ));
    });
  }
}
