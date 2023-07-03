import 'package:committee/helper/helper_function.dart';
import 'package:committee/pages/auth/login_page.dart';
import 'package:committee/pages/profile_page.dart';
import 'package:committee/pages/search_page.dart';
import 'package:committee/service/auth_service.dart';
import 'package:committee/service/database_service.dart';
import 'package:committee/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
void initializeFirebase() async {
  await Firebase.initializeApp();
}

void sendDataToFirebase(String name,String amount, String duration,String members) {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.child('committees').push().set({
    'name': name,
    'amount': amount,
    'duration': duration,
    'member': members,
    
  });
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final ref = FirebaseDatabase.instance.ref("committees");
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  String amount = "";
   String duration = "";
   String name = "";
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const SearchPage());
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Committies",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey[700],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {},
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group),
            title: const Text(
              "Committies",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreenReplace(
                  context,
                  ProfilePage(
                    userName: userName,
                    email: email,
                  ));
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group),
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await authService.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  });
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      )),
      body:Column(
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0), // Set the desired padding values
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            String name = snapshot.child('name').value.toString();
            String amount = snapshot.child('amount').value.toString();
            String duration = snapshot.child('duration').value.toString();
            String member = snapshot.child('member').value.toString();

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(name),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Amount: $amount'),
                          Text('Duration: $duration'),
                          Text('Member: $member'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                color: Color.fromARGB(255, 121, 120, 122), // Set the desired background color
                child: ListTile(
                  title: Text(
                    name,
                    style: TextStyle(fontSize: 33),
                  ),
                  subtitle: Text(
                    amount,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  ],
)



,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         showDialog(
  context: context,
  builder: (BuildContext context) {
    String name = '';
    String amount = '';
    String duration = '';
    String members = '';
    return AlertDialog(
      title: Text('Create Committee'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
                    TextField(
            decoration: InputDecoration(labelText: 'Set Name'),
            onChanged: (value) {
              name = value;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Set Amount'),
            onChanged: (value) {
              amount = value;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Set Duration'),
            onChanged: (value) {
              duration = value;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Add Members'),
            onChanged: (value) {
              members = value;
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text('Create'),
          onPressed: () {
            // Send the entered values to Firebase
            sendDataToFirebase(name,amount, duration,members);

            // Close the dialog
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);

        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

 
}
