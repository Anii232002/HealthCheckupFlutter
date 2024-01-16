import 'package:alemeno/Widgets/BookAppointmentWidget.dart';
import 'package:alemeno/Widgets/CartWidget.dart';
import 'package:alemeno/Widgets/OrderConfirmWidget.dart';
import 'package:alemeno/Widgets/TestWidget.dart';
import 'package:alemeno/modules/TestItemsProvider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TestItemsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => TestItemsProvider()), // Replace with your provider
          // Add more providers if needed
        ],
        child: MaterialApp(
          initialRoute: '/home',
          routes: {
            '/home': (context) => MyHomePage(title: ''),
            '/cart': (context) => CartWidget(),
            '/time': (context) => BookAppointmentWidget(),
            '/order': (context) => OrderConfirmWidget(details: ''),
            // Add more routes as needed
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Alemeno'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Consumer<TestItemsProvider>(
                builder: (context, testItemsProvider, child) {
              return Row(
                children: [
                  SizedBox(
                    width: 130,
                  ),
                  Text(
                    'Alemeno',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the tap here
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: badges.Badge(
                      position: badges.BadgePosition.bottomStart(),
                      badgeStyle: badges.BadgeStyle(
                          badgeColor: Color.fromRGBO(22, 194, 213, 1)),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      badgeContent: Text(
                          '${Provider.of<TestItemsProvider>(context, listen: false).selectedItems.length}'),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Popular lab tests',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff10217D),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 100,
                  ),
                  Text('View more')
                ],
              ),
            ),
            Container(height: 600, child: TestWidget()),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Popular packages',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff10217D),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Top Row with Circle Icon and Safe Icon
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.medical_information_rounded,
                              color: Colors.white, size: 50),
                        ),
                        Icon(
                          Icons.safety_check_outlined,
                          color: Colors.green,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Full Body Checkup',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),

                  // Text with Bullets
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Includes 92 tests\n• Blood Glucose Fasting 1\n• Liver Function Test 2',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),

                  // Expandable Text

                  // Bottom Row with Rupee Symbol, Number, and Button
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '\u20B9', // Rupee Symbol
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '2000',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            // alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5, right: 20),

                            child: OutlinedButton(
                              onPressed: () {
                                // Handle upload prescription button press
                              },
                              style: OutlinedButton.styleFrom(
                                  side:
                                      BorderSide(width: 2, color: Colors.black),
                                  fixedSize: Size(130, 20)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
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
