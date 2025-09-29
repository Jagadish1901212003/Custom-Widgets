import 'package:custom_widgets/custom_widget/core/floating_buttons_bottom_bar.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:flutter/material.dart';

class AddPidPage extends StatefulWidget {
  final String? initialNumber;
  final String? initialSize;

  const AddPidPage({super.key, this.initialNumber, this.initialSize});

  @override
  State<AddPidPage> createState() => _AddPidPageState();
}

class _AddPidPageState extends State<AddPidPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController numberController;
  late TextEditingController sizeController;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController(text: widget.initialNumber ?? "");
    sizeController = TextEditingController(text: widget.initialSize ?? "");
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "number": numberController.text,
        "size": sizeController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add / Edit PID")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: "PID Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter PID Number" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: sizeController,
                decoration: InputDecoration(
                  labelText: "PID Size (ha)",
                  border: OutlineInputBorder(),
                ),
                // validator: (value) =>
                //     value == null || value.isEmpty ? "Enter PID Size" : null,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              // ElevatedButton(onPressed: _submitForm, child: Text("Submit")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonsBottomBar(
        cancelButtonType: ButtonType.close,
        buttonType: ButtonType.submit,
        onSave: () async {
          _submitForm();
        },

        isSaveEnable: true,
      ),
    );
  }
}
