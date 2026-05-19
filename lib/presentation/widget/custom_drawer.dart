import 'package:flutter/material.dart';
import 'package:goods_delivery_app/helper/core/SharedPreferencesHelper.dart';
import 'package:goods_delivery_app/presentation/screen/logIn_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              final scaffoldMessenger = ScaffoldMessenger.of(context);

              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: const Text('Are you sure you want to log out?'),
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: 'Yes',
                    onPressed: () async {
                      await SharedPreferencesHelper.deleteToken();
                      print('✅ Token deleted successfully');

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(), // Close dialog
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop(); // Close dialog

                        await SharedPreferencesHelper.deleteToken();
                        print('✅ Token deleted successfully');

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
