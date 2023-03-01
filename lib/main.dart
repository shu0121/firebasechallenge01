import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasechallenge01/firebase_options.dart';
import 'package:firebasechallenge01/postScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebasechallenge01/constants.dart';

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Challenge01',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}): super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  //コントローラー
  TextEditingController inputEmailController = TextEditingController();
  TextEditingController inputPassWordController = TextEditingController();

  //パスワードの表示・非表示
  bool _isObscure = true;

  String infoText = '';

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //メールアドレス入力欄
            Container(
              child: Row(
                children: [
                  SizedBox(width: 95,),
                  Container(
                    width: 200,
                    child: TextField(
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: inputEmailController,
                      decoration: InputDecoration(
                        labelText: 'メールアドレス',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      onChanged: (String value){
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30,),

            //パスワード入力欄
            Container(
              child: Row(
                children: [
                  SizedBox(width: 95,),
                  Container(
                    width: 200,
                    child: TextField(
                      autofocus: false,
                      obscureText: _isObscure,
                      keyboardType: TextInputType.visiblePassword,
                      controller: inputPassWordController,
                      decoration: InputDecoration(
                        labelText: 'パスワード',
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure? Icons.visibility_off: Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      onChanged: (String value){
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //ユーザー登録ボタン
                Container(
                  height: 50,
                  width: 110,
                  child: ElevatedButton(
                    onPressed: () async{
                      try{
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                        User user = userCredential.user!;
                        FirebaseFirestore.instance.collection('users').doc(user.uid).set({'id': user.uid, 'email': user.email});
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
                      } catch(e){
                        setState(() {
                          infoText = '登録に失敗しました。:${e.toString()}';
                        });
                        print(infoText);
                        await showDialog(context: context,
                            builder: (context){
                              return AlertDialog(
                                content: Text(infoText, style: TextStyle(fontSize: 12, color: Colors.red),),
                              );
                            }
                        );
                      };
                    },
                    child: Text('ユーザー登録', style: buttonStyle,),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 30,),


                //ログインボタン
                Container(
                  height: 50,
                  width: 110,
                  child: ElevatedButton(
                    onPressed: () async{
                      try{
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final userInfo = await auth.signInWithEmailAndPassword(email: _email, password: _password);
                        if(userInfo != null){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
                        };
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
                      } catch(e){
                        print(e);
                      };
                    },
                    child: Text('ログイン', style: buttonStyle,),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                    ),
                  ),
                ),
              ],
            ),


            //ユーザー登録ボタン
            // Container(
            //   height: 50,
            //   width: 120,
            //   child: ElevatedButton(
            //       onPressed: () async{
            //         try{
            //           UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
            //           User user = userCredential.user!;
            //           FirebaseFirestore.instance.collection('users').doc(user.uid).set({'id': user.uid, 'email': user.email});
            //           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
            //         } catch(e){
            //           setState(() {
            //             infoText = '登録に失敗しました。:${e.toString()}';
            //           });
            //           print(infoText);
            //           await showDialog(context: context,
            //               builder: (context){
            //                 return AlertDialog(
            //                   content: Text(infoText, style: TextStyle(fontSize: 12, color: Colors.red),),
            //                 );
            //               }
            //           );
            //         };
            //       },
            //       child: Text('ユーザー登録', style: buttonStyle,),
            //     style: ButtonStyle(
            //       shape: MaterialStateProperty.all(
            //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
            //       ),
            //     ),
            //   ),
            // ),
            //
            //
            // SizedBox(height: 30,),
            //
            // //ログインボタン
            // Container(
            //   height: 50,
            //   width: 120,
            //   child: ElevatedButton(
            //     onPressed: () async{
            //       try{
            //         final FirebaseAuth auth = FirebaseAuth.instance;
            //         final userInfo = await auth.signInWithEmailAndPassword(email: _email, password: _password);
            //         if(userInfo != null){
            //           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
            //         };
            //         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
            //       } catch(e){
            //         print(e);
            //       };
            //     },
            //     child: Text('ログイン', style: buttonStyle,),
            //     style: ButtonStyle(
            //       shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
            //       ),
            //     ),
            //   ),
            // ),


            // SizedBox(height: 30,),

            //テキスト
            // RichText(
            //     text: TextSpan(
            //       children: [
            //         TextSpan(
            //           text: '既にアカウントをお持ちですか？',
            //           style: textStyle,
            //         )
            //       ]
            //     ),
            // )

          ],
        ),
      )
    );
  }
}


