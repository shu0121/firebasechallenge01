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

            //ユーザー登録ボタン
            Container(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async{
                    try{
                      final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
                      if (user != null)
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const postScreen()));
                    } catch (e){
                      print (e);
                    }
                  },
                  child: Text('ユーザー登録'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                ),
              ),
            ),

            SizedBox(height: 30,),

            //テキスト
            RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '既にアカウントをお持ちですか？',
                      style: textStyle,
                    )
                  ]
                ),
            )

          ],
        ),
      )
    );
  }
}


