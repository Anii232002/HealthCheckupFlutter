import 'package:alemeno/Widgets/BookAppointmentWidget.dart';
import 'package:alemeno/Widgets/OrderConfirmWidget.dart';
import 'package:alemeno/modules/TaskItemDataModel/TestItemModel.dart';
import 'package:alemeno/modules/TestItemsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _MyCartWidget();
}

class _MyCartWidget extends State<CartWidget> {
  String time_text = 'Select date & time';
  bool isButtonEnabled = false;
  bool? isChecked = false;
  bool showContainer = true;

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 12);
    String mrpTotal = '0', discount = '0', paid_amount = '0', savings = '0';
    if (Provider.of<TestItemsProvider>(context, listen: false)
        .selectedItems
        .isEmpty) {
      showContainer = false;
    } else {
      showContainer = true;
    }

    mrpTotal =
        '${Provider.of<TestItemsProvider>(context, listen: false).mrpTotal}';

    discount =
        '${Provider.of<TestItemsProvider>(context, listen: false).discount}';
    paid_amount =
        '${Provider.of<TestItemsProvider>(context, listen: false).paid_amount}';
    savings =
        '${Provider.of<TestItemsProvider>(context, listen: false).savings}';

    return Consumer<TestItemsProvider>(
        builder: (context, testItemsProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              TestItemsProvider().notifyAll();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Order Review',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: showContainer,
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 100),
                        child: Text(
                          'Pathalogy Tests',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<TestItemsProvider>(
                builder: (context, testItemsProvider, child) {
                  List<TestItemModel> selectedItems =
                      testItemsProvider.selectedItems;
                  if (selectedItems.isEmpty) {
                    showContainer = false;
                  } else {
                    showContainer = true;
                  }

                  return Column(
                    children: selectedItems.map((item) {
                      return Card(
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: Text(item.title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 45),
                                      child: Text('\u20B9 ${item.price}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  27, 169, 181, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 230,
                                  ),
                                  Text(
                                    '\u20B9 ${item.prev_price}',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          testItemsProvider.toggleSelection(
                                              testItemsProvider.testItems
                                                  .indexOf(item));
                                          if (selectedItems.isEmpty) {
                                            setState(() {
                                              showContainer = false;
                                            });
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 2,
                                                color: Color.fromRGBO(
                                                    6, 33, 125, 1)),
                                            fixedSize: Size(150, 20)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete,
                                                color: Color.fromRGBO(
                                                    6, 33, 125, 1)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Remove')
                                          ],
                                        )),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5),
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  6, 33, 125, 1)),
                                          fixedSize: Size(300, 20)),
                                      child: Row(
                                        children: [
                                          Icon(Icons.upload,
                                              color: Color.fromRGBO(
                                                  6, 33, 125, 1)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Upload Prescription (optional)')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              Consumer<TestItemsProvider>(
                  builder: (context, testItemsProvider, child) {
                return Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookAppointmentWidget(),
                          ),
                        );
                        print(data);
                        if (data != null && data != '') {
                          setState(() {
                            time_text = data as String;
                          });

                          if (Provider.of<TestItemsProvider>(context,
                                      listen: false)
                                  .selectedItems
                                  .length !=
                              0) {
                            setState(() {
                              isButtonEnabled = true;
                            });
                          }
                          print('time text is ' + time_text);
                        }
                      },
                      child: Row(children: [
                        Icon(Icons.calendar_today),
                        Text(time_text),
                      ]),
                    ));
              }),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Card(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'MRP Total',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  '\u20B9 ${Provider.of<TestItemsProvider>(context, listen: false).mrpTotal}')
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Discount',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  '\u20B9 ${Provider.of<TestItemsProvider>(context, listen: false).discount}')
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text(
                                'Amount to be paid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(16, 33, 125, 1)),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                  '\u20B9 ${Provider.of<TestItemsProvider>(context, listen: false).paid_amount}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(16, 33, 125, 1)))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Total Savings'),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                '\u20B9 ${Provider.of<TestItemsProvider>(context, listen: false).savings}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Color.fromRGBO(6, 33, 125, 1)),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                // isError: true,
                                // tristate: true,
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Hard copy of Reports',
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched. ₹150 per person',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    '\u20B9 150 per person',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ))),
              Container(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderConfirmWidget(details: time_text),
                            ),
                          );
                        }
                      : null,
                  child:
                      Text('Schedule', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(6, 33, 125, 1),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
