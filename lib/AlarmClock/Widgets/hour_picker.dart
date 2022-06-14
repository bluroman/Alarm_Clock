import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  const HourPicker({Key? key, required this.callback}) : super(key: key);
  final Function(int hour, int minutes, int time) callback;
  @override
  State<HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  int selectedHour = 0;
  int selectedMinute = 0;
  int selectedTime = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: 240,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 6, 13, 26),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 24),
                      blurRadius: 23)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Row(
                children: [
                  Expanded(
                    child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: PageController(
                            initialPage: 0, viewportFraction: 0.35),
                        onPageChanged: (index) {
                          setState(() {
                            selectedHour = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: selectedHour == index ? 40 : 30,
                              child: Text(
                                index < 9
                                    ? '0' + (index + 1).toString()
                                    : (index + 1).toString(),
                                style: TextStyle(
                                    color: selectedHour == index
                                        ? Colors.white
                                        : Colors.grey[800],
                                    fontSize: selectedHour == index ? 18 : 14,
                                    fontWeight: selectedHour == index
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          );
                        },
                        itemCount: 12),
                  ),
                  const Text(
                    ':',
                    style: TextStyle(color: Colors.blue, fontSize: 28),
                  ),
                  Expanded(
                    child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: PageController(
                            initialPage: 0, viewportFraction: 0.35),
                        onPageChanged: (index) {
                          setState(() {
                            selectedMinute = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: selectedMinute == index ? 40 : 30,
                              child: Text(
                                index < 10
                                    ? '0' + (index).toString()
                                    : (index).toString(),
                                style: TextStyle(
                                    color: selectedMinute == index
                                        ? Colors.white
                                        : Colors.grey[800],
                                    fontSize: selectedMinute == index ? 18 : 14,
                                    fontWeight: selectedMinute == index
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          );
                        },
                        itemCount: 60),
                  ),
                  Expanded(
                    child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: PageController(
                            initialPage: 0, viewportFraction: 0.35),
                        onPageChanged: (index) {
                          setState(() {
                            selectedTime = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: selectedTime == index ? 40 : 30,
                              child: Text(
                                index == 0 ? 'Am' : 'Pm',
                                style: TextStyle(
                                    color: selectedTime == index
                                        ? Colors.white
                                        : Colors.grey[800],
                                    fontSize: selectedTime == index ? 18 : 14,
                                    fontWeight: selectedTime == index
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          );
                        },
                        itemCount: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 12),
                  blurRadius: 14)
            ],
          ),
          child: RawMaterialButton(
            onPressed: () {
              widget.callback(selectedHour, selectedMinute, selectedTime);
            },
            fillColor: Colors.blue,
            constraints: const BoxConstraints.expand(height: 50, width: 120),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'Set',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
          ),
        )
      ],
    );
  }
}
