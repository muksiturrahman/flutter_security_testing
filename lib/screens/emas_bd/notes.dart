/*
// Show a dialog with the selected file path and size
// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         return AlertDialog(
//           content: Container(
//             height: 200,
//             child: Column(
//               children: [
//                 AppBar(
//                   elevation: 0,
//                   backgroundColor: Colors.white,
//                   leading: Image.asset("assets/icons/upload.png",height: 30,),
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Upload Files",style: TextStyle(color: Color(0xff292D32),fontSize: 16),),
//                       Text("Selecte and upload files",style: TextStyle(fontSize: 12,color: Color(0xffA9ACB4)),),
//                     ],
//                   ),
//                   actions: [
//                     InkWell(
//                       onTap: (){
//                         Navigator.of(context)
//                             .pop();
//                       },
//                         child: Container(
//                           height: 10,
//                           width: 15,
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                             child: Image.asset("assets/icons/cross.png",fit: BoxFit.fill,),),),
//                   ],
//                 ),
//                 Divider(color: Colors.black,height: 5,),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xffFBFBFB),
//                     borderRadius:
//                     BorderRadius.circular(6),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         // Custom AppBar
//                         SizedBox(height: 20,),
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment
//                               .spaceBetween,
//                           children: [
//                             Row(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.end,
//                               children: [
//                                 Image.asset(
//                                     "assets/icons/pdf.png"),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: 180,
//                                           child: Text(
//                                             path.basename(
//                                                 selectedFilePath ??
//                                                     ""),
//                                             overflow:
//                                             TextOverflow
//                                                 .ellipsis,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15,
//                                         ),
//                                         Image.asset(
//                                           "assets/icons/cross.png",
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           formatFileSize(
//                                               selectedFileSize ??
//                                                   0),
//                                           style: TextStyle(
//                                               color: Color(
//                                                   0xffA9ACB4),
//                                               fontSize:
//                                               10),
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Row(
//                                           children: [
//                                             uploadCompleted?
//                                                 Image.asset("assets/icons/tick.png"):
//                                             Image.asset(
//                                                 "assets/icons/loading.png"),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               uploadStatus,
//                                               style: TextStyle(
//                                                   fontSize:
//                                                   12),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         if (uploading || uploadCompleted)
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius:
//                               BorderRadius.circular(10),
//                             ),
//                             child: LinearProgressIndicator(
//                               backgroundColor: Colors.grey,
//                               color: Color(0xffD59A01),
//                               value: uploadCompleted ? 1.0 : 0.5,
//                               minHeight: 4.0,
//                             ),
//                           )
//                         else
//                           Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   },
// );*/


/*
SizedBox(
width: 10,
),
Row(
children: [
uploadCompleted?
Image.asset("assets/icons/tick.png"):
Image.asset(
"assets/icons/loading.png"),
SizedBox(
width: 5,
),
Text(
uploadStatus,
style: TextStyle(
fontSize:
12),
)
],
),*/
