import 'package:flutter/material.dart';

class ViewSwitcher extends StatefulWidget {
  @override
  _ViewSwitcherState createState() => _ViewSwitcherState();
}

class _ViewSwitcherState extends State<ViewSwitcher> {
  bool isGrid = true;

  final List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Switcher'),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          )
        ],
      ),
      body: isGrid ? buildGridView() : buildListView(),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // or make it dynamic
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => Card(
        child: Center(child: Text(items[index])),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(items[index]),
        ),
      ),
    );
  }
}
