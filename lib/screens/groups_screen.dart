import 'package:agh_pin_palls/models/group.dart';
import 'package:agh_pin_palls/provider.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final GroupProvider groupProvider = GroupProvider();
  List<Group> _selectedGroups = [];

  @override
  void initState() {
    super.initState();
    groupProvider.fetchPublicGroups();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Column(
                children: [
                  Image(
                    height: 150,
                    image: AssetImage('assets/PinPals_nb.png'),
                  ),
                  Text("Group panel"),
                ],
              ),

              Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      DropdownSearch<Group>.multiSelection(
                        items: groupProvider.getPublicGroups,
                        itemAsString: (i) => i.groupName,
                        compareFn: (i, s) => i.id == s.id,
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            labelText: "Your groups:",
                            hintText: "Add groups you'd like to follow",
                          ),
                        ),
                        popupProps: PopupPropsMultiSelection.menu(
                          showSearchBox: true,
                        ),
                        onChanged: (groups) {
                          setState(() {
                            _selectedGroups = groups;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                groupProvider.updateUserGroups(
                                  _selectedGroups,
                                  user?.id,
                                );
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: Text("Join groups"),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/groups/create');
                              },
                              child: Text("Create your group"),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
