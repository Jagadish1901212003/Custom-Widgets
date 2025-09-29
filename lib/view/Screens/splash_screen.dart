// import 'package:custom_widgets/view/Screens/inspection_checklist_screen.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Navigate to HomeScreen after 3 seconds
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => InspectionChecklistScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: CommonAppBar(title: "Create Inspection", onClear: () {}),
//       body: Container(
//         color: Colors.blue, // Splash screen background color
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.flash_on,
//                 size: 100,
//                 color: Colors.white,
//               ), // Splash icon/logo
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:custom_widgets/custom_widget/core/circular_progress_loading_widget.dart';
import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:custom_widgets/model/users_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/font_utility.dart';
import 'package:custom_widgets/utility/network_connectivity.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/utility/share_preference.dart';
import 'package:custom_widgets/utility/toast_utility.dart';
import 'package:custom_widgets/view/Screens/inspection_checklist_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.appWhite),
        backgroundColor: AppColors.appSecondaryColor,
        centerTitle: true,
        elevation: 0.5,
        title: const FittedBox(
          child: Text("Create Inspection", style: StyleUtility.appBarTextStyle),
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: _buildDrawer(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildDrawer() {
    String loadingText = "Loading...";
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),

            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 65,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.appWhite,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            selected: true,
            leading: const Icon(Icons.home),
            title: const Text(
              "Home",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: AppColors.appDarkPrimaryColor,
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // setState(() {
              //   _isContentLoading = true;
              // });
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              "Profile",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: AppColors.appBlack,
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text(
              "Sync Reports",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: AppColors.appBlack,
                fontSize: 14,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              // await checkIsDataAvailableToSync();
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text(
              "Restore Database",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: AppColors.appBlack,
                fontSize: 14,
              ),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              loadingText = "Checking...";
              // show loading popup
              PopUpDialogUtility.showLaodingPopup(
                context,
                loadingText: loadingText,
              );

              bool isInternetAvailable = await connectionStatus
                  .checkConnection();

              // hide loading popup
              PopUpDialogUtility.hideLoadingPopup(context);

              //To update local DB check internet connection first
              if (isInternetAvailable) {
                await PopUpDialogUtility.showAlertDialog(
                  context: context,
                  popupTitle: 'Confirmation',
                  description:
                      'It will take time depending upon network speed. Are you sure to update your local database.',
                  buttonCallback: () async {
                    // call function to sync lical incident data
                    loadingText = "Syncing local database...";
                    // show loading popup
                    // PopUpDialogUtility.showLaodingPopup(
                    //   context,
                    //   loadingText: loadingText,
                    // );

                    ToastUtility.showSuccessMessageFlushBar(
                      "upto date!",
                      context,
                    );

                    // bool isLocalDBUpdated = await storeBothData(true);

                    // if (isLocalDBUpdated) {
                    //   await updateLocalDBPref();
                    // }
                    // hide loading popup

                    // PopUpDialogUtility.hideLoadingPopup(context); //hide loading popup from storeBothData by passing true
                  },
                );
              } else {
                ToastUtility.showErrorMessageFlushBar(
                  "Currently experiencing internet connectivity issue. Please check and try again later.",
                  context,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  /// Builds the body depending on loading state
  Widget _buildBody() {
    // ✅ show card only if not loading
    return Center(child: _buildAddReportIncidentCard());
  }

  /// The tappable card
  Widget _buildAddReportIncidentCard() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InspectionChecklistScreen()),
        );
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.appPrimaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.appWhite,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.note_alt,
                color: AppColors.appPrimaryColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Create Inspection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.appTextIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = false;
  bool _isLogoutLoading = false;

  UserInfoModel? loginUserData;

  @override
  void initState() {
    getLoginUserData();
    super.initState();
  }

  Future<void> getLoginUserData() async {
    setState(() {
      _isLoading = true;
    });
    loginUserData = await SharedPrefCommon.getUserDetails() != null
        ? UserInfoModel.fromJson(await SharedPrefCommon.getUserDetails())
        : null;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "My Profile",
        clearBtnVisible: false,
        onClear: () {},
      ),
      body: _isLoading
          ? LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.appPrimaryColor,
                          maxRadius: 65,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loginUserData?.displayName ?? "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
                            color: AppColors.appPrimaryTextColor,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "User ID: ",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: AppColors.appSecondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          loginUserData?.employeeId ?? "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: AppColors.appBlack,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: AppColors.appSecondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          loginUserData?.mail ?? "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: AppColors.appBlack,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    // _isLogoutLoading
                    //     ? LoadingWidget()
                    //     : Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         ElevatedButton.icon(
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: AppColors.appPrimaryColor,
                    //             minimumSize: const Size(200, 50),
                    //           ),
                    //           onPressed: () {
                    //             showLogoutAlert();
                    //           },
                    //           icon: const Icon(
                    //             Icons.logout,
                    //             color: Colors.white,
                    //           ),
                    //           label: const Text(
                    //             'Logout',
                    //             style: TextStyle(
                    //               fontFamily: 'Roboto',
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.appTextIconColor,
                    //               fontSize: 18,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                  ],
                ),
              ),
            ),
    );
  }
}
