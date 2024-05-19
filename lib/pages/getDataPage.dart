import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/configs/constants/constant.dart';
import 'package:test_app/database/db.dart';
import 'package:test_app/models/user.dart';
import 'package:toastification/toastification.dart';

class GetDataPage extends StatefulWidget {
  const GetDataPage({super.key});

  @override
  State<GetDataPage> createState() => _GetDataPageState();
}

class _GetDataPageState extends State<GetDataPage> {
  List<dynamic> _users = [];
  bool _isLoading = false;
  DatabaseService databaseHelper = DatabaseService();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    fetchUsers().then((users) {
      setState(() {
        _users = users;
        _isLoading = false;
      });
    }).catchError((error) {
      // ignore: avoid_print
      print(error);
      setState(() {
        _isLoading = false;
      });
    });
  }


 void saveUserData(userData) async {
    UserModel user = UserModel.fromJson(userData);
    DatabaseService helper = DatabaseService();
    await helper.insertUser(user);
    print('User data saved successfully!');
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
                    height: 80,
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
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        user['picture']['thumbnail']),
                                  ),
                                ))),
                        const SizedBox(height: 8),
                        Text(
                          "${user['name']['first']} ${user['name']['last']}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${user['dob']['age']} years old',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              user['location']['country'],
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ElevatedButton(
                              onPressed: () async {
                              saveUserData(user);
                              },
                              child: const Icon(
                                Icons.save_alt,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
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

Future<List<dynamic>> fetchUsers() async {
  final response = await http.get(Uri.parse(urlApi));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final users = json['results'];
    return users;
  } else {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: const Text('Failed to load users check your network'),
      autoCloseDuration: const Duration(seconds: 5),
    );
    throw Exception('Failed to load users');
  }
}