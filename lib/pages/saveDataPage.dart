import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white54,
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          Container(
            width: 60,
            height: 90,
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
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                        color: Colors.white10,
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),

                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'save',
                            child: Text('Modifier'),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Modifier'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Supprimer'),
                          )
                        ],
                        // onSelected: (value) {
                        //   if (value == 'edit') {
                        //     navigatorSimple(context, NewPostScreen(
                        //       title: "Modifier un post",
                        //       post: post,
                        //     ));

                        //   } else {
                        //     _handleDeletePost(post.id ?? 0);
                        //   }
                        // },
                      ),
                    ],
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}