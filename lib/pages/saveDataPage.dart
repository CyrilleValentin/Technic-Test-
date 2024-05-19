// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:test_app/database/db.dart';
import 'package:toastification/toastification.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  bool _isLoading = false;
  DatabaseService databaseHelper = DatabaseService();

  List<dynamic> _users = [];
  @override
  void initState() {
    super.initState();
     setState(() {
      _isLoading = true;
    });
     loadUser().then((users) {
      setState(() {
        _users = users;
        _isLoading = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<List> loadUser() async {
    List<dynamic> users = await databaseHelper.loadUser();
    setState(() {
      _users = users;
    });
    print('User data fetched successfully!');
    return users;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white54,
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.count(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              children: List.generate(_users.length, (index) {
                final user = _users[index];
                return Container(
                    width: 40,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              offset: const Offset(0, 3),
                              blurRadius: 10)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 145,
                          height: 190,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(user['pictureLarge']),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  '${user['firstName']} ${user['lastName']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(width: 4),
                                  Text(
                                    '${user['state']}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '${user['country']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${user['email']}',
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PopupMenuButton(
                              position: PopupMenuPosition.over,
                              color: Colors.white70,
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.green),
                                      )
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'edit') {
                                } else {
                                  databaseHelper.deleteUser('${user['email']}');
                                  loadUser();
                                  toastification.show(
                                    type: ToastificationType.success,
                                    style: ToastificationStyle.flatColored,
                                    title: const Text(
                                        'Users deleted successfully'),
                                    autoCloseDuration:
                                        const Duration(seconds: 2),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ));
              }),
            ),
          ),
        ),
      );
    }
  }
}
