import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

TextStyle mainStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
  color: Color(0xff175432),
);
TextStyle secStyle = TextStyle(fontSize: 13, color: Colors.black);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final groupProvider = Provider.of<GroupProvider>(context);

    userProvider.fetchUserById();
    groupProvider.fetchGroupsFromUserId(userProvider.user?.id);

    final user = userProvider.user;
    final groups = groupProvider.userGroups;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  height: 250,
                  image: AssetImage('assets/profilepin.png'),
                ),
              ),
              const SizedBox(height: 20),
              Text("Name", style: mainStyle),
              Text(
                user?.username ?? 'No username available',
                style: secStyle,
              ), // User's name
              const SizedBox(height: 20),
              Text("Email address", style: mainStyle),
              Text(
                user?.email ?? 'No username available',
                style: secStyle,
              ), // User's email
              const SizedBox(height: 20),
              Text("My groups", style: mainStyle),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    groups.isNotEmpty
                        ? groups.map((group) {
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(group.groupName, style: secStyle),
                          );
                        }).toList()
                        : [Text("No groups joined yet", style: secStyle)],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-groups');
                  },
                  child: Text("Edit Groups"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
