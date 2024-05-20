import 'package:flutter/material.dart';
import 'package:test_app/configs/constants/constant.dart';
import 'package:test_app/pages/getdata_page.dart';
import 'package:test_app/pages/savedata_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ? const GetDataPage() : const SavedPage(),
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(icon: Image.asset(ic1,width: 20,height: 20,),backgroundColor: Colors.black87, activeIcon: Image.asset(ic2,width: 20,height: 20,), label: "Api Data"),
          BottomNavigationBarItem(icon:  Image.asset(ic3,width: 20,height: 20,),backgroundColor: Colors.black87,activeIcon: Image.asset(ic4,width: 20,height: 20,), label: "DB Data"),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
