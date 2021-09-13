part of persistent_bottom_nav_bar;

class BottomNavStyle6 extends StatefulWidget {
  final NavBarEssentials? navBarEssentials;

  BottomNavStyle6({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  @override
  _BottomNavStyle6State createState() => _BottomNavStyle6State();
}

class _BottomNavStyle6State extends State<BottomNavStyle6> with TickerProviderStateMixin {
  int? _lastSelectedIndex;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = 0;
    _selectedIndex = 0;
  }

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected, double? height, int itemIndex) {
    return widget.navBarEssentials!.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height,
            child: Container(
              alignment: Alignment.center,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconTheme(
                      data: IconThemeData(
                          size: item.iconSize,
                          color: isSelected
                              ? (item.activeColorSecondary == null
                                  ? item.activeColorPrimary
                                  : item.activeColorSecondary)
                              : item.inactiveColorPrimary == null
                                  ? item.activeColorPrimary
                                  : item.inactiveColorPrimary),
                      child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
                    ),
                  ),
                  item.title == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: FittedBox(
                              child: Text(
                                item.title!,
                                style: item.textStyle != null
                                    ? (item.textStyle!.apply(
                                        color: isSelected
                                            ? (item.activeColorSecondary == null
                                                ? item.activeColorPrimary
                                                : item.activeColorSecondary)
                                            : item.inactiveColorPrimary))
                                    : TextStyle(
                                        color: isSelected
                                            ? (item.activeColorSecondary == null
                                                ? item.activeColorPrimary
                                                : item.activeColorSecondary)
                                            : item.inactiveColorPrimary,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                        fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.navBarEssentials!.selectedIndex != _selectedIndex) {
      _lastSelectedIndex = _selectedIndex;
      _selectedIndex = widget.navBarEssentials!.selectedIndex;
    }
    return Container(
      width: double.infinity,
      height: widget.navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          left: widget.navBarEssentials!.padding?.left ?? MediaQuery.of(context).size.width * 0.04,
          right: widget.navBarEssentials!.padding?.right ?? MediaQuery.of(context).size.width * 0.04,
          top: widget.navBarEssentials!.padding?.top ?? widget.navBarEssentials!.navBarHeight! * 0.15,
          bottom: widget.navBarEssentials!.padding?.bottom ?? widget.navBarEssentials!.navBarHeight! * 0.12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.navBarEssentials!.items!.map((item) {
          int index = widget.navBarEssentials!.items!.indexOf(item);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.navBarEssentials!.items![index].onPressed != null) {
                  widget
                      .navBarEssentials!.items![index].onPressed!(widget.navBarEssentials!.selectedScreenBuildContext);
                } else {
                  if (index != _selectedIndex) {
                    _lastSelectedIndex = _selectedIndex;
                    _selectedIndex = index;
                  }
                  widget.navBarEssentials!.onItemSelected!(index);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: _buildItem(item, widget.navBarEssentials!.selectedIndex == index,
                    widget.navBarEssentials!.navBarHeight, index),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
