import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';

class Validation {
  static final incidentDetailsFormKey = GlobalKey<FormState>();
  static final nearMissFormKey = GlobalKey<FormState>();

  //VALIDATE INCCIDENT DETAILS
  static bool validateIncidentDetailTab(BuildContext context) {
    bool isValid = false;
    if (incidentDetailsFormKey.currentState!.validate()) {
      print("IncidentDetailTab Success.........");
      isValid = true;
    } else {
      PopUpDialogUtility.showAlertDialogSystem(
        context: context,
        popupTitle: 'Warning',
        description:
            "Please fill all the mandatory fields in Incident Details tab",
      );
    }
    return isValid;
  }

  static bool validateNearMissTab(BuildContext context) {
    bool isValid = false;

    if (nearMissFormKey.currentState!.validate()) {
      print("Near Miss Form validated");
      isValid = true;
    } else {
      print("Near Miss Form Not validated");
      PopUpDialogUtility.showAlertDialogSystem(
        context: context,
        popupTitle: 'Warning',
        description: "Please fill all the mandatory fields in Near Miss tab.",
      );
    }
    return isValid;
  }
}
