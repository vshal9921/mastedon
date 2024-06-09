import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),),
        ),
        onPressed: () {
          // var state = Provider.of<AuthState>(context, listen: false);
          // Navigator.push(context,MaterialPageRoute(builder: (context) => Signup(loginCallback: state.getCurrentUser),),);
        },
        child: const Text("Create Account"),
      ),
    );
  }

  // Widget _body() {
  //   return SafeArea(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: 40,
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width - 80,
  //             height: 40,
  //             child: Image.asset('assets/images/icon-480.png'),
  //           ),
  //           const Spacer(),
  //           const TitleText(
  //             'See what\'s happening in the world right now.',
  //             fontSize: 25,
  //           ),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           _submitButton(),
  //           const Spacer(),
  //           Wrap(
  //             alignment: WrapAlignment.center,
  //             crossAxisAlignment: WrapCrossAlignment.center,
  //             children: <Widget>[
  //               const TitleText(
  //                 'Have an account already?',
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w300,
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   // var state = Provider.of<AuthState>(context, listen: false);
  //                   // Navigator.push(
  //                   //   context,
  //                   //   MaterialPageRoute(
  //                   //     builder: (context) =>
  //                   //         SignIn(loginCallback: state.getCurrentUser),
  //                   //   ),
  //                   // );
  //                 },
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
  //                   child: Text(
  //                     ' Log in',
  //                     fontSize: 14,
  //                     color: TwitterColor.dodgeBlue,
  //                     fontWeight: FontWeight.w300,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           const SizedBox(height: 20)
  //         ],
  //       ),
  //     ),
  // }
}