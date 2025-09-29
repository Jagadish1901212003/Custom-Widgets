import 'dart:typed_data';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/app_constants.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:custom_widgets/custom_widget/core/buttons_widget.dart';
import 'package:flutter/material.dart';

class PopUpDialogUtility {
  static Future<String?> showAlertDialogSystem({
    required BuildContext context,
    required String popupTitle,
    required String description,
    String? image,
    String? okButtonText,
    String? cancelButtonText,
    Future<void> Function()? buttonCallback,
  }) async {
    return await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0),
              actionsPadding: EdgeInsets.all(0),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * (0.5),
                // height: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info,
                                color: AppColors.appPrimaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                popupTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: AppFonts.RakutenSans,
                                  color: AppColors.appPrimaryTextColor,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, right: 8),
                              child: Icon(
                                Icons.close,
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.appPrimaryColor),
                    if (image != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                            ),
                            child: Image.asset(
                              'assets/images/$image',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 8,
                        right: 8,
                        bottom: 10,
                      ),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.appSecondaryTextColor,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Divider(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWidget.buttonElevated(
                        buttonSize: const Size(80, 35),
                        buttonCallback: () async {
                          Navigator.of(context).pop();
                          if (buttonCallback != null) {
                            await buttonCallback();
                          } else {
                            () {};
                          }
                        },
                        lable: "Ok",
                        buttonColor: AppColors.appPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<String?> showAlertDialog({
    required BuildContext context,
    required String popupTitle,
    required String description,
    String? image,
    String? okButtonText,
    String? cancelButtonText,
    Future<void> Function()? buttonCallback,
    Future<void> Function()? cancelCallback,
  }) async {
    return await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * (0.5),
                // height: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info,
                                color: AppColors.appPrimaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                popupTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: AppFonts.RakutenSans,
                                  color: AppColors.appPrimaryTextColor,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, left: 8),
                              child: Icon(
                                Icons.close,
                                color: AppColors.appPrimaryColor,
                              ),
                              //)
                              // Image.asset(
                              //   "assets/images/ic_close_blue.png",
                              //   width: 18,
                              //   height: 18,
                              //   color: AppColors.appPrimaryColor,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (image != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                            ),
                            child: Image.asset(
                              'assets/images/$image',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 8,
                        right: 8,
                        bottom: 20,
                      ),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.appSecondaryTextColor,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget.buttonElevated(
                      buttonSize: const Size(100, 40),
                      buttonCallback: () async {
                        Navigator.of(context).pop();
                        if (buttonCallback != null) {
                          await buttonCallback();
                        } else {
                          () {};
                        }
                      },
                      lable: okButtonText ?? "Yes",
                      buttonColor: AppColors.appPrimaryColor,
                    ),
                    ButtonWidget.buttonOutline(
                      buttonSize: const Size(100, 40),
                      lable: cancelButtonText ?? "No",
                      buttonCallback: () async {
                        Navigator.of(context).pop();
                        if (cancelCallback != null) {
                          await cancelCallback();
                        } else {
                          () {};
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<String?> showAlertDialogWithTextFiled({
    required BuildContext context,
    required TextEditingController controller,
    Future<void> Function()? buttonCallback,
    // required void Function(dynamic) onChange,
  }) async {
    return await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * (0.5),
                // height: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: AppColors.appPrimaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Confirmation",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: AppFonts.RakutenSans,
                                  color: AppColors.appPrimaryTextColor,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, left: 8),
                              child: Icon(
                                Icons.close,
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 8,
                        right: 8,
                        bottom: 8,
                      ),
                      child: Text(
                        "Are you sure you want to save?",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.appSecondaryTextColor,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 8,
                        right: 8,
                        bottom: 20,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller,
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          fillColor: AppColors.appBorderColor.withValues(
                            alpha: 0.4,
                          ),
                          hintText: "Draft Name (required)",
                          hintStyle: StyleUtility.hintTextStyle,
                          counterStyle: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.appBorderColor.withValues(
                              alpha: 0.4,
                            ),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppColors.appBorderColor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppColors.appBorderColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appBorderColor,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget.buttonElevated(
                      buttonSize: const Size(100, 40),
                      buttonCallback: () async {
                        if (controller.text.trim().isEmpty) {
                          return;
                        }
                        Navigator.of(context).pop();

                        if (buttonCallback != null) {
                          await buttonCallback();
                        } else {
                          () {};
                        }
                      },
                      lable: "Submit",
                      buttonColor:
                          controller.text.trim().isNotEmpty
                              ? AppColors.appPrimaryColor
                              : AppColors.appLightPrimaryColor,
                    ),
                    ButtonWidget.buttonOutline(
                      buttonSize: const Size(100, 40),
                      lable: "Cancel",
                      buttonCallback: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<String?> showAttachPreviewDialog({
    required BuildContext context,
    required String filename,
    Uint8List? imageBytes,
    Widget? docThumbnailIcon,
    required void Function() buttonCallback,
    bool? isVisibleDelete = false,
  }) async {
    return await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(5),
          content: SingleChildScrollView(
            // ✅ Added scroll view
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height *
                    0.8, // prevent overflow
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: FittedBox(
                              child: Text(
                                filename,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  decoration: TextDecoration.underline,
                                  color: AppColors.appPrimaryColor,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    if (imageBytes != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.contain,
                          height: 400, // Optional max height
                        ),
                      ),
                    if (docThumbnailIcon != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: docThumbnailIcon,
                            ),
                            const Positioned(
                              child: Text(
                                "No preview available",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColors.appBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isVisibleDelete == true)
                      IconButton(
                        onPressed: () {
                          showAlertDialog(
                            context: context,
                            popupTitle: 'Confirmation',
                            description: AppString.deleteConfirmText,
                            buttonCallback: () async {
                              Navigator.of(context).pop();
                              buttonCallback();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.appErrorRed,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<String?> showInstructionDialogMain(
    BuildContext context, {
    String? popupTitle,
    String? description,
  }) async {
    return await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titlePadding: const EdgeInsets.all(0.0),
          // contentPadding:
          //     const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 40,
          ),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,

          buttonPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.only(right: 10, bottom: 5),

          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 0,
                    right: 0,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.info, color: AppColors.appPrimaryColor),
                      const SizedBox(width: 10),
                      Text(
                        popupTitle ?? "Instructions",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          //fontFamily: AppFonts.RakutenSans,
                          color: AppColors.appPrimaryTextColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0, color: AppColors.appLightPrimaryColor),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "General Instructions for Entering an Incident in Sodales\n\n",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''This instruction section contains general system use information and guidance for employees reporting an incident in Sodales. For specific instruction on the function of an entry screen, please refer to the reference materials for use of this system on Hello 1GX.Additionally, in-system guidance is provided in the help text pop-ups for many fields throughout Sodales. If you are unsure what to enter, review the help-text for that field and/or the reference materials on Hello 1GX. If you are still unsure, contact your OHS Consultant for assistance.\n\n''',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "NOTE:",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''While there are a number of notifications that will happen from Sodales, there is still an expectation that direct communication with your supervisor and/or manager is happening. Please refer to Element 6 of the OHS Program for more information on this.\n\n''',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "General Guidance\n",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''From the drop-down list at the top of the screen, select the appropriate type(s) of OHS incident that you are reporting. Please select all that apply and complete each tab as fully as possible. Note that if you are reporting a Near Miss or Hazard ID inspection type, you will not be able to select any other inspection types without first unselecting the Near Miss or Hazard ID option.If you are entering an incident on behalf of someone else, select that option at the top of the Incident Details tab. You can then record the name of the person you are entering on behalf of as the “Reporting Person.” Your name will be automatically recorded as the person entering the incident.

The Incident Details tab is required for all inspection types; however, depending on the type(s) of incident you have selected, additional information may be required on other tabs. Please ensure the completion of all required fields for the inspection type(s) you have selected before submitting your incident report.

You may save a draft of the report without submitting it by clicking the “Draft” button. You are encouraged to submit an incident report as soon as possible following an incident. Data entry has been minimized as much as possible by pulling from SuccessFactors and Holman to auto-populate additional information fields from what is currently in the GoA’s master data. In addition, data entered on the Incident Details will be carried forward to other pages when needed (e.g., names of injured people). If the information populated from SuccessFactors is incorrect, please talk to your HRBP for assistance in correcting it. If the vehicle information is incorrect, contact Fleet Management.

Information entered in the Incident Details tab is required for the use of two of the inspection type tabs:

A driver / operator must be identified in the People section to access the entry fields in Motor Vehicle / Mobile Equipment.
At least one affected / injured person must be identified in the People section to access the entry fields in Workplace Injury / Illnesses. Each person identified will have a separate tab in Workplace Injury / Illness to enter their injury and/or illness details.\n\n''',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "NOTE: ",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''For damage to parked GoA vehicles resulting from an environmental or third-party cause (fire, flood, vandalism, etc.) where there is no driver to identify, use Property Damage rather than Motor Vehicle / Mobile Equipment as the inspection type. This will capture the required information without requiring irrelevant details such as driving conditions.

SuccessFactors isn’t always current when identifying your current supervisor. The field “Supervisor at time of incident” can be used to enter your current supervisor. It will default to what is currently in 1GX and can be overwritten when needed. The person identified in this field will receive a notification to complete the initial incident review and, in most cases, the investigation of the incident. Your supervisor and managers listed in 1GX will also have access to the incident report details, as will your OHS Consultant.\n\n''',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "NOTE: ",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''The system will not allow you to enter yourself as your own supervisor.\n\n''',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "Do NOT ",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''enter reports of employee-to-employee harassment or violence into Sodales. These are reported under the Respectful Workplace Policy (RWP), which has a separate process for making and investigating these complaints. Information on the correct reporting process is located on MyAPS. Please note that any RWP complaints that have been entered in error as OHS incidents will be set to “Archived” status immediately upon detection, removing them from reporting and making any reported information accessible only to OHS Consultants.

If you identify that an incident is security related, a notification will automatically be sent to the Provincial Security and Intelligence Office (PSIO) or Crown Prosecution Security when you submit the report. Further communication with PSIO or your department security resources may be required outside of Sodales.

When an employee is identified as a First Aider in the People section, they will receive a notification to complete a First Aid Report (available from the GoA OHS SharePoint site) and submit it to the reporting employee’s supervisor at the time of the incident. That supervisor will upload it to the incident file as an attachment. You may request a copy of that report from your supervisor at any time. You can access the information you have entered into Sodales through the Incident Portal. In addition, the fields where you enter your description of the incident or hazard, as well as the steps you took after the incident to make the site safe, will not be editable by anyone after you submit your incident report.

You may upload photos, other documentation, audio recordings, and/or videos related to the incident in the Attachments tab.

You can view all of the incidents you have reported in the system from the “Incidents” dashboard on the main screen (rather than clicking on Report Incident which brought you to the screen where you found this instruction box).

Again, if you have any questions about the use of the system that are not answered through the in-system help or the resources on Hello 1GX, please reach out to your OHS Consultant.\n''',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.appBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.appBlack,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget.buttonElevated(
                  buttonSize: const Size(80, 35),
                  buttonCallback: () async {
                    Navigator.of(context).pop();
                  },
                  lable: "Close",
                  buttonColor: AppColors.appPrimaryColor,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<String?> showInstructionDialog2(
    BuildContext context, {
    String? popupTitle,
    required String description,
  }) async {
    return await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titlePadding: const EdgeInsets.all(0.0),
          // contentPadding:
          //     const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 40,
          ),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,

          buttonPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.only(right: 10, bottom: 5),

          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 0,
                    right: 0,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.info, color: AppColors.appPrimaryColor),
                      const SizedBox(width: 10),
                      Text(
                        popupTitle ?? "Instruction",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          //fontFamily: AppFonts.RakutenSans,
                          color: AppColors.appPrimaryTextColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0, color: AppColors.appLightPrimaryColor),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.appBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget.buttonElevated(
                  buttonSize: const Size(80, 35),
                  buttonCallback: () async {
                    Navigator.of(context).pop();
                  },
                  lable: "Ok",
                  buttonColor: AppColors.appPrimaryColor,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<void> showLaodingPopup(
    BuildContext context, {
    String? loadingText,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const CircularProgressIndicator(
                  color: AppColors.appPrimaryColor,
                ),
                const SizedBox(width: 30),
                Text(
                  loadingText ?? "Loading...",
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    color: AppColors.appBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  static hideLoadingPopup(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showSuccessDialog({
    required BuildContext context,
    required String incidentNumber,
    VoidCallback? onDismiss,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (BuildContext context) => PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: const EdgeInsets.only(top: 20),
              contentPadding: EdgeInsets.all(0),
              actionsPadding: const EdgeInsets.only(bottom: 2),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 5,
                      right: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Success",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.green),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.appGreen, width: 5),
                      color: AppColors.appWhite,
                    ),
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.appGreen,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 40,
                          color: AppColors.appWhite,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Incident submitted successfully.",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Incident Number: $incidentNumber",
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              actions: [
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ButtonWidget.buttonElevated(
                        margin: EdgeInsets.all(0),
                        buttonSize: const Size(80, 35),
                        buttonCallback: () async {
                          Navigator.of(context).pop();
                          if (onDismiss != null) onDismiss();
                        },
                        lable: "OK",
                        buttonColor: AppColors.appPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
