import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewSwitcher extends StatefulWidget {
  final bool isGridView;
  final void Function(bool isGridView) onToggle;

  const ViewSwitcher({
    super.key,
    required this.isGridView,
    required this.onToggle,
  });

  @override
  State<ViewSwitcher> createState() => _ViewSwitcherState();
}

class _ViewSwitcherState extends State<ViewSwitcher> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88, // 2 buttons * 40 width + 8 total padding
      height: 36,
      child: Stack(
        children: [
          // Sliding background
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color.fromRGBO(1, 1, 1, .16),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  _buildToggle(
                    type: "grid",
                    iconPath: 'assets/icons/gridview.svg',
                    isSelected: widget.isGridView,
                    onTap: () => widget.onToggle(true),
                  ),
                  _buildToggle(
                    type: "list",
                    iconPath: 'assets/icons/listview.svg',
                    isSelected: !widget.isGridView,
                    onTap: () => widget.onToggle(false),
                  ),
                ],
              ),
            ),
          ),
          // Buttons
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCubic,
            left: widget.isGridView ? 4 : 44, // move background under selected
            top: 4,
            child: Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  _buildToggle(
                    type: "grid",
                    iconPath: 'assets/icons/gridview.svg',
                    isSelected: widget.isGridView,
                    onTap: () => widget.onToggle(true),
                  ),
                  _buildToggle(
                    type: "list",
                    iconPath: 'assets/icons/listview.svg',
                    isSelected: !widget.isGridView,
                    onTap: () => widget.onToggle(false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle({
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
    required String type,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 40,
        height: 28,
        padding: type == "grid" ? EdgeInsets.all(7) : EdgeInsets.all(8),
        child: SvgPicture.asset(
          iconPath,
          height: 12,
          width: 16,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.black : Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
