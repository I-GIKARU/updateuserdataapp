import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Dtabase/database.dart';
import '../services/auth.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Authentication _auth = Authentication();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();

  List<Map<String, dynamic>> userProfilesList = [];
  String userID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    User? getUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userID = getUser?.uid ?? "";
    });
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  updateData(String name, String gender, int score, String userID) async {
    await DatabaseManager().updateUserList(name, gender, score, userID);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              openDialogueBox(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              await _auth.signOut().then((result) {
                Navigator.of(context).pop(true);
              });
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: userProfilesList.length,
          itemBuilder: (context, index) {
            var userProfile = userProfilesList[index];
            return Card(
              child: ListTile(
                title: Text(userProfile['name']),
                subtitle: Text(userProfile['gender']),
                leading: CircleAvatar(
                  child: Image.asset('assets/avatarman.png'),
                ),
                trailing: Text('${userProfile['score']}'),
              ),
            );
          },
        ),
      ),
    );
  }

  openDialogueBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User Details'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(hintText: 'Gender'),
                ),
                TextField(
                  controller: _scoreController,
                  decoration: InputDecoration(hintText: 'Score'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                submitAction(context);
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  submitAction(BuildContext context) {
    updateData(
      _nameController.text,
      _genderController.text,
      int.parse(_scoreController.text),
      userID,
    );
    _nameController.clear();
    _genderController.clear();
    _scoreController.clear();
  }
}
