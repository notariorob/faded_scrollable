import 'dart:math';

import 'package:flutter/material.dart';

const kScrollRatioStart = 0.0;
const kScrollRatioEnd = 1.0;
const kMaxScreenRatioFade = 0.175;
const kMinScreenRatioFade = 0.05;
const kFadeColor = Colors.white;

class _GradientConfig {
  const _GradientConfig(this.stops, this.colors);

  final List<double> stops;
  final List<Color> colors;
}

class FadedScrollable extends StatefulWidget {
  const FadedScrollable({
    super.key,
    required this.child,
    this.scrollRatioStart = kScrollRatioStart,
    this.scrollRatioEnd = kScrollRatioEnd,
    this.minTopScreenRatioFade = kMinScreenRatioFade,
    this.maxTopScreenRatioFade = kMaxScreenRatioFade,
    this.minBottomScreenRatioFade = kMinScreenRatioFade,
    this.maxBottomScreenRatioFade = kMaxScreenRatioFade,
    this.proportionalFade = true,
  })  : assert(
          scrollRatioStart >= 0 && scrollRatioStart <= 1,
          'scrollRatioStart must be between 0 and 1',
        ),
        assert(
          scrollRatioEnd >= 0 && scrollRatioEnd <= 1,
          'scrollRatioEnd must be between 0 and 1',
        ),
        assert(
          minTopScreenRatioFade >= 0 && minTopScreenRatioFade <= 1,
          'minTopScreenRatioFade must be between 0 and 1',
        ),
        assert(
          maxTopScreenRatioFade >= 0 && maxTopScreenRatioFade <= 1,
          'maxTopScreenRatioFade must be between 0 and 1',
        ),
        assert(
          minBottomScreenRatioFade >= 0 && minBottomScreenRatioFade <= 1,
          'minBottomScreenRatioFade must be between 0 and 1',
        ),
        assert(
          maxBottomScreenRatioFade >= 0 && maxBottomScreenRatioFade <= 1,
          'maxBottomScreenRatioFade must be between 0 and 1',
        ),
        assert(
          minTopScreenRatioFade <= maxTopScreenRatioFade,
          'minTopScreenRatioFade must be less than or equal to maxTopScreenRatioFade',
        ),
        assert(
          minBottomScreenRatioFade <= maxBottomScreenRatioFade,
          'minBottomScreenRatioFade must be less than or equal to maxBottomScreenRatioFade',
        );

  /// The widget that will be faded at the top and bottom. Either this widget or some of its children should be scrollable.
  final Widget child;

  /// Scroll ratio greater than this will cause top fade to appear.
  ///
  /// Defaults to 0.0.
  final double scrollRatioStart;

  /// Scroll ratio lower than this will cause top fade to appear
  ///
  /// Defaults to 1.0.
  final double scrollRatioEnd;

  /// Minimum proportion of the screen that should be faded from the top of the screen.
  ///
  /// Defaults to 0.05.
  final double minTopScreenRatioFade;

  /// Maximum proportion of the screen that should be faded from the top of the screen. A value of 0 means no fade.
  ///
  /// Defaults to 0.175.
  final double maxTopScreenRatioFade;

  /// Minimum proportion of the screen that should be faded from the bottom of the screen. A value of 0 means no fade.
  ///
  /// Defaults to 0.05.
  final double minBottomScreenRatioFade;

  /// Maximum proportion of the screen that should be faded from the bottom of the screen. A value of 0 means no fade.
  ///
  /// Defaults to 0.175.
  final double maxBottomScreenRatioFade;

  /// Whether the fade amount should be proportional to the scroll ratio
  ///
  /// Defaults to true.
  final bool proportionalFade;

  @override
  State<FadedScrollable> createState() => _FadedScrollableState();
}

class _FadedScrollableState extends State<FadedScrollable> {
  double scrollRatio = 0;

  _GradientConfig _getGradientConfig() {
    final double upperStop = widget.maxTopScreenRatioFade;
    final double lowerStop = 1 - widget.maxBottomScreenRatioFade;

    final bool shouldFadeTop = scrollRatio > widget.scrollRatioStart;
    final bool shouldFadeBottom = scrollRatio < widget.scrollRatioEnd;
    final List<double> stops = [];
    final List<Color> colors = [];

    if (shouldFadeTop) {
      stops.add(0);
      colors.add(kFadeColor);

      if (widget.proportionalFade) {
        stops.add(max(widget.minTopScreenRatioFade, upperStop * scrollRatio));
      } else {
        stops.add(upperStop);
      }

      colors.add(Colors.transparent);
    }

    if (shouldFadeBottom) {
      if (widget.proportionalFade) {
        stops.add(
          min(1 - widget.minBottomScreenRatioFade,
              lowerStop + (1 - lowerStop) * scrollRatio),
        );
      } else {
        stops.add(lowerStop);
      }

      colors.add(Colors.transparent);
      stops.add(1.0);
      colors.add(kFadeColor);
    }

    return _GradientConfig(stops, colors);
  }

  @override
  Widget build(BuildContext context) {
    _GradientConfig gradientConfig = _getGradientConfig();

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            scrollRatio = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
          });
        }

        return true;
      },
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientConfig.colors,
            stops: gradientConfig.stops,
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: widget.child,
      ),
    );
  }
}
