import 'package:flutter/widgets.dart';
import '../fast_develop.dart';

typedef TouchTap = void Function(BuildContext context);

/// 触摸
class TouchWidget extends StatefulWidget {
  const TouchWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.pressedOpacity,
    this.padding,
    int? touchSpaced,
  })  : this.onDoubleTap = null,
        this.onLongPressUp = null,
        this.touchSpaced = touchSpaced == null ? 1 : touchSpaced,
        super(key: key);

  final Widget child;
  final double? padding;
  final TouchTap? onTap;
  final Function? onDoubleTap;
  final Function? onLongPressUp;

  /// 触摸事件的间隔  单位为秒 小于等于0 代表不开启间隔监听
  final int touchSpaced;

  /// The opacity that the button will fade to when it is pressed.
  /// The button will have an opacity of 1.0 when it is not pressed.
  ///
  /// This defaults to 0.4. If null, opacity will not change on pressed if using
  /// your own custom effects is desired.
  /// 0 关闭
  final double? pressedOpacity;

  @override
  _TouchWidgetState createState() => _TouchWidgetState();
}

class _TouchWidgetState extends State<TouchWidget>
    with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController? _animationController;
  late Animation<double> _opacityAnimation;
  late DateTime? _lastPressed;
  late Duration _touchSp;
  var _pressedOpacity;

  @override
  void initState() {
    super.initState();
    _pressedOpacity = widget.pressedOpacity ??
        FastDevelopConfig.instance.touchWidgetOfPressedOpacity;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController!
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(TouchWidget old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = _pressedOpacity ?? 1.0;
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController == null || _animationController!.isAnimating)
      return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController!.animateTo(1.0, duration: kFadeOutDuration)
        : _animationController!.animateTo(0.0, duration: kFadeInDuration);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.onTap != null && _pressedOpacity > 0;
    var _padding =
        widget.padding ?? FastDevelopConfig.instance.touchWidgetOfPadding;
    return Padding(
      padding: Spacing.all(size: _padding),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? _handleTapDown : null,
        onTapUp: enabled ? _handleTapUp : null,
        onTapCancel: enabled ? _handleTapCancel : null,
        onTap: () {
          if (widget.onTap == null) return;

          if (widget.touchSpaced <= 0) {
            widget.onTap!(context);
          } else {
            _touchSp ??= Duration(seconds: widget.touchSpaced);
            if (_lastPressed == null ||
                DateTime.now().difference(_lastPressed!) > _touchSp) {
              _lastPressed = DateTime.now();
              widget.onTap!(context);
            }
            _lastPressed = DateTime.now();
          }
        },
        child: Semantics(
          button: true,
          child: _pressedOpacity == 0
              ? widget.child
              : FadeTransition(opacity: _opacityAnimation, child: widget.child),
        ),
      ),
    );
  }
}
