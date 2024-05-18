import 'package:flutter/material.dart';

Widget myCard({
 
  required String name,
  required String city,
  required String country,
  required String image,

  required IconData icon,
  bool obscureText = false,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
}) {
  return Container(
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
                  // IconButton(  onPressed: () {}, icon: const Icon(Icons.save_alt)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  const Text(
                    "Nom et prenoms",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Ville",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Country",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.save_alt),
                  )
                ],
              ),
            );
}