import 'package:flutter/material.dart';

showLoading(BuildContext context) async {
  await showDialog(
      context: context,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Center(child: CircularProgressIndicator()),
      ));
}
