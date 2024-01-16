import 'package:alemeno/Widgets/TestWidget.dart';
import 'package:alemeno/modules/TestItemsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConfirmWidget extends StatelessWidget {
  final String details;
  const OrderConfirmWidget({super.key, required this.details});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Image.asset('assets/images/image.png'),
            Flexible(
                child: Container(
              width: 200,
              child: Text(
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  'Lab tests have been scheduled successfully, You will receive a mail of the same'),
            )),
            SizedBox(height: 30),
            Text(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                details),
            SizedBox(
              height: 100,
            ),
            Container(
                padding: EdgeInsets.all(16.0),
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<TestItemsProvider>(context, listen: false)
                        .eraseSelectedItemsList();
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text('Back to home page',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(6, 33, 125, 1),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
