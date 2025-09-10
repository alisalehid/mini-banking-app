import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../theme/presentation/providers/theme_notifier.dart';
import '../theme/presentation/theme/app_colors.dart';

/// States that your button can assume via the controller
enum ButtonState { idle, loading, success, error }

class CustomGradientLoadingButton extends StatelessWidget {
  const CustomGradientLoadingButton({
    required this.controller,
    required this.title,
    this.fullWidth = false,
    this.suffix,
    this.onTap,
    this.indicatorColor = Colors.white,
    super.key,
    this.buttonTextColor = Colors.white,
    this.gradientColors = const [
      Color.fromARGB(255, 133, 141, 243),
      Color.fromARGB(255, 133, 141, 243),
      Color(0xff6d76ff),
      Color.fromARGB(255, 90, 100, 238),
    ],
  });

  final RoundedLoadingButtonController controller;
  final VoidCallback? onTap;
  final Widget? suffix;
  final bool fullWidth;
  final String title;
  final List<Color> gradientColors;
  final Color buttonTextColor;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final disableColor = Colors.grey.shade800;
    return _GradientLoadingButton(
      gradientColors: gradientColors,
      height: 50,
      width: fullWidth ? MediaQuery.of(context).size.width : 300,
      borderRadius: 100,
      animateOnTap: false,
      controller: controller,
      disabledColor: Colors.transparent,
      onPressed: onTap,
      indicatorColor: indicatorColor, // 👈 pass down
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: onTap == null ? disableColor : buttonTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}

class _GradientLoadingButton extends StatefulWidget {
  const _GradientLoadingButton({
    Key? key,
    required this.controller,
    required this.onPressed,
    required this.child,
    required this.gradientColors,
    required this.indicatorColor,
    this.height = 50,
    this.width = 300,
    this.borderRadius = 100,
    this.animateOnTap = true,
    this.disabledColor,
  }) : super(key: key);

  final RoundedLoadingButtonController controller;
  final VoidCallback? onPressed;
  final Widget child;
  final List<Color> gradientColors;
  final double height;
  final double width;
  final double borderRadius;
  final bool animateOnTap;
  final Color? disabledColor;
  final Color indicatorColor;

