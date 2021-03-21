part of dialog;


/// Custom Dialog Widget
class CustomDialogWidget extends StatelessWidget {
  /// Creates an alert dialog.
  const CustomDialogWidget({
    Key key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.description,
    this.descriptionPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.descriptionTextStyle,
    this.bottomWidget,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.body,
    this.minWidth,
  })  : assert(descriptionPadding != null),
        super(key: key);

  /// Title text && Title Padding && Title Style
  final Widget title;
  final TextStyle titleTextStyle;
  final EdgeInsetsGeometry titlePadding;

  /// Description text && Description Padding && Description Style
  final Widget description;
  final EdgeInsetsGeometry descriptionPadding;
  final TextStyle descriptionTextStyle;

  /// Dialog Body.
  final Widget body;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  final List<Widget> actions;

  ///Widget in the bottom
  final Widget bottomWidget;

  /// Dialog Background Color
  final Color backgroundColor;

  /// Dialog elevation
  final double elevation;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  final String semanticLabel;

  /// Dialog shape
  final ShapeBorder shape;

  ///Min width
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final List<Widget> children = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      children.add(
        Padding(
          padding: titlePadding ??
              EdgeInsets.fromLTRB(
                24.0,
                24.0,
                24.0,
                description == null ? 20.0 : 0.0,
              ),
          child: DefaultTextStyle(
            style: titleTextStyle ??
                dialogTheme.titleTextStyle ??
                theme.textTheme.headline6,
            child: Semantics(
              child: title,
              namesRoute: true,
              container: true,
            ),
          ),
        ),
      );
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
          break;
        case TargetPlatform.linux:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
          break;
        case TargetPlatform.macOS:
          label = semanticLabel;
          break;
        case TargetPlatform.windows:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
          break;
      }
    }

    if (description != null) {
      children.add(
        Flexible(
          child: Padding(
            padding: descriptionPadding,
            child: DefaultTextStyle(
              style: descriptionTextStyle ??
                  dialogTheme.contentTextStyle ??
                  theme.textTheme.subtitle1,
              child: description,
            ),
          ),
        ),
      );
    }

    if (body != null) {
      children.add(
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 24.0),
          child: body,
        ),
      );
    }

    if (bottomWidget != null) {
      children.add(bottomWidget);
    } else if (actions != null) {
      children.add(
        ButtonBarTheme(
          data: ButtonBarTheme.of(context),
          child: ButtonBar(
            children: actions,
          ),
        ),
      );
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    if (label != null)
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );

    dialogChild = CustomDialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      minWidth: minWidth,
      shape: shape,
      child: dialogChild,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        child: dialogChild);
  }
}

