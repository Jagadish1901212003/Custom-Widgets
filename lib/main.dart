import 'package:custom_widgets/custom_widget/core/border_container_widget.dart';
import 'package:custom_widgets/custom_widget/core/card_data_row.dart';
import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:custom_widgets/custom_widget/core/date_time_field_widget.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/global_tabs.dart';
import 'package:flutter/material.dart';
import 'package:custom_widgets/custom_widget/core/buttons_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateOfEventController = TextEditingController();
  final TextEditingController _timeOfEventController = TextEditingController();
  final GlobalState _globalState = GlobalState();
  String _reportedTime = "";
  DateTime now = DateTime.now();

  @override
  void initState() {
    _reportedTime = DateFormat('HH:mm:ss').format(now);
    print("basic details expansion init calling:::::::");
    //set default reported date and time
    _globalState.incidentDetails.basicDetailsModel?.dateOfIncReported =
        DateFormat('yyyy-MM-dd').format(now);
    _globalState.incidentDetails.basicDetailsModel?.timeOfIncReported =
        DateFormat('HH:mm:ss').format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Add Attachment",
        clearBtnVisible: false,
        onClear: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget),
          );
        },
      ),
      body: Column(
        children: [
          BorderContainerWidget(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            children: [
              Container(color: Colors.red, height: 40, width: 40),
              SizedBox(height: 20),
              Container(height: 40, width: 40, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
