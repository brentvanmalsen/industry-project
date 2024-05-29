import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
// test

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Invite People',
            onPressed: () {
              final String inviteLink = 'https://yourapp.com/invite';
              Share.share('Join our app using this link: $inviteLink');
            },
          ),
        ],
      ),
      body: Center(
        child: const Text('Welcome to Home Page!'),
      ),
    );
  }
}
