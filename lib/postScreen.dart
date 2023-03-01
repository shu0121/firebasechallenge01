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

  //メッセージを送る
  sendMessage(){
    setState(() {
      messageList.add({
        'message': textEditingController.text,
        'userId': 'n0ONN718IHXYKMqUftgdCfkB7Yo2',
      });
      textEditingController.clear();
      isEditing = false;
    });
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index){
                    return buildMessage(messageList[index]);
                  },
                itemCount: messageList.length,
                controller: scrollController,
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
                      IconButton(onPressed: sendMessage, icon: const Icon(Icons.send, color: Colors.black,)),
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
  
  Widget buildMessage(Map<String, dynamic> messageInfo){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(messageInfo['message']),
          ),
        )
      ],
    );
  }
  
}
