import 'package:cap_navigation_bar/state/navigation_key_notifier.dart';
import 'package:cap_navigation_bar/views/componants/selected_item_painter.dart';
import 'package:flutter/material.dart';

class CapNavigationBar extends StatefulWidget {
  final int index;
  final List<Widget> items;
  final ValueChanged<int>? onTap;
  final Color? capColor;
  final Color? color;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final double? capWidth;
  final double? capHeight;
  CapNavigationBar({
    required this.items,
    this.index = 0,
    this.capColor,
    this.color,
    this.onTap,
    this.capWidth,
    this.capHeight,
    this.animationCurve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 300),
    this.height = 75.0,
  })  : assert(items.isNotEmpty && items.length > 1,
            'Items sould at least have two children'),
        assert(
            index < items.length && index >= 0, 'Initial index out of range'),
        super(
          key: CapNavigationKeyNotifier().value,
        );
  @override
  State<StatefulWidget> createState() => CapNavigationBarState();
}

class CapNavigationBarState extends State<CapNavigationBar> {
  bool isIndexChanging = false;
  late int itemIndex;
  @override
  void initState() {
    super.initState();
    itemIndex = widget.index;
  }

  @override
  void didUpdateWidget(covariant CapNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      isIndexChanging = true;
      Future.delayed(
        widget.animationDuration - const Duration(milliseconds: 100),
      ).then(
        (_) => itemIndex = widget.index,
      );

      Future.delayed(widget.animationDuration).then(
        (_) => isIndexChanging = false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / widget.items.length;

    final double wantedWidth =
        widget.capWidth ?? itemWidth * widget.items.length / 1.7;
    final double currentWidth = itemWidth * widget.items.length;
    final double newWidth = currentWidth + (wantedWidth - itemWidth);
    final double difference = (newWidth - currentWidth) / 2;
    final double newPosition = itemWidth * itemIndex - difference;

    return Container(
      height: widget.height,
      color: widget.color ?? Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          AnimatedPositioned(
            left: newPosition,
            top: !isIndexChanging ? -16 : widget.height - 10,
            bottom:
                widget.capHeight != null ? -widget.capHeight! : -widget.height,
            width: wantedWidth,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              width: itemWidth,
              curve: widget.animationCurve,
              child: CustomPaint(
                painter: SelectedItemCustomPainter(
                  color: widget.capColor ?? Theme.of(context).indicatorColor,
                ),
              ),
            ),
          ),
          Row(
            children: widget.items.asMap().entries.map((entry) {
              final entryIndex = entry.key;
              final item = entry.value;
              final isActive = entryIndex == itemIndex;
              return GestureDetector(
                onTap: () async {
                  await navigateTo(entryIndex);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  width: itemWidth,
                  height: widget.height,
                  transform: Matrix4.translationValues(
                      0, (isIndexChanging && isActive) ? widget.height : 0, 0),
                  child: item,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> navigateTo(int index) async {
    if (index != itemIndex) {
      if (widget.onTap != null) {
        widget.onTap!(index);
      }
      setState(() {
        isIndexChanging = true;
      });
      await Future.delayed(
          widget.animationDuration - const Duration(milliseconds: 100));
      setState(() {
        itemIndex = index;
      });

      await Future.delayed(widget.animationDuration);
      setState(() {
        isIndexChanging = false;
      });
    }
  }

  void setPage(int page) async {
    assert(
      page < widget.items.length && page >= 0,
      'Initial index out of range',
    );
    await navigateTo(page);
  }
}
