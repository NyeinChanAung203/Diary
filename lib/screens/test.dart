// import 'package:diary/utils/constants.dart';
// import 'package:flutter/material.dart';

// class PasswordSettingScreen extends StatefulWidget {
//   const PasswordSettingScreen({Key? key}) : super(key: key);

//   @override
//   State<PasswordSettingScreen> createState() => _PasswordSettingScreenState();
// }

// class _PasswordSettingScreenState extends State<PasswordSettingScreen> {
//   List<String> password = [];

//   void addPassword(String value) {
//     if (password.length < 4) {
//       setState(() {
//         password.add(value);
//       });
//       print(password);
//     }
//   }

//   void removePassword() {
//     setState(() {
//       if (password.isNotEmpty) password.removeLast();
//     });
//     print(password);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Positioned(
//                 left: 10,
//                 top: 10,
//                 child: IconButton(
//                   splashRadius: 20,
//                   iconSize: 40,
//                   color: primaryTextColor,
//                   icon: const Icon(
//                     Icons.chevron_left,
//                   ),
//                   onPressed: () {
//                     // Todo:
//                   },
//                 ),
//               ),

//               /* Background box decoration */
//               Positioned(
//                 top: 10,
//                 right: 0,
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   transform: Matrix4.rotationZ(12),
//                   decoration: BoxDecoration(
//                     color: boxColor.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 120,
//                 right: 0,
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   transform: Matrix4.rotationZ(12),
//                   decoration: BoxDecoration(
//                     color: boxColor.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -10,
//                 right: 30,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   transform: Matrix4.rotationZ(12),
//                   decoration: BoxDecoration(
//                     color: boxColor.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),

//               /* Content */
//               Positioned(
//                 top: 60,
//                 child: SizedBox(
//                   // color: Colors.blue,
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         'Set Password',
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                       SizedBox(
//                         width: 200,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: List.generate(
//                             4,
//                             (index) => CircleAvatar(
//                               backgroundColor: password.length > index
//                                   ? primaryColor
//                                   : inActiveColor,
//                               radius: 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Please enter password',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.45,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             KeyboardNumber(
//                               text: '0',
//                               onTap: () {
//                                 addPassword('0');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '1',
//                               onTap: () {
//                                 addPassword('1');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '2',
//                               onTap: () {
//                                 addPassword('2');
//                               },
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             KeyboardNumber(
//                               text: '4',
//                               onTap: () {
//                                 addPassword('4');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '5',
//                               onTap: () {
//                                 addPassword('5');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '6',
//                               onTap: () {
//                                 addPassword('6');
//                               },
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             KeyboardNumber(
//                               text: '7',
//                               onTap: () {
//                                 addPassword('7');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '8',
//                               onTap: () {
//                                 addPassword('8');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '9',
//                               onTap: () {
//                                 addPassword('9');
//                               },
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             KeyboardNumber(
//                               text: 'x',
//                               icon: Icons.backspace,
//                               onTap: () {
//                                 removePassword();
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: '0',
//                               onTap: () {
//                                 addPassword('0');
//                               },
//                             ),
//                             KeyboardNumber(
//                               text: 'ok',
//                               icon: Icons.check,
//                               onTap: () {
//                                 debugPrint('xxxxxxxxxx');
//                               },
//                             ),
//                           ],
//                         ),
//                       ]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class KeyboardNumber extends StatelessWidget {
//   const KeyboardNumber({
//     Key? key,
//     required this.text,
//     this.onTap,
//     this.icon,
//   }) : super(key: key);

//   final void Function()? onTap;
//   final String text;

//   final IconData? icon;
//   @override
//   Widget build(BuildContext context) {
//     return icon != null
//         ? IconButton(
//             iconSize: 30,
//             icon: Icon(
//               icon,
//               color: primaryTextColor,
//             ),
//             onPressed: onTap,
//           )
//         : TextButton(
//             onPressed: onTap,
//             child: Text(
//               text,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline4!
//                   .copyWith(color: primaryTextColor),
//             ),
//           );
//   }
// }
