import 'package:flutter/material.dart';

class FrameContent extends StatelessWidget {
  /// Size frame
  final Size size;

  /// Clip behavior
  final Clip clipBehavior;

  /// Child widget
  final Widget child;

  const FrameContent({
    Key? key,
    required this.size,
    required this.clipBehavior,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: _screen(context),
    );
  }

  static MediaQueryData mediaQuery(BuildContext context, Size size) {
    final mediaQuery = MediaQuery.of(context);
    final padding = EdgeInsets.symmetric(vertical: 20);

    return mediaQuery.copyWith(
      size: size,
      viewInsets: EdgeInsets.zero,
      viewPadding: padding,
      devicePixelRatio: size.width / size.height,
    );
  }

  Widget _screen(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final sizeWidth = currentSize.width > size.width ? size.width : currentSize.width;
    final sizeHeight = currentSize.height > size.height ? size.height : currentSize.height;

    final box = SizedBox(
      width: sizeWidth,
      height: sizeHeight,
      child: MediaQuery(
        data: FrameContent.mediaQuery(context, size),
        child: child,
      ),
    );

    if (clipBehavior == Clip.none) {
      return box;
    }

    return ClipRect(
      clipBehavior: clipBehavior,
      child: box,
    );
  }
}
