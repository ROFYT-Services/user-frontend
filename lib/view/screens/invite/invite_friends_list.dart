import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';

class InviteFriendsList extends StatefulWidget {
  const InviteFriendsList({super.key});

  @override
  State<InviteFriendsList> createState() => _InviteFriendsListState();
}

class _InviteFriendsListState extends State<InviteFriendsList> {
  final List<Map<String, String>> users = [
    {
      'name': 'Sandip',
      'imageUrl': 'assets/icons/users/user1.png',
      'icon': 'assets/icons/users/check-white.png'
    },
    {
      'name': 'SOuvik',
      'imageUrl': 'assets/icons/users/user2.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'Bhim',
      'imageUrl': 'assets/icons/users/user3.png',
      'icon': 'assets/icons/users/check-white.png'
    },
    {
      'name': 'raj',
      'imageUrl': 'assets/icons/users/user4.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'alok',
      'imageUrl': 'assets/icons/users/user5.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'Sandip',
      'imageUrl': 'assets/icons/users/user1.png',
      'icon': 'assets/icons/users/check-white.png'
    },
    {
      'name': 'SOuvik',
      'imageUrl': 'assets/icons/users/user2.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'Bhim',
      'imageUrl': 'assets/icons/users/user3.png',
      'icon': 'assets/icons/users/check-white.png'
    },
    {
      'name': 'raj',
      'imageUrl': 'assets/icons/users/user4.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'alok',
      'imageUrl': 'assets/icons/users/user5.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'Sandip',
      'imageUrl': 'assets/icons/users/user1.png',
      'icon': 'assets/icons/users/check-white.png'
    },
    {
      'name': 'SOuvik',
      'imageUrl': 'assets/icons/users/user2.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'Bhim',
      'imageUrl': 'assets/icons/users/user3.png',
      'icon': 'assets/icons/users/check-white.png'
    },
    {
      'name': 'raj',
      'imageUrl': 'assets/icons/users/user4.png',
      'icon': 'assets/icons/users/Follow.png'
    },
    {
      'name': 'alok',
      'imageUrl': 'assets/icons/users/user5.png',
      'icon': 'assets/icons/users/Follow.png'
    },

    // Add more users and their images here...
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(0, 255, 193, 7),
        centerTitle: true,
        title: Text("Invite Friends"),
        backgroundColor: AppColor.AppThemecolor,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(user['imageUrl'].toString()),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user['name'].toString()),
                  Image.asset(user['icon'].toString())
                ],
              ),
              onTap: () {
                print('Tapped on user: ${user['name']}');
              },
            ),
          );
        },
      ),
    );
  }
}
