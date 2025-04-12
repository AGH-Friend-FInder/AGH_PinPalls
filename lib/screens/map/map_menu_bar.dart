import 'package:flutter/material.dart';

class MapMenuBar extends StatelessWidget {
  const MapMenuBar({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            // const ListTile(leading: Icon(Icons.event), title: Text('Wydarzenia')),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Groups'),
              onTap: () {
                Navigator.pushNamed(context, '/groups');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                //TODO: add token reset
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      body: child,
    );
  }
}
