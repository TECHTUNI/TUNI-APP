import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni_web/provider/navigation_provider.dart';
import 'package:tuni_web/provider/product_provider.dart';
import 'package:tuni_web/screens/Dashboard/dashboard.dart';
import 'package:tuni_web/screens/Products/products.dart';
import 'package:tuni_web/screens/Settings/settings.dart';

import 'orders/orders.dart';

class SideNavPage extends StatefulWidget {
  const SideNavPage({super.key});

  @override
  State<SideNavPage> createState() => _SideNavPageState();
}

class _SideNavPageState extends State<SideNavPage> {
  final color = Colors.grey.shade800;
  List<Widget> pages = [
    const DashBoardPage(),
    const ProductsPage(),
    // CustomersPage(),
    MessagesPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<NavigationProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(children: [
        Container(
          height: screenHeight,
          color: color,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * .08,
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'SHAK ADMIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ),
              Expanded(
                child: Consumer<NavigationProvider>(
                  builder: (BuildContext context, nav, Widget? child) {
                    return NavigationRail(
                      onDestinationSelected: (index) {
                        nav.onTabChange(index);
                      },
                      backgroundColor: color,
                      selectedIconTheme:
                          const IconThemeData(color: Colors.black),
                      selectedLabelTextStyle:
                          const TextStyle(color: Colors.black),
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.white),
                      unselectedLabelTextStyle:
                          const TextStyle(color: Colors.white),
                      labelType: NavigationRailLabelType.all,
                      minWidth: 100,
                      // leading: ,
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(Icons.dashboard),
                            label: Text('Dashboard')),
                        NavigationRailDestination(
                            icon: Icon(Icons.propane_outlined),
                            label: Text('Products')),
                        // NavigationRailDestination(
                        //     icon: Icon(Icons.person), label: Text('Customers')),
                        NavigationRailDestination(
                            icon: Icon(Icons.shopping_cart),
                            label: Text('Orders')),
                        // NavigationRailDestination(
                        //     icon: Icon(Icons.settings),
                        //     label: Text('Settings')),
                        NavigationRailDestination(
                            icon: Icon(Icons.dashboard), label: Text('Logout')),
                      ],
                      selectedIndex: nav.currentIndex,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(child: pages[navigation.currentIndex])
      ]),
    );
  }
}