  @override
  State<_GradientLoadingButton> createState() => _GradientLoadingButtonState();
}

class _GradientLoadingButtonState extends State<_GradientLoadingButton>
    with TickerProviderStateMixin {
  final _state = BehaviorSubject<ButtonState>.seeded(ButtonState.idle);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return StreamBuilder<ButtonState>(
      stream: _state.stream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? ButtonState.idle;
        return SizedBox(
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedMeshGradient(
                  options: AnimatedMeshGradientOptions(
                    amplitude: 25,
                    frequency: 10,
                    speed: 5,
                  ),
                  colors: widget.gradientColors,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onPressed == null || state == ButtonState.loading
                        ? null
                        : _onTap,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Container(
                      height: widget.height,
                      width: widget.width,
                      alignment: Alignment.center,
                      child: state == ButtonState.loading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.indicatorColor, // 👈 use custom color
                        ),
                        strokeWidth: 2.0,
                      )
                          : widget.child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTap() {
    if (widget.animateOnTap) {
      _state.sink.add(ButtonState.loading);
      widget.onPressed?.call();
      Future.delayed(const Duration(seconds: 2), () {
        _state.sink.add(ButtonState.idle);
      });
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  void dispose() {
    _state.close();
    super.dispose();
  }
}

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    required this.controller,
    required this.title,
    this.fillColor = Colors.white,
    this.titleColor = Colors.black,
    this.fullWidth = false,
    this.suffix,
    this.onTap,
    this.indicatorColor = Colors.white,
    super.key,
  });

  final RoundedLoadingButtonController controller;
  final VoidCallback? onTap;
  final Widget? suffix;
  final bool fullWidth;
  final String title;
  final Color fillColor;
  final Color titleColor;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final disableColor = Colors.grey.shade800;
    final double buttonWidth = fullWidth
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.width * 0.8;
    return _RoundedLoadingButton(
      color: fillColor,
      height: 50,
      width: buttonWidth,
      borderRadius: 100,
      animateOnTap: false,
      controller: controller,
      disabledColor: Colors.transparent,
      indicatorColor: indicatorColor, // 👈 pass down
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: onTap == null ? disableColor : titleColor,
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}

class _RoundedLoadingButton extends StatefulWidget {
  final RoundedLoadingButtonController controller;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final double height;
  final double width;
  final double loaderSize;
  final double loaderStrokeWidth;
  final bool animateOnTap;
  final Color valueColor;
  final bool resetAfterDuration;
  final Curve curve;
  final double borderRadius;
  final Duration duration;
  final double elevation;
  final Duration resetDuration;
  final Color? errorColor;
  final Color? successColor;
  final Color? disabledColor;
  final IconData successIcon;
  final IconData failedIcon;
  final Curve completionCurve;
  final Duration completionDuration;
  final Color indicatorColor; // 👈 added

  Duration get _borderDuration {
    return Duration(milliseconds: (duration.inMilliseconds / 2).round());
  }

  const _RoundedLoadingButton({
    Key? key,
    required this.controller,
    required this.onPressed,
    required this.child,
    this.color = Colors.lightBlue,
    this.height = 50,
    this.width = 300,
    this.loaderSize = 50.0,
    this.loaderStrokeWidth = 2.0,
    this.animateOnTap = true,
    this.valueColor = Colors.white,
    this.borderRadius = 100,
    this.elevation = 2,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOutCirc,
    this.errorColor = Colors.red,
    this.successColor,
    this.resetDuration = const Duration(seconds: 15),
    this.resetAfterDuration = false,
    this.successIcon = Icons.check,
    this.failedIcon = Icons.close,
    this.completionCurve = Curves.elasticOut,
    this.completionDuration = const Duration(milliseconds: 1000),
    this.disabledColor,
    this.indicatorColor = Colors.white, // 👈 default
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoundedLoadingButtonState();
}

class _RoundedLoadingButtonState extends State<_RoundedLoadingButton>
    with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late AnimationController _borderController;
  late AnimationController _checkButtonControler;

  late Animation _squeezeAnimation;
  late Animation _bounceAnimation;
  late Animation _borderAnimation;

  final _state = BehaviorSubject<ButtonState>.seeded(ButtonState.idle);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _check = Container(
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: widget.successColor ?? theme.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(_bounceAnimation.value / 2),
        ),
      ),
      width: _bounceAnimation.value,
      height: _bounceAnimation.value,
      child: _bounceAnimation.value > 20
          ? Icon(widget.successIcon, color: widget.valueColor)
          : null,
    );

    Widget _cross = Container(
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: widget.errorColor,
        borderRadius: BorderRadius.all(
          Radius.circular(_bounceAnimation.value / 2),
        ),
      ),
      width: _bounceAnimation.value,
      height: _bounceAnimation.value,
      child: _bounceAnimation.value > 20
          ? Icon(widget.failedIcon, color: widget.valueColor)
          : null,
    );

    Widget _loader = SizedBox(
      height: widget.loaderSize,
      width: widget.loaderSize,
      child: CupertinoActivityIndicator(
        color: widget.indicatorColor, // 👈 use custom color
      ),
    );

    Widget childStream = StreamBuilder(
      stream: _state,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: snapshot.data == ButtonState.loading ? _loader : widget.child,
        );
      },
    );

    final _btn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(_squeezeAnimation.value, widget.height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        backgroundColor: widget.color,
        elevation: widget.elevation,
        padding: const EdgeInsets.all(0),
      ),
      onPressed: widget.onPressed == null ? null : _btnPressed,
      child: childStream,
    );

    return SizedBox(
      height: widget.height,
      child: Center(
        child: _state.value == ButtonState.error
            ? _cross
            : _state.value == ButtonState.success
            ? _check
            : _btn,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _checkButtonControler = AnimationController(
      duration: widget.completionDuration,
      vsync: this,
    );

    _borderController = AnimationController(
      duration: widget._borderDuration,
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 0, end: widget.height).animate(
      CurvedAnimation(
        parent: _checkButtonControler,
        curve: widget.completionCurve,
      ),
    )..addListener(() => setState(() {}));

    _squeezeAnimation =
    Tween<double>(begin: widget.width, end: widget.height).animate(
      CurvedAnimation(parent: _buttonController, curve: widget.curve),
    )..addListener(() => setState(() {}));

    _squeezeAnimation.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.animateOnTap) {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      }
    });

    _borderAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(widget.borderRadius),
      end: BorderRadius.circular(widget.height),
    ).animate(_borderController)..addListener(() => setState(() {}));

    _state.stream.listen((event) {
      if (!mounted) return;
      widget.controller._state.sink.add(event);
    });

    widget.controller._addListeners(_start, _stop, _success, _error, _reset);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _checkButtonControler.dispose();
    _borderController.dispose();
    _state.close();
    super.dispose();
  }

  void _btnPressed() async {
    if (widget.animateOnTap) {
      _start();
    } else {
      if (widget.onPressed != null) {
        if (_state.value == ButtonState.loading) return;
        widget.onPressed!();
      }
    }
  }

  void _start() {
    if (!mounted) return;
    _state.sink.add(ButtonState.loading);
    _borderController.forward();
    _buttonController.forward();
    if (widget.resetAfterDuration) _reset();
  }

  void _stop() {
    if (!mounted) return;
    _state.sink.add(ButtonState.idle);
    _buttonController.reverse();
    _borderController.reverse();
  }

  void _success() {
    if (!mounted) return;
    _state.sink.add(ButtonState.success);
    _checkButtonControler.forward();
  }

  void _error() {
    if (!mounted) return;
    _state.sink.add(ButtonState.error);
    _checkButtonControler.forward();
  }

  void _reset() async {
    if (widget.resetAfterDuration) await Future.delayed(widget.resetDuration);
    if (!mounted) return;
    _state.sink.add(ButtonState.idle);
    unawaited(_buttonController.reverse());
    unawaited(_borderController.reverse());
    _checkButtonControler.reset();
  }
}

class RoundedLoadingButtonController {
  VoidCallback? _startListener;
  VoidCallback? _stopListener;
  VoidCallback? _successListener;
  VoidCallback? _errorListener;
  VoidCallback? _resetListener;

  void _addListeners(
      VoidCallback startListener,
      VoidCallback stopListener,
      VoidCallback successListener,
      VoidCallback errorListener,
      VoidCallback resetListener,
      ) {
    _startListener = startListener;
    _stopListener = stopListener;
    _successListener = successListener;
    _errorListener = errorListener;
    _resetListener = resetListener;
  }

  final BehaviorSubject<ButtonState> _state =
  BehaviorSubject<ButtonState>.seeded(ButtonState.idle);

  Stream<ButtonState> get stateStream => _state.stream;

  ButtonState? get currentState => _state.value;

  void start() => _startListener?.call();

  void stop() => _stopListener?.call();

  void success() => _successListener?.call();

  void error() => _errorListener?.call();

  void reset() => _resetListener?.call();
}
