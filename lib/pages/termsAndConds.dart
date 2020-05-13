import 'package:flutter/material.dart';
import 'package:liceucubrio/util/ui_components.dart';

class TermsAndConds extends StatelessWidget {
  String title = 'Termeni si conditii';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar(context, title, '/home'),
      body: Container(
        child: Text('Termeni si conditii'),
      ),
    );
  }
}
