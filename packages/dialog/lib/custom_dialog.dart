part of dialog;


class CustomDialog extends StatelessWidget {

  /// Dialog Background Color
  final Color backgroundColor;

  /// Dialog elevation
  final double elevation;

  /// Dialog Duration
  final Duration insetAnimationDuration;

  /// Dialog Curve
  final Curve insetAnimationCurve;

  ///Min width of the dialog
  final double minWidth;
  final ShapeBorder shape;

  /// The widget below this widget in the tree.
  final Widget child;

  static const RoundedRectangleBorder _defaultDialogShape =
  RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(2.0),
    ),
  );
  static const double _defaultElevation = 24.0;

  /// Creates a dialog.
  const CustomDialog({
    Key key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.minWidth = 280.0,
    this.shape,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: minWidth ?? 280.0),
            child: Material(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation:
              elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
