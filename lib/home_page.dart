import 'package:flutter/material.dart';
import 'controllers/home_controller.dart';
import 'screens/done_screen.dart';
import 'screens/task_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = HomeController();
  var _selectedIndex = 0;
  final _pageViewController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          TaskScreen(
            itemList: homeController.toDoItemList,
            onAddItem: homeController.onAddItem,
            onCompleteItem: homeController.onCompleteItem,
            onRemoveItem: homeController.onRemoveToDoItem,
          ),
          DoneScreen(
            itemList: homeController.doneItemList,
            onRemoveItem: homeController.onRemoveDoneItem,
            onResetItem: homeController.onResetItem,
          ),
        ],
        onPageChanged: (index) {
          _selectedIndex = index;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          _pageViewController.animateToPage(
            _selectedIndex,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Concluídas',
          ),
        ],
      ),
    );
  }
}
