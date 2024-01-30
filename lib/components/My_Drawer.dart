import 'package:flutter/material.dart';

import '../auth/auth_services.dart';
import '../pages/Settings_Page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    //get a access of auth service
    final _auth= AuthService();
    _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(child: Icon(Icons.message,
          color: Theme.of(context).colorScheme.primary,
          size: 45,),
          ),
          ///home list tile
           Padding(
             padding: const EdgeInsets.only(left: 25.0),
             child: ListTile(
               title: Text('H O M E'),
               leading: Icon(Icons.home),
               onTap: (){
                 //pop the drawer
                 Navigator.pop(context);
               },
             ),
           ),
          ///settings list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text('S E T T I N G S'),
              leading: Icon(Icons.settings),
              onTap: (){
                //pop the drawer
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
              },
            ),
          ),
          ///logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text('L O G O U T'),
              leading:Icon(Icons.logout),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
