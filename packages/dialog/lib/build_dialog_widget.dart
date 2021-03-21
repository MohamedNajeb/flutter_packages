part of dialog;


@immutable
class BuildDialogWidget extends StatelessWidget {
  ///Title text && Title Text Style
  final String titleText;
  final TextStyle titleTextStyle;

  ///description text && Description Text Style
  final String descriptionText;
  final TextStyle descriptionTextStyle;

  /// Negative button Text && Negative Text Style && Negative Click callback
  final String negativeText;
  final TextStyle negativeTextStyle;
  final VoidCallback onNegativeClick;

  /// Positive button Text && Positive Text Style && Positive Click callback
  final String positiveText;
  final TextStyle positiveTextStyle;
  final VoidCallback onPositiveClick;

  ///Actions at the bottom of dialog, when this is set, [negativeText] [positiveText] [onNegativeClick] [onPositiveClick] will not work。
  final List<Widget> actions;

  /// Dialog Border Radius.
  final double borderRadius;

  /// Dialog Background Color.
  final Color backgroundColor;

  /// Dialog Body
  final Widget body;

  BuildDialogWidget({
    this.titleText,
    this.descriptionText,
    this.actions,
    this.negativeText,
    this.positiveText,
    this.negativeTextStyle,
    this.positiveTextStyle,
    this.onNegativeClick,
    this.onPositiveClick,
    this.borderRadius = 10.0,
    this.backgroundColor = Colors.white,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.body,
  });


  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      title: titleText != null
          ? Text(
        titleText,
        style: titleTextStyle != null
            ? titleTextStyle
            : Theme.of(context).dialogTheme.titleTextStyle,
      )
          : null,
      description: descriptionText != null
          ? Text(
        descriptionText,
        style: descriptionTextStyle != null
            ? descriptionTextStyle
            : Theme.of(context).dialogTheme.contentTextStyle,
      )
          : null,

      body: body ?? null,

      actions: actions ??
          [
            onNegativeClick != null
                ? FlatButton(
              onPressed: onNegativeClick,
              splashColor: Theme.of(context).splashColor,
              highlightColor: Theme.of(context).highlightColor,
              child: Text(
                negativeText ?? 'Cancel',
                style: negativeTextStyle ??
                    TextStyle(
                        color: Theme.of(context).textTheme.overline.color,
                        fontSize:
                        Theme.of(context).textTheme.button.fontSize),
              ),
            )
                : null,
            onPositiveClick != null
                ? FlatButton(
              onPressed: onPositiveClick,
              splashColor: Theme.of(context).splashColor,
              highlightColor: Theme.of(context).highlightColor,
              child: Text(
                positiveText ?? 'Confirm',
                style: positiveTextStyle ??
                    TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize:
                        Theme.of(context).textTheme.button.fontSize),
              ),
            )
                : null,
          ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      //Theme.of(context).dialogTheme.shape,

      backgroundColor: backgroundColor,
    );
  }
}
