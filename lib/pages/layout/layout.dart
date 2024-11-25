import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipad_dashboard/core/assets.dart';
import 'package:ipad_dashboard/pages/screens/home_mail/home_screen.dart';
import 'package:ipad_dashboard/pages/screens/noftification/notification.dart';
import 'package:ipad_dashboard/pages/screens/package/package.dart';
import 'package:ipad_dashboard/pages/screens/product/product_screen.dart';
import 'package:ipad_dashboard/pages/screens/product_category/product_category_screen.dart';
import 'package:ipad_dashboard/pages/screens/settings/settings.dart';
import 'package:ipad_dashboard/pages/screens/ship/ship.dart';
import 'package:ipad_dashboard/pages/screens/users/user_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  final Color primaryPurple = const Color(0xFF6366F1);
  final Color dividerColor = const Color(0xFFE5E7EB);

  final List<MenuOption> menuItems = [
    MenuOption(
      title: "Dashboard",
      icon: Icons.grid_view_rounded,
      isHeader: false,
    ),
    MenuOption(
      title: "Doanh thu Mall",
      icon: Icons.storefront_outlined,
      isHeader: false,
    ),
    MenuOption(
      title: "Sản phẩm",
      icon: Icons.inventory_2_outlined,
      isHeader: false,
    ),
    MenuOption(
      title: "Users",
      icon: Icons.person_outline,
      isHeader: false,
    ),
    MenuOption(
      title: "Package",
      icon: Icons.person_outline,
      isHeader: false,
    ),
    MenuOption(
      title: "Đơn vị vận chuyển",
      icon: Icons.local_shipping_outlined,
      isHeader: false,
      hasDivider: true,
    ),
    MenuOption(
      title: "Thông báo",
      icon: Icons.notifications_none_outlined,
      isHeader: false,
    ),
    MenuOption(
      title: "Settings",
      icon: Icons.settings_outlined,
      isHeader: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: Scaffold(
        body: Row(
          children: [
            _buildSidebar(),
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isExpanded ? 260 : 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo and toggle button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: dividerColor),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Asset.iconLogo,
                  height: 72,
                  width: 99,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.chevron_left : Icons.chevron_right,
                      color: const Color(0xFF6B7280),
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Menu items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                bool isSelected = _selectedIndex == index;

                Widget listTile = Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: _isExpanded ? 12 : 8,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? primaryPurple.withOpacity(0.08)
                        : Colors.transparent,
                  ),
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      color:
                          isSelected ? primaryPurple : const Color(0xFF6B7280),
                      size: 24,
                    ),
                    title: _isExpanded
                        ? Text(
                            item.title,
                            style: TextStyle(
                              color: isSelected
                                  ? primaryPurple
                                  : const Color(0xFF374151),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          )
                        : null,
                    selected: isSelected,
                    onTap: () => setState(() => _selectedIndex = index),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: _isExpanded ? 16 : 12,
                      vertical: 12,
                    ),
                    horizontalTitleGap: 12,
                  ),
                );

                if (item.hasDivider) {
                  return Column(
                    children: [
                      listTile,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _isExpanded ? 16 : 8,
                          vertical: 8,
                        ),
                        child: Divider(color: dividerColor, height: 1),
                      ),
                    ],
                  );
                }

                return listTile;
              },
            ),
          ),

          // User profile section
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: dividerColor),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(Asset.bgImageAvatar),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          'Johnathan',
                          style: TextStyle(
                            color: const Color(0xFF111827),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: const Color(0xFF6B7280),
                    size: 20,
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(Asset.bgImageAvatar),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          DashboardHome(),
          ProductCategoryScreen(),
          ProductScreen(),
          UserScreen(),
          PackageScreen(),
          ShipScreen(),
          NotificationScreen(),
          SettingsPage(),
        ],
      ),
    );
  }
}

class MenuOption {
  final String title;
  final IconData icon;
  final bool isHeader;
  final bool hasDivider;

  MenuOption({
    required this.title,
    required this.icon,
    required this.isHeader,
    this.hasDivider = false,
  });
}
