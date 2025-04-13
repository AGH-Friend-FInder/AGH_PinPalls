import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

List<String> people = ["John Doe"];

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameGroupController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Group')),
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
                  Text("Create your group"),
                ],
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameGroupController,
                        decoration: InputDecoration(
                          labelText: "Group Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child:
                                _isLoading
                                    ? const CircularProgressIndicator() // Show loading spinner
                                    : ElevatedButton(
                                      onPressed: () {
                                        _registerGroup();
                                        Navigator.pushNamed(context, '/groups');
                                      },
                                      child: Text("Create Group"),
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

  Future<void> _registerGroup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Hash the password before sending it
    if (mounted) {
      UserProvider userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      debugPrint(userProvider.user.toString());

      Map<String, dynamic> groupData = {
        'groupName': _nameGroupController.text,
        'isPublic': true,
        'color': "255.255.255",
        'userId': userProvider.user?.id,
      };

      try {
        await Provider.of<GroupProvider>(
          context,
          listen: false,
        ).createGroup(groupData);

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/groups');
        }
      } catch (e) {
        if (mounted) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text('$e'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }
}
