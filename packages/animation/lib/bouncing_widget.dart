part of animation;

class BouncingWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;

  BouncingWidget({
    @required this.child,
    @required this.onPressed,
    this.duration = const Duration(milliseconds: 140),
  }) : assert(child != null);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _animate;

  VoidCallback get onPressed => widget.onPressed;

  Duration get userDuration => widget.duration;

  @override
  void initState() {
    _animate = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animate?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return GestureDetector(
      onTap: _onTap,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void _onTap() {
    _animate.forward();
    Future.delayed(
        userDuration != null ? userDuration : Duration(milliseconds: 100), () {
      _animate.reverse();

      if (onPressed != null) onPressed();
    });
  }
}
