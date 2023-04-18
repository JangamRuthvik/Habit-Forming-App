// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = "Aravind";
    _emailController.text = "aravind@example.com";
    _addressController.text = "123 Main Street, Anytown USA";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 50, 15, 20),
        children: [
          CircleAvatar(
            radius: 150,
            backgroundColor: Colors.purpleAccent,
            backgroundImage: NetworkImage(
                'https://t4.ftcdn.net/jpg/04/83/90/95/360_F_483909569_OI4LKNeFgHwvvVju60fejLd9gj43dIcd.jpg'),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: const Center(
                child: Text(
              "Hey Aravind !",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )),
          ),
          Center(
              child: Text(
            "What a wonderful day!!",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          )),
          Padding(
            padding: EdgeInsets.all(10),
            child: Divider(),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("My Account Info"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("My Subscription Info"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("All of my habits"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About This App"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Save changes to profile here
                    });
                  },
                  child: Text("Save Changes"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: (() {
                print("User logged out");
              }),
              child: Text(
                "Log Out",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
