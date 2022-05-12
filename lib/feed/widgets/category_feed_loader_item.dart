import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Renders a widget containing a progress indicator that calls
/// [onPresented] when the item becomes visible.
@visibleForTesting
class CategoryFeedLoaderItem extends StatefulWidget {
  const CategoryFeedLoaderItem({
    Key? key,
    this.onPresented,
  }) : super(key: key);

  /// A callback performed when the widget is presented.
  final VoidCallback? onPresented;

  @override
  State<CategoryFeedLoaderItem> createState() => _CategoryFeedLoaderItemState();
}

class _CategoryFeedLoaderItemState extends State<CategoryFeedLoaderItem> {
  @override
  void initState() {
    super.initState();
    widget.onPresented?.call();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}