import 'package:flutter/material.dart';
class CreateC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DatePickerPage(),
    );
  }
}

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  late DateTime _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedDate != null
                ? Text(
                    'Selected Date: ${_selectedDate.toString()}',
                    style: TextStyle(fontSize: 18),
                  )
                : Text(
                    'No date selected',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}
