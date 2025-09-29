// import 'package:custom_widgets/custom_widget/core/empty_attachment_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:custom_widgets/model/attachment_model.dart';

// class AttachmentUploadSection extends StatelessWidget {
//   final BuildContext ctx;
//   final Function(FileModel file) onTapCamera;
//   final Function(FileModel file) onTapGallery;

//   const AttachmentUploadSection({
//     super.key,
//     required this.ctx,
//     required this.onTapCamera,
//     required this.onTapGallery,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // const Text(
//             //   'Attach Documents',
//             //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             // ),
//             TextButton(
//               onPressed: () {
//                 // You can trigger file picker here or forward it
//               },
//               child: const Text('Upload'),
//             ),
//           ],
//         ),

//         const Divider(),

//         const SizedBox(height: 16),

//         // Wrap your existing EmptyAttachmentWidget
//         EmptyAttachmentWidget(
//           ctx: ctx,
//           onTapCamera: onTapCamera,
//           onTapGallary: onTapGallery,
//         ),

//         const SizedBox(height: 24),

//         // Optional: Add another Upload button below
//         Align(
//           alignment: Alignment.center,
//           child: ElevatedButton(
//             onPressed: () {
//               // Trigger file picker again or same as onTapCamera
//             },
//             child: const Text("Upload"),
//           ),
//         ),
//       ],
//     );
//   }
// }
