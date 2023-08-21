import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddeliveryapp/core/Common/Authentication.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/Screen/SelectCountry.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var  emailcontroll = TextEditingController();
    var  passcontroll =TextEditingController();
    var  confirmpasscontroll = TextEditingController();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(220),
            child: AppBar(
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2,color: Color(0xFFFA4A0C)),
                    insets: EdgeInsets.symmetric(horizontal:30.0)
                ),
                tabs: [
                  Tab(child: Text("Login",style: TextStyle(color: Colors.black,fontFamily: Fonts.Poppins,fontWeight: FontWeight.w800,fontSize: 18),),),
                  Tab(child: Text("Sign-Up",style: TextStyle(color: Colors.black,fontFamily: Fonts.Poppins,fontWeight: FontWeight.w800,fontSize: 18)),)
                ],
              ),
              elevation: 5,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              flexibleSpace: SafeArea(
                child: Center(
                  child: Image(image: AssetImage(ImageRes.logo),),
                ),
              ),
            ),
          ) ,
          body: TabBarView(
            children: [
                PageAndForgotPassWord(), // login
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Register",style: TextStyle(color: Colours.boldOrange,fontWeight: FontWeight.bold,fontSize: 36,fontFamily: Fonts.Ninito),),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow:[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          offset: Offset(0,2),
                                          blurRadius: 10,
                                        )
                                      ]
                                    ),
                                    child: TextButton(
                                        onPressed: (){},
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                          )
                                        ),
                                        child: Image(image: AssetImage(ImageRes.gg),width: 27,height: 27,fit: BoxFit.cover,)
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow:[
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            offset: Offset(0,2),
                                            blurRadius: 10,
                                          )
                                        ]
                                    ),
                                    child: TextButton(
                                        onPressed: (){},
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                            )
                                        ),
                                        child: Image(image: AssetImage(ImageRes.fb),width: 27,height: 27,)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: InputField(TextHint: "Enter your email here", FontStyle: Fonts.Nunito,controler: emailcontroll,),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5,bottom: 10),
                        //   child: InputField(TextHint: "Enter your phone here", FontStyle: Fonts.Nunito),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 10),
                          child: InputField(TextHint: "Enter your password here", FontStyle: Fonts.Nunito,controler: passcontroll,),
                        ),
                        InputField(TextHint: "Confirm your password here", FontStyle: Fonts.Nunito,controler: confirmpasscontroll,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  OrangeButtonWithWhiteText(widgth: 170,text: "Sign-up", Onpressed: (){
                                    AuthController.instance.register(emailcontroll.text.trim(), passcontroll.text.trim(), confirmpasscontroll.text.trim());
                                  }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  RichText(text: TextSpan(
                                    text: "Already a \nMember ? ",style:TextStyle(fontSize: 16,color: Colours.fieldText),
                                   ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Builder(
                                      builder: (BuildContext context){
                                        return TextButton(
                                          child: Text("Login",style: TextStyle(color: Color(0xFFB3B3B3),fontWeight: FontWeight.bold,fontSize: 18)
                                          ),onPressed: (){
                                          DefaultTabController.of(context).animateTo(0); // Chuyển đến tab thứ hai (chỉ số bắt đầu từ 0)
                                        },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        //InputField(TextHint: "0981717878")
                      ],
                    ),
                  ),
                ),// sign up
            ],
          ),
        ),
      )
    );
  }
}

class PageAndForgotPassWord extends StatefulWidget {
  const PageAndForgotPassWord({super.key});

  @override
  State<PageAndForgotPassWord> createState() => _PageAndForgotPassWordState();
}

class _PageAndForgotPassWordState extends State<PageAndForgotPassWord> {
  var  emailcontroll = TextEditingController();
  var  passcontroll =TextEditingController();
  bool IsTap=true;
  @override
  Widget build(BuildContext context) {
    return (IsTap) ? Padding(
      padding: const EdgeInsets.only(top:30,left: 25,right: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(TextHint: "Enter your email here", FontStyle: Fonts.Nunito,controler: emailcontroll,),
            SizedBox(
              height: 10,
            ),
            InputField(TextHint: "Enter your password here",FontStyle: Fonts.Nunito,controler: passcontroll,),
            SizedBox(height: 10,),
            Row(
              children: [
                TextButton(
                  child: Text("Forgot Password ?",style: TextStyle(color: Color(0xFFFA4A0C),fontSize: 14,fontWeight: FontWeight.bold),),
                  onPressed: (){setState(() {
                    IsTap=false;
                  });},),
              ],
            ),
            SizedBox(height: 10,),

            OrangeButtonWithWhiteText( text: "Login", Onpressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Country()));
              AuthController.instance.login(emailcontroll.text.trim(), passcontroll.text.trim());
            },),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Text("Or",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //padding: EdgeInsets.symmetric(horizontal: 160,vertical: 10),
                  minimumSize: Size(400, 58),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  backgroundColor: Color(0xFF1877F2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook),
                  SizedBox(width: 4,),
                  Text("Log In With Facebook",style: TextStyle(fontSize: 15,color: Colours.whiteText,fontWeight:FontWeight.w600,fontFamily: Fonts.Poppins))
                ],
              ),onPressed: (){

            },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //padding: EdgeInsets.symmetric(horizontal: 160,vertical: 10),
                  minimumSize: Size(400, 58),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  backgroundColor: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.google,color: Colors.red,),
                  SizedBox(width: 5,),
                  Text("Log In With Google",style: TextStyle(fontSize: 15,color: Color(0xFF000000),fontWeight:FontWeight.w600,fontFamily: Fonts.Poppins))
                ],
              ),onPressed: (){},
            ),
          ],
        ),
      ),
    ) : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 25),
              child: InkWell(child: Icon(Icons.arrow_back_ios_sharp),onTap: (){setState(() {
                IsTap=true;
              });},),
            ),
            Text("Forgot\nPassword?",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w600,color: Colours.lightOrboldOrangeTextangeText,fontFamily: Fonts.Nunito),),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  hintText: "Enter your email address",
                  hintStyle: TextStyle(fontFamily: Fonts.Nunito,fontSize: 16,color: Color(0xFF676767)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            RichText(text: TextSpan(text: "*",style: TextStyle(color: Colors.red,fontSize: 12),children: [
              TextSpan(text: "We will send you a message to set or reset your new password",style: TextStyle(color:Color(0xFF676767),fontSize: 12,fontWeight: FontWeight.w400,fontFamily: Fonts.Nunito)),
            ])),
            Padding(
              padding: const EdgeInsets.only(top: 35,bottom: 35),
              child: Text("Send Code",style: TextStyle(color: Color(0xFFB2B2B2),fontSize: 24,fontWeight: FontWeight.bold,fontFamily: Fonts.Nunito),),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colours.lightOrboldOrangeTextangeText,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colours.lightOrboldOrangeTextangeText,
                                  blurRadius: 5,offset: Offset(0,5)),
                            ]
                        ),
                        child: Icon(Icons.arrow_forward,color: Colors.white,)
                    ),onTap: (){},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


