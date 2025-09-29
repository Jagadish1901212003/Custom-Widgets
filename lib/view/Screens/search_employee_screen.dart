import 'package:custom_widgets/custom_widget/core/circular_progress_loading_widget.dart';
import 'package:custom_widgets/custom_widget/core/no_search_data.dart';
import 'package:custom_widgets/model/employee_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/utility/app_constants.dart';
import 'package:flutter/material.dart';

class SearchEmployeeScreen extends StatefulWidget {
  final String title;
  const SearchEmployeeScreen({super.key, required this.title});

  @override
  State<SearchEmployeeScreen> createState() => _SearchEmployeeScreenState();
}

class _SearchEmployeeScreenState extends State<SearchEmployeeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchTextController = TextEditingController();

  List<EmployeeModel> _employeeDataList = [];

  List<EmployeeModel> _filteredList = [];

  bool _isLoading = false;
  @override
  void initState() {
    getEmployeeListData();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  Future<void> getEmployeeListData() async {
    List<dynamic> listData = AppData.employeeData;

    for (var i = 0; i < listData.length; i++) {
      var value = EmployeeModel(
        //  id: listData[i]['ID'],
        empId: listData[i]['EMPID'],
        empName: listData[i]['EMPNM'] ?? "",
        email: listData[i]['EMPML'] ?? "",
        division: listData[i]['DIVSN'] ?? "", //
        unit: listData[i]['EUNIT'] ?? "",
        positionName: listData[i]['POSIT'] ?? "",
        positionId: listData[i]['POSID'] ?? "",
        department: listData[i]['DEPNM'] ?? "",
        supervisor: listData[i]['SUPNM'] ?? "",
        supervisorAtInciTime: listData[i]['SUPNM'] ?? "",
        supervisorAtInciTimeId: listData[i]['SUPID'] ?? "",
        branch: listData[i]['BRANH'] ?? "", //
        worksite: listData[i]['WORKS'] ?? "", //
        supervisorId: listData[i]['SUPID'] ?? "",
        managerId: listData[i]['MGRID'] ?? "",
        managerName: listData[i]['MGRNM'] ?? "",
      );
      _employeeDataList.add(value);
    }
    _filteredList = _employeeDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.appBlack),
        ),
        title: const Text(
          'Your Name',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.appBlack,
          ),
        ),
        centerTitle: true,
        // No actions here anymore
      ),

      body: _isLoading
          ? const LoadingWidget()
          : Column(
              children: [
                Divider(
                  height: 1,
                  color: AppColors.appGreyColor.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: _buildSearchTextFiledWidget(),
                ),
                Expanded(
                  child: _employeeDataList.isNotEmpty
                      ? _createListView()
                      : const NoSearchDataWidget(),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchTextFiledWidget() {
    return TextField(
      controller: _searchTextController,
      onChanged: (value) {
        if (value.trim().length >= 2) {
          _filteredList = _employeeDataList.where((item) {
            return item.empName.toLowerCase().contains(value.toLowerCase()) ||
                item.empId.toLowerCase().contains(value.toLowerCase());
          }).toList();
          setState(() {});
        }
      },
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: AppColors.appGreyColor,
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: const Icon(Icons.search, color: AppColors.appGreyColor),
        suffixIcon: _searchTextController.text.trim().isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close, color: AppColors.appGreyColor),
                onPressed: () {
                  setState(() {
                    _searchTextController.clear();
                    _filteredList = _employeeDataList;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.appGreyColor.withOpacity(0.3),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      ),
    );
  }

  Widget _createListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 40),
      itemCount: _filteredList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
            Navigator.of(context).pop(_filteredList[index]);
          },
          title: Text(
            _filteredList[index].empName,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            _filteredList[index].empId,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.appGreyColor,
            ),
          ),
          dense: true,
        );
      },
    );
  }
}
