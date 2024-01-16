import 'package:alemeno/modules/TaskItemDataModel/TestItemModel.dart';
import 'package:alemeno/modules/TestItemsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _MyTestWidget();
}

class _MyTestWidget extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    List<TestItemModel> list = [];

    list = generateTestItemsList();
    return Consumer<TestItemsProvider>(
        builder: (context, testItemsProvider, child) {
      return SizedBox(
        height: 30 + 30,
        child: GridView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.67,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return TestItem(test_item: list.elementAt(index), index: index);
          },
        ),
      );
    });
  }

  List<TestItemModel> generateTestItemsList() {
    List<TestItemModel> list = [];
    list.add(TestItemModel(
        title: 'Iron Study Test',
        delivery_time: 24,
        prev_price: 1000,
        price: 600,
        no_of_tests: 4,
        isSelected: false));
    list.add(TestItemModel(
        title: 'Thyroid Profile',
        delivery_time: 24,
        prev_price: 1400,
        price: 1000,
        no_of_tests: 3,
        isSelected: false));
    list.add(TestItemModel(
        title: 'Diabetes Profile',
        delivery_time: 24,
        prev_price: 1600,
        price: 1000,
        no_of_tests: 4,
        isSelected: false));
    list.add(TestItemModel(
        title: 'Iron Study Test',
        delivery_time: 24,
        prev_price: 1000,
        price: 600,
        no_of_tests: 5,
        isSelected: false));
    Provider.of<TestItemsProvider>(context, listen: false).setList(list);

    return list;
  }
}

class TestItem extends StatefulWidget {
  const TestItem({super.key, required this.test_item, required this.index});

  final TestItemModel test_item;
  final int index;
  @override
  State<TestItem> createState() => _MyTestItem(test_item, index);
}

class _MyTestItem extends State<TestItem> {
  final TestItemModel test_item;
  final int index;

  _MyTestItem(this.test_item, this.index);

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;
    if (this.test_item.isSelected) {
      text = 'Added to cart';
      color = const Color.fromRGBO(22, 194, 213, 1);
    } else {
      text = 'Add to cart';
      color = const Color.fromRGBO(16, 33, 125, 1);
    }
    return Container(
      child: Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color.fromRGBO(16, 33, 125, 0.8),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  test_item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Includes ${this.test_item.no_of_tests} tests',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.health_and_safety,
                              color: Color.fromRGBO(22, 194, 213, 1), size: 25),
                          // Icon(Icons.favorite, color: Colors.red, size: 15),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Get reports in ${test_item.delivery_time} hours',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '\u20B9 ${test_item.price}',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '\u20B9 ${test_item.prev_price}',
                            style: TextStyle(
                              fontSize: 10.0,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        Provider.of<TestItemsProvider>(context, listen: false)
                            .toggleSelection(this.index);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: color,
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
