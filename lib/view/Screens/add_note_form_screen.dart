import 'package:custom_widgets/view/Screens/notes_in_custom_tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:custom_widgets/custom_widget/core/date_time_field_widget.dart';
import 'package:custom_widgets/custom_widget/core/field_label_widget.dart';
import 'package:custom_widgets/custom_widget/core/floating_buttons_bottom_bar.dart';
import 'package:custom_widgets/custom_widget/core/text_area_widget.dart';
import 'package:custom_widgets/utility/enum.dart';

class AddNoteFormScreen extends StatefulWidget {
  final NoteModel? note;

  const AddNoteFormScreen({super.key, this.note});

  @override
  State<AddNoteFormScreen> createState() => _AddNoteFormScreenState();
}

class _AddNoteFormScreenState extends State<AddNoteFormScreen> {
  final TextEditingController _dateOfEventController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();
  // final GlobalState _globalState = GlobalState();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      selectedDate = widget.note!.date;
      _dateOfEventController.text = DateFormat(
        'MMM dd, yyyy',
      ).format(selectedDate!);
      noteController.text = widget.note!.note;
    }
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate() && selectedDate != null) {
      final note = NoteModel(
        date: selectedDate!,
        note: noteController.text.trim(),
      );
      Navigator.pop(context, note);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          // icon: const Icon(Icons.warning, color: Colors.orange),
          // title: const Text("Warning"),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 5),
                  const Text("Warning"),
                  SizedBox(width: 5),
                ],
              ),
              Divider(color: Colors.orange),
            ],
          ),
          content: const Text("Please fill all mandatory details."),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                backgroundColor: Colors.blue,
                // minimumSize: buttonSize ?? const Size(100, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: widget.note == null ? "Add Note" : "Edit Note",
        clearBtnVisible: false,
        onClear: () {},
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FieldLableWidget(
                        padding: EdgeInsets.only(top: 5),
                        lable: "Notes Date",
                        isRequired: true,
                      ),
                      DateTimeFieldWidget(
                        key: Key(DateTime.now().toString()),
                        isRequired: true,
                        selectedDate: selectedDate,
                        dateController: _dateOfEventController,
                        type: DateType.date,
                        onDateSelect: (date) {
                          selectedDate = date;
                          _dateOfEventController.text = DateFormat(
                            'MMM dd, yyyy',
                          ).format(date);
                          setState(() {});
                        },
                      ),
                      // Note
                      TextAreaWidget(
                        showCounterText: true,
                        maxLength: 5000,
                        isRequired: true,
                        hintText: "Maximum character limit is 5000",
                        controller: noteController,
                        lable: "Note",
                        onChange: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButtonsBottomBar(
        cancelButtonType: ButtonType.close,
        buttonType: ButtonType.submit,
        onSave: _handleSave,
        isSaveEnable: true,
      ),
    );
  }
}
