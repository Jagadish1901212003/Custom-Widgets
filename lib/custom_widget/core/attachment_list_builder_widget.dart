import 'package:flutter/material.dart';

class AttachmentListBuilderWidget extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  const AttachmentListBuilderWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 70,
        crossAxisCount: 4,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, fileIndex) => itemBuilder(context, fileIndex),
    );
  }
}
