import 'package:alemeno/modules/TestItemsProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentWidget extends StatefulWidget {
  @override
  _BookAppointmentWidgetState createState() => _BookAppointmentWidgetState();
}

class _BookAppointmentWidgetState extends State<BookAppointmentWidget> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  int selectedIndex = -1;
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, '');
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.utc(2024, 1, 1),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  print(selectedDay);
                  print(focusedDay);
                  selectedDate = selectedDay;
                  focusedDay = focusedDay;
                });
              },
            ),

            SizedBox(height: 16.0),

            // SizedBox(height: 16.0),
            // Text('Selected Date: ${selectedDate.toLocal()}'),
            // Text('Selected Time: ${selectedTime.format(context)}'),
            SizedBox(height: 16.0),
            Text('Time Slots:'),
            SizedBox(height: 16.0),
            // Display Time Slots in a 4x3 Grid
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                Color color = Colors.grey;

                int hour = index + 8;
                String timeSlot =
                    '${hour % 12 == 0 ? 12 : hour % 12}:00 ${hour < 12 ? 'AM' : 'PM'}';

                return Container(
                  height: 10,
                  width: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedTime = timeSlot;

                      selectedIndex = index;
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (selectedIndex == index) {
                            return Colors.blue;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                    child: Text(
                      timeSlot,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                padding: EdgeInsets.all(16.0),
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context,
                        ' ${DateFormat('dd/MM/yyyy').format(selectedDate)}  ${selectedTime}');
                  },
                  child: Text('Confirm', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(6, 33, 125, 1),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BookAppointmentWidget(),
  ));
}
