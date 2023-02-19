import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Row(
      //       children: [
      //         SizedBox(width: 95,),
      //         Container(
      //           width: 200,
      //           child: TextFormField(
      //             autofocus: false,
      //             keyboardType: TextInputType.emailAddress,
      //             decoration: InputDecoration(
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}


