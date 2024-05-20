// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:test_app/configs/routes/navigator.dart';
import 'package:test_app/database/db.dart';
import 'package:test_app/pages/update.dart';
import 'package:toastification/toastification.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  bool _isLoading = false;
  DatabaseService databaseHelper = DatabaseService();
  late TextEditingController _search;
  List<dynamic> _allUsers = [];
  List<dynamic> _filteredUsers = [];
  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
    _loadUser();
  }

  void _filterUsers(String searchText) {
    final List<dynamic> filteredUsers = _allUsers.where((user) {
      final fullName = '${user['firstName']} ${user['lastName']}';
      return fullName.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    setState(() {
      _filteredUsers = filteredUsers;
    });
  }

  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<dynamic> users = await databaseHelper.loadUser();
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
        _isLoading = false;
      });
      print('User data fetched successfully!');
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFD2D2EB),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: const Color(0xFFD2D2EB),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: 'Type lastname or firstname...',
                      hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                      contentPadding: const EdgeInsets.all(4),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD2D2EB),
                    ),
                    onChanged: (value) {
                      _filterUsers(value);
                    }),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.count(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2,
                        children: List.generate(_filteredUsers.length, (index) {
                          final user = _filteredUsers[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 145,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              user['pictureLarge']),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${user['firstName']} ${user['lastName']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                           color: Color(0xFF1C5588),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '${user['state']}',
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            '${user['country']}',
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${user['email']}',
                                        style: const TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: PopupMenuButton(
                                        position: PopupMenuPosition.under,
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
                                                      fontSize: 16,
                                                      color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.delete,
                                                    color: Colors.red),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            navigatorSimple(
                                                context, Update(data: user));
                                          } else {
                                            databaseHelper
                                                .deleteUser('${user['email']}');
                                            _loadUser();
                                            toastification.show(
                                              type: ToastificationType.success,
                                              style: ToastificationStyle
                                                  .flatColored,
                                              title: const Text(
                                                  'Users deleted successfully'),
                                              autoCloseDuration:
                                                  const Duration(seconds: 2),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
