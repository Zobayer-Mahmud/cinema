import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/app_dimens.dart';

enum PanelShape { rectangle, rounded }

enum DockType { inside, outside }

enum PanelState { open, closed }

class FloatingMenuPanel extends StatefulWidget {
  final double? positionTop;
  final double? positionLeft;
  final Color? borderColor;
  final double? borderWidth;
  final double? size;
  final double? iconSize;
  final String? panelIconPath; // Changed from IconData to String for SVG path
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? contentColor;
  final PanelShape? panelShape;
  PanelState? panelState;
  final double? panelOpenOffset;
  final int? panelAnimDuration;
  final Curve? panelAnimCurve;
  final DockType? dockType;
  final double? dockOffset;
  final int? dockAnimDuration;
  final Curve? dockAnimCurve;
  final List<String>?
  buttons; // Changed from List<IconData> to List<String> for SVG paths
  final Function(int) onPressed;

  FloatingMenuPanel({
    super.key,
    this.buttons,
    this.positionTop,
    this.positionLeft,
    this.borderColor,
    this.borderWidth,
    this.iconSize,
    this.panelIconPath, // Changed from IconData to String for SVG path
    this.size,
    this.borderRadius,
    this.panelState,
    this.panelOpenOffset,
    this.panelAnimDuration,
    this.panelAnimCurve,
    this.backgroundColor,
    this.contentColor,
    this.panelShape,
    this.dockType,
    this.dockOffset,
    this.dockAnimCurve,
    this.dockAnimDuration,
    required this.onPressed,
  });

  @override
  _FloatBoxState createState() => _FloatBoxState();
}

class _FloatBoxState extends State<FloatingMenuPanel> {
  double _positionTop = 0.0;
  double _positionLeft = 0.0;
  double _panOffsetTop = 0.0;
  double _panOffsetLeft = 0.0;
  int _movementSpeed = 0;

