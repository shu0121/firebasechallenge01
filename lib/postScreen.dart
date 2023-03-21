import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebasechallenge01/constants.dart';


class postScreen extends StatefulWidget {
  const postScreen({Key? key}) : super(key: key);

  @override
  State<postScreen> createState() => _postScreenState();
}

class _postScreenState extends State<postScreen> {

  TextEditingController textEditingController = TextEditingController();
  bool isEditing = false;

  //スクロール
  ScrollController scrollController = ScrollController();


  final Stream<QuerySnapshot> _message = FirebaseFirestore.instance.collection('messagelists').orderBy('timestamp').snapshots();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> messageId = FirebaseFirestore.instance.collection('messagelists').where('userId').snapshots();

  // late String sendUser;
  //
  //
  // getUserName() async {
  //   DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection('messagelists').doc(userId).get();
  //   Map<String, dynamic> userData = userDocument.data()! as Map<String, dynamic>;
  //   sendUser = userData['userId'];
  // }


    //メッセージを送る
  sendMessage() async {
    await FirebaseFirestore.instance.collection('messagelists').doc().set({
      'message': textEditingController.text,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
    textEditingController.clear();
    isEditing = false;
  }
  //   setState(() {
  //     messageList.add({
  //       'message': textEditingController.text,
  //       // 'userId': '',
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //     textEditingController.clear();
  //     isEditing = false;
  //   });
  //   scrollController.animateTo(scrollController.position.maxScrollExtent,
  //       duration: const Duration(microseconds: 500), curve: Curves.easeIn);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child:
            StreamBuilder<QuerySnapshot>(
              stream: _message,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  List<DocumentSnapshot> messagesData = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: messagesData.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> messageData = messagesData[index].data()! as Map<String, dynamic>;
                      return Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: messageData['userId'] == userId
                                  ? Colors.lime
                                  : Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(messageData['message']),
                            ),
                          )
                        ],
                      );
                    }
                  );
                }else{
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20,),
                  padding: const EdgeInsets.only(left: 20, right: 10,),
                  decoration: BoxDecoration(
                    color: inputLightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: textEditingController,
                          ),
                      ),
                      IconButton(
                          onPressed: () async {
                            sendMessage();
                            textEditingController.clear();
                          },
                          icon: const Icon(Icons.send, color: Colors.black,)
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
