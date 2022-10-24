import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/crud_operations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routename = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> usersList = [
    User(
        name: 'Priyanshu',
        negativeMoney: 278,
        positiveMoney: 939,
        userId: 'Great'),
    User(
        name: 'rohit',
        negativeMoney: 278,
        positiveMoney: 9349,
        userId: 'not so much'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Khatabook')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Text(usersList[index].name),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        
                      addMoney(usersList, 2, usersList[index].userId);
                      });
                    },
                    child: const Text('Add money'))
              ],
            ),
            trailing:
                Text('Negative money is ${usersList[index].positiveMoney}'),
          );
        },
        itemCount: usersList.length,
      ),
    );
  }
}
