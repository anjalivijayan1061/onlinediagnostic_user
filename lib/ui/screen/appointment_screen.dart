import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: const [
            Icon(
              Icons.arrow_back,
              color: Colors.black26,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Appointment",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomButton(
              label: selectedDate != null
                  ? DateFormat('dd MMMM yyyy').format(selectedDate!)
                  : 'Select Date',
              iconData: Icons.date_range,
              color: Colors.grey,
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                );

                if (selectedDate != null) {
                  setState(() {});
                }
              },
            ),

            // CustomButton(
            //   label: selectedDate != null
            //       ? DateFormat('dd MMMM yyyy').format(selectedDate!)
            //       : 'Select Date',
            //   iconData: Icons.date_range,
            //   color: Colors.grey,
            //   onPressed: () async {
            //     selectedTime = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.now(),
            //     );

            //     if (selectedDate != null) {
            //       setState(() {});
            //     }
            //   },
            // ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                  width: 1,
                  color: Colors.grey,
                )),
                child: DropdownButton(
                  value: selectedTime,
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Time Slots',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "8 AM to 10 AM",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      value: "8 AM to 10 AM",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "10 AM to 12 PM",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      value: "10 AM to 12 PM",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "12 PM to 4 PM",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      value: "12 PM to 4 PM",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "4 PM to 8 PM",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      value: "4 PM to 8 PM",
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "8 PM to 10 PM",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      value: "8 PM to 10 PM",
                    ),
                  ],
                  onChanged: (value) {
                    selectedTime = value;
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 550,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