  @override
  void initState() {
    _positionTop = widget.positionTop ?? 0;
    _positionLeft = widget.positionLeft ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _pageWidth = MediaQuery.of(context).size.width;
    double _pageHeight = MediaQuery.of(context).size.height;

    //new changes
    double _bottomNavHeight = 180;

    List<String> _buttons = widget.buttons!;
    double _dockOffset = widget.dockOffset ?? 5.0;
    double _widgetSize = widget.size ?? 70.0;

    double _dockBoundary() {
      if (widget.dockType != null && widget.dockType == DockType.inside) {
        return _dockOffset;
      } else {
        return -_dockOffset;
      }
    }

    BorderRadius _borderRadius() {
      if (widget.panelShape != null &&
          widget.panelShape == PanelShape.rectangle) {
        return widget.borderRadius ?? BorderRadius.circular(0);
      } else {
        return BorderRadius.circular(_widgetSize);
      }
    }

    double _totalButtons() {
      if (widget.buttons == null) {
        return 0;
      } else {
        return widget.buttons!.length.toDouble();
      }
    }

    double _panelHeight() {
      if (widget.panelState == PanelState.open) {
        return (_widgetSize + (_widgetSize + 1) * _totalButtons()) +
            (widget.borderWidth ?? 0);
      } else {
        return _widgetSize + (widget.borderWidth ?? 0) * 2;
      }
    }

    ///New panelTop
    void _calcPanelTop() {
      if (_positionTop + _panelHeight() >
          _pageHeight - _bottomNavHeight - _dockBoundary()) {
        _positionTop =
            _pageHeight - _panelHeight() - _bottomNavHeight - _dockBoundary();
      }
    }

    // void _calcPanelTop() {
    //   if (_positionTop + _panelHeight() > _pageHeight + _dockBoundary()) {
    //     _positionTop = _pageHeight - _panelHeight() + _dockBoundary();
    //   }
    // }

    double _openDockLeft() {
      if (_positionLeft < (_pageWidth / 2)) {
        return widget.panelOpenOffset ?? 30.0;
      } else {
        return ((_pageWidth - _widgetSize)) - (widget.panelOpenOffset ?? 30.0);
      }
    }

    Border? _panelBorder() {
      if (widget.borderWidth != null && widget.borderWidth! > 0) {
        return Border.all(
          color: widget.borderColor ?? Color(0xFF333333),
          width: widget.borderWidth ?? 0.0,
        );
      } else {
        return null;
      }
    }

    void _forceDock() {
      double center = _positionLeft + (_widgetSize / 2);
      _movementSpeed = widget.dockAnimDuration ?? 300;

      if (center < _pageWidth / 2) {
        _positionLeft = 0.0 + _dockBoundary();
      } else {
        _positionLeft = (_pageWidth - _widgetSize) - _dockBoundary();
      }
    }

    return AnimatedPositioned(
      duration: Duration(milliseconds: _movementSpeed),
      top: _positionTop,
      left: _positionLeft,
      curve: widget.dockAnimCurve ?? Curves.fastLinearToSlowEaseIn,
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.panelAnimDuration ?? 600),
        width: _widgetSize,
        height: _panelHeight(),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Color(0xff00b0cb),
          borderRadius: _borderRadius(),
          border: _panelBorder(),
        ),
        curve: widget.panelAnimCurve ?? Curves.fastLinearToSlowEaseIn,
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            GestureDetector(
              onPanEnd: (event) {
                setState(() {
                  _forceDock();
                });
              },
              onTapCancel: () {
                print('TAP_CANCEL');
              },
              onPanStart: (event) {
                _panOffsetTop = event.globalPosition.dy - _positionTop;
                _panOffsetLeft = event.globalPosition.dx - _positionLeft;
              },
              onPanUpdate: (event) {
                setState(() {
                  widget.panelState = PanelState.closed;
                  _movementSpeed = 0;
                  _positionTop = event.globalPosition.dy - _panOffsetTop;

                  if (_positionTop < 0 + _dockBoundary()) {
                    _positionTop = 0 + _dockBoundary();
                  }

                  if (_positionTop >
                      (_pageHeight - _panelHeight()) -
                          _bottomNavHeight -
                          _dockBoundary()) {
                    _positionTop = (_pageHeight - _panelHeight()) -
                        _bottomNavHeight -
                        _dockBoundary();
                  }

                  // if (_positionTop >
                  //     (_pageHeight - _panelHeight()) - _dockBoundary()) {
                  //   _positionTop =
                  //       (_pageHeight - _panelHeight()) - _dockBoundary();
                  // }

                  _positionLeft = event.globalPosition.dx - _panOffsetLeft;

                  if (_positionLeft < 0 + _dockBoundary()) {
                    _positionLeft = 0 + _dockBoundary();
                  }
                  if (_positionLeft >
                      (_pageWidth - _widgetSize) - _dockBoundary()) {
                    _positionLeft =
                        (_pageWidth - _widgetSize) - _dockBoundary();
                  }
                });
              },
              onTap: () {
                setState(() {
                  _movementSpeed = widget.panelAnimDuration ?? 200;

                  if (widget.panelState == PanelState.open) {
                    widget.panelState = PanelState.closed;
                    _forceDock();
                  } else {
                    widget.panelState = PanelState.open;
                    _positionLeft = _openDockLeft();
                    _calcPanelTop();
                  }
                });
              },
              child: _FloatButton(
                size: widget.size ?? 70.0,
                svgPath: widget.panelIconPath,
                // Changed to SVG path
                color: widget.contentColor ?? Colors.white,
                iconSize: widget.iconSize ?? 36.0,
                button: false,
              ),
            ),
            AnimatedOpacity(
              opacity: widget.panelState == PanelState.open ? 1.0 : 0.0,
              duration: widget.panelState == PanelState.open
                  ? Duration(milliseconds: 250)
                  : Duration(milliseconds: 10),
              child: Container(
                child: Column(
                  children: List.generate(
                    _buttons.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onPressed(index);
                          setState(() {
                            _movementSpeed = widget.panelAnimDuration ?? 200;

                            if (widget.panelState == PanelState.open) {
                              widget.panelState = PanelState.closed;
                              _forceDock();
                            } else {
                              widget.panelState = PanelState.open;
                              _positionLeft = _openDockLeft();
                              _calcPanelTop();
                            }
                          });
                        },
                        child: _FloatButton(
                          size: widget.size ?? 70.0,
                          svgPath: _buttons[index],
                          // Changed to SVG path
                          color: widget.contentColor ?? Colors.white,
                          iconSize: widget.iconSize ?? 24.0,
                          button: true,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatButton extends StatelessWidget {
  final double? size;
  final Color? color;
  final String? svgPath; // Changed from IconData to String for SVG path
  final double? iconSize;
  final bool? button;

  const _FloatButton(
      {this.size, this.color, this.svgPath, this.iconSize, this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size ?? 70.0,
        height: size ?? 70.0,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: svgPath != null
              ? Padding(
            padding: EdgeInsets.all(
                button == false ? AppDimens.paddingMedium : 20),
            child: SvgPicture.asset(
              svgPath!,
              width: iconSize ?? 24.0,
              height: iconSize ?? 24.0,
              color: Colors.white,
            ),
          )
              : Icon(
            Icons.settings,
            color: color ?? Colors.white,
            size: iconSize ?? 24.0,
          ),
        ));
  }
}
