// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../model/assignment_model.dart';
// import 'assignment_widget.dart';
//
// class NextAssignment extends StatelessWidget {
//   double maxHeight,maxWidth;
//   String title,emptyMessage;
//
//   NextAssignment(this.maxHeight, this.maxWidth, this.title, this.emptyMessage,
//       this.assignment);
//
//   List<Assignment> assignment=[];
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//
//
//       children: [
//         Row(children: [
//           Row(children: [Text('من',style: Theme.of(context).textTheme.headline4,)],)
//
//         ],),
//         AssignmentTable(maxHeight, maxWidth, 'المراجعة', 'لا يوجد مراجعة',
//             assignment,),
//       ],
//     );
//   }
//
// }