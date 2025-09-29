import 'dart:io';
import 'package:custom_widgets/custom_widget/core/common_app_bar.dart';
import 'package:custom_widgets/custom_widget/core/dropdown_list_widget.dart';
import 'package:custom_widgets/custom_widget/core/empty_attachment_widget.dart';
import 'package:custom_widgets/custom_widget/core/field_label_widget.dart';
import 'package:custom_widgets/custom_widget/core/floating_buttons_bottom_bar.dart';
import 'package:custom_widgets/custom_widget/core/incident_type_multidropdown_widget.dart';
import 'package:custom_widgets/custom_widget/core/search_dropdown_widget.dart';
import 'package:custom_widgets/custom_widget/core/selected_attachment_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_area_widget.dart';
import 'package:custom_widgets/custom_widget/core/text_field_widget.dart';
import 'package:custom_widgets/model/attachment_model.dart';
import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/model/employee_model.dart';
import 'package:custom_widgets/utility/enum.dart';
import 'package:custom_widgets/utility/global_tabs.dart';
import 'package:custom_widgets/utility/pop_up_dialog_utility.dart';
import 'package:custom_widgets/view/Screens/search_employee_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class CaDescriptionScreen extends StatefulWidget {
  final String uniqueId;
  final Map<String, dynamic>? existingData;

  const CaDescriptionScreen({
    super.key,
    required this.uniqueId,
    this.existingData,
  });
  @override
  State<CaDescriptionScreen> createState() => _CaDescriptionScreenState();
}

class _CaDescriptionScreenState extends State<CaDescriptionScreen> {
  DropdownItemModel? selectedPriorities;
  DropdownItemModel? selectedCaCategories;
  // DropdownItemModel? selectedStatuses;
  // = DropdownItemModel(
  //   id: 1,
  //   value: 1,
  //   name: "Open",
  // );
  late DropdownItemModel? selectedStatuses = statusDropDown[0];
  // DropdownItemModel? selectedStatuses;

  @override
  void initState() {
    super.initState();
    _docKey = 'document_paths_${widget.uniqueId}';
    _photoKey = 'photo_paths_${widget.uniqueId}';
    _loadSavedFiles();
    _loadExistingData();
  }

  void _loadExistingData() {
    print("called load existing data");
    final data = widget.existingData;
    if (data == null) return;

    setState(() {
      caDescriptionController.text = data['caDescription'] ?? '';
      notesController.text = data['notes'] ?? '';
      dueDateController.text = data['dueDate'] ?? '';
      assignToController.text = data['assignTo'] ?? '';

      selectedPriorities = priorityDropDown.firstWhere(
        (item) => item.name == data['priority']?.name,
        // orElse: () => null,
      );

      selectedCaCategories = caCategoryDropDown.firstWhere(
        (item) => item.name == data['caCategory']?.name,
        // orElse: () => null,
      );

      // selectedStatuses = statusDropDown.firstWhere(
      //   (item) => item.name == data['status']?.name,
      //   // orElse: () => null,
      // );

      selectedStatuses = statusDropDown.firstWhere(
        (item) => item.name == data['status']?.name,
        orElse: () => statusDropDown.first, // 👈 fallback to first
      );

      print(
        "${caDescriptionController.text} ${notesController.text} ${dueDateController.text} ${assignToController.text} ${selectedPriorities?.name} ${selectedCaCategories?.name}${selectedStatuses?.name}",
      );
    });
  }

  List<DropdownItemModel> _matchDropdownItems(
    dynamic names,
    List<DropdownItemModel> options,
  ) {
    if (names == null || names is! List) return [];
    return options.where((item) => names.contains(item.name)).toList();
  }

  Future<void> _loadSavedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final docPaths = prefs.getStringList(_docKey) ?? [];
    final photoPaths = prefs.getStringList(_photoKey) ?? [];

    List<File> validDocFiles = [];
    List<File> validPhotoFiles = [];

    for (var path in docPaths) {
      final file = File(path);
      if (await file.exists()) validDocFiles.add(file);
    }
    for (var path in photoPaths) {
      final file = File(path);
      if (await file.exists()) validPhotoFiles.add(file);
    }

    setState(() {
      documentFiles = validDocFiles;
      photoFiles = validPhotoFiles;
    });
  }

  final _formKey = GlobalKey<FormState>();
  // final String _additionalInfo = '';
  EmployeeModel? loginUser;
  EmployeeModel? reportedByDetails1;
  List<FileModel> files = [];

  TextEditingController caDescriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController assignToController = TextEditingController();

  final List<DropdownItemModel> priorityDropDown = [
    DropdownItemModel(id: 1, name: "Other", value: 1),
    DropdownItemModel(id: 2, name: "Within 2-3 days", value: 2),
    DropdownItemModel(id: 3, name: "within 24 hours", value: 3),
    DropdownItemModel(id: 4, name: "Within 5-7 days", value: 4),
  ];
  final List<DropdownItemModel> statusDropDown = [
    DropdownItemModel(id: 1, name: "Open", value: 1),
    DropdownItemModel(id: 2, name: "Close", value: 2),
    DropdownItemModel(id: 3, name: "Other", value: 3),
  ];

  final List<DropdownItemModel> caCategoryDropDown = [
    DropdownItemModel(id: 1, name: "ESC-Install", value: 1),
    DropdownItemModel(id: 2, name: "ESC-Maintain", value: 2),
    DropdownItemModel(id: 3, name: "ESC-Remove", value: 3),
    DropdownItemModel(id: 4, name: "Earth Management", value: 4),
    DropdownItemModel(id: 5, name: "Spill Prevention And Install", value: 5),
    DropdownItemModel(id: 6, name: "Surface Water Management", value: 6),
    DropdownItemModel(id: 7, name: "Waste Management", value: 7),
    DropdownItemModel(id: 8, name: "Wildlife mitigration", value: 8),
  ];

  int selectedTabIndex = 0;
  bool hasSelectedInspectionType = false;
  bool isAddEnabled = false;
  DropdownItemModel? _selectedPrivacySetting;

  List<File> documentFiles = [];
  List<File> photoFiles = [];

  // final String _docKey = 'document_paths';
  // final String _docKey = 'ca_description_document_paths';

  // final String _photoKey = 'photo_paths';
  // final String _photoKey = 'ca_description_photo_paths';

  late final String _docKey;
  late final String _photoKey;

  // DropdownItemModel? _selectedFileType;

  // Local lists to track selected dropdown items
  // List<DropdownItemModel> selectedPriorities = [];
  // List<DropdownItemModel> selectedCaCategories = [];
  // List<DropdownItemModel> selectedStatuses = [];

  Future<void> _updateTabs(
    DropdownItemModel dropdownItem,
    bool isSelected,
  ) async {
    if (GlobalState().selectedInspectionType.isEmpty) {
      hasSelectedInspectionType = false;
      await FilePicker.platform.clearTemporaryFiles();
    } else {
      hasSelectedInspectionType = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void setReportedByDetails1(EmployeeModel user) {
    reportedByDetails1 = user;
    assignToController.text = user.empName;
    setState(() {});
  }

  Future<File> _saveFilePermanently(PlatformFile file, String subfolder) async {
    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/attachments/$subfolder');

    if (!(await saveDir.exists())) {
      await saveDir.create(recursive: true);
    }

    final newPath = path.join(saveDir.path, file.name);
    return File(file.path!).copy(newPath);
  }

  Future<void> _pickFiles({required bool isDocument}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: isDocument
          ? ['pdf', 'xlsx', 'xls', 'docx', 'doc', 'csv']
          : ['png', 'jpeg', 'jpg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final key = isDocument ? _docKey : _photoKey;
      final currentPaths = prefs.getStringList(key) ?? [];

      List<File> newFiles = [];

      for (var file in result.files) {
        double sizeInMB = file.size / (1024 * 1024);
        if ((isDocument && sizeInMB <= 50) || (!isDocument && sizeInMB <= 10)) {
          final savedFile = await _saveFilePermanently(
            file,
            isDocument ? "documents" : "photos",
          );

          if (!currentPaths.contains(savedFile.path)) {
            currentPaths.add(savedFile.path);
            newFiles.add(savedFile);
          }
        }
      }

      await prefs.setStringList(key, currentPaths);

      setState(() {
        if (isDocument) {
          documentFiles.addAll(newFiles);
        } else {
          photoFiles.addAll(newFiles);
        }
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    caDescriptionController.dispose();
    dueDateController.dispose();
    notesController.dispose();
    assignToController.dispose();
    super.dispose();
  }

  void _showUploadOptions(bool isDocument) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Implement camera capture
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Choose from storage'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickFiles(isDocument: isDocument);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // List<DropdownItemModel> selectedPriorities = [];
    // List<DropdownItemModel> selectedCaCategories = [];
    // List<DropdownItemModel> selectedStatuses = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Add Corrective Action",
        clearBtnVisible: false,
        centerTitle: true,
        onClear: () {},
      ),
      body: SafeArea(
        key: const Key("value"),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CA Description
                TextAreaWidget(
                  isRequired: true,
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Maximum charcter limit is 500",
                  controller: caDescriptionController,
                  lable: "CA Description",
                  onChange: (value) {},
                ),

                const SizedBox(height: 10),

                // Priority
                const FieldLableWidget(
                  padding: EdgeInsets.only(left: 15),
                  lable: "Priority",
                  isRequired: true,
                ),

                // IncidentTypeFormField(
                //   selectedItems: GlobalState().selectedPriorities,
                //   hintText: "Priority",
                //   items: priorityDropDown,
                //   isRequired: true,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedPriorities = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                DropdownListWidget(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  selected: selectedPriorities,

                  isRequired: true,
                  items: priorityDropDown,
                  onChange: (value) async {
                    print("Selected name: ${value!.name}");

                    selectedPriorities = value;
                    // isAddEnable();
                  },
                ),
                const SizedBox(height: 10),

                // CA Category
                const FieldLableWidget(
                  padding: EdgeInsets.only(left: 15),
                  lable: "CA Category",
                  isRequired: true,
                ),
                // IncidentTypeMultidropdownWidget(
                //   selectedItems: GlobalState().selectedCaCategories,

                //   hintText: "CA Category",
                //   items: caCategoryDropDown,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedCaCategories = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                // IncidentTypeFormField(
                //   selectedItems: GlobalState().selectedCaCategories,
                //   hintText: "CA Category",
                //   items: caCategoryDropDown,
                //   isRequired: true,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedCaCategories = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                DropdownListWidget(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  selected: selectedCaCategories,

                  isRequired: true,
                  items: caCategoryDropDown,
                  onChange: (value) async {
                    print("Selected name: ${value!.name}");

                    selectedCaCategories = value;
                    // isAddEnable();
                  },
                ),
                const SizedBox(height: 10),

                // Assigned To
                const FieldLableWidget(
                  lable: "Assigned To",
                  isRequired: true,
                  padding: EdgeInsets.only(left: 15),
                ),
                // If you want to use SearchDropdownWidget uncomment and fix as needed
                SearchDropdownWidget(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  controller: assignToController,
                  icon: const Icon(Icons.person),
                  isRequired: true,
                  hintText: 'Assigned To',
                  onTap: () {
                    Navigator.push<EmployeeModel>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SearchEmployeeScreen(title: 'Assigned To'),
                      ),
                    ).then((selectedEmployee) {
                      print("${selectedEmployee?.empName} ----------------");
                      if (selectedEmployee != null) {
                        if (loginUser?.empId == selectedEmployee.empId) {
                          PopUpDialogUtility.showAlertDialogSystem(
                            context: context,
                            popupTitle: 'Warning',
                            description:
                                "Reporting Person cannot be the same as the Incident Entered By.",
                          );
                          return;
                        }
                        setReportedByDetails1(selectedEmployee);
                      }
                    });
                  },
                ),

                // const SizedBox(height: 10),

                // Notes
                TextAreaWidget(
                  isRequired: false,
                  height: 75,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Maximum charcter limit is 500",
                  controller: notesController,
                  lable: "Notes",
                  onChange: (value) {},
                ),

                const SizedBox(height: 10),

                // Due Date
                const FieldLableWidget(
                  lable: "Due Date",
                  isRequired: true,
                  padding: EdgeInsets.only(left: 15),
                ),
                TextFieldWidget(
                  hintText: "",
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  enabled: false,
                  controller: dueDateController,
                  onChange: (v) {},
                ),

                const SizedBox(height: 10),

                // Status
                const FieldLableWidget(
                  padding: EdgeInsets.only(left: 15),
                  lable: "Status",
                  isRequired: true,
                ),

                // IncidentTypeFormField(
                //   selectedItems: GlobalState().selectedStatuses,
                //   hintText: "Status",
                //   items: statusDropDown,
                //   isRequired: true,
                //   onSelect: (selectedTypes, value, isSelected) async {
                //     GlobalState().selectedStatuses = selectedTypes;
                //     await _updateTabs(value, isSelected);
                //   },
                // ),
                DropdownListWidget(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  selected: selectedStatuses,

                  // (selectedStatuses != null)
                  //     ? statusDropDown[0]
                  //     : selectedStatuses,
                  isRequired: true,
                  items: statusDropDown,
                  onChange: (value) async {
                    print("Selected name: ${value!.name}");

                    selectedStatuses = value;
                    // isAddEnable();
                  },
                ),

                const SizedBox(height: 20),

                _buildCard(
                  title: "Attach Documents",
                  files: documentFiles,
                  onUploadPressed: () => _showUploadOptions(true),
                  isDocument: true,
                ),
                _buildCard(
                  title: "Attach Photos",
                  files: photoFiles,
                  onUploadPressed: () => _showUploadOptions(false),
                  isDocument: false,
                ),
                SizedBox(height: 20),

                // // Attach Documents
                // const FieldLableWidget(
                //   padding: EdgeInsets.only(left: 15),
                //   lable: "Attach Documents",
                //   isRequired: false,
                //   textStyle: TextStyle(
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 16,
                //   ),
                // ),

                // AttachmentListBuilderWidget(
                //   itemCount: files.length + 1,
                //   itemBuilder: (context, fileIndex) {
                //     if (files.isEmpty || fileIndex + 1 > files.length) {
                //       return buildEmptyAttachmentWidget();
                //     } else {
                //       return buildSelectedAttachmentWidget(fileIndex);
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButtonsBottomBar(
        cancelButtonType: ButtonType.close,
        buttonType: ButtonType.submit,
        onSave: () async {
          if (!_formKey.currentState!.validate()) {
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
            // return; // stop further execution
          } else if (_formKey.currentState!.validate()) {
            final resultData = {
              'uniqueId': widget.uniqueId,
              'assignTo': assignToController.text,
              // 'priority': GlobalState().selectedPriorities
              //     .map((e) => e.name)
              //     .toList(),
              'priority': selectedPriorities,
              'caCategory': selectedCaCategories,
              'status': selectedStatuses,
              'dueDate': dueDateController.text,
              'caDescription': caDescriptionController.text,
              'notes': notesController.text,
            };
            // GlobalState().selectedPriorities = [];
            // GlobalState().selectedCaCategories = [];
            // GlobalState().selectedStatuses = [];
            print(" Result Data ----${resultData} ");
            print(
              "status  ${(resultData["status"] as DropdownItemModel).name}",
            );

            Navigator.of(context).pop(resultData);
          }
        },

        isSaveEnable: true,
      ),
    );
  }

  Widget buildSelectedAttachmentWidget(int index) {
    return SelectedAttachmentWidget(
      file: files[index],
      isVisibleDelete: true,
      onFileDelete: () {
        setState(() {
          files.removeAt(index);
          isAddEnable();
        });
      },
    );
  }

  Widget buildEmptyAttachmentWidget() {
    return EmptyAttachmentWidget(
      ctx: context,
      onTapCamera: (file) async {
        setState(() {
          files.add(file);
          isAddEnable();
        });
      },
      onTapGallary: (file) {
        setState(() {
          files.add(file);
          isAddEnable();
        });
      },
    );
  }

  void isAddEnable() {
    isAddEnabled = false;
    if (_selectedPrivacySetting != null && files.isNotEmpty) {
      isAddEnabled = true;
    }
    setState(() {});
  }

  Widget _buildCard({
    required String title,
    required List<File> files,
    required VoidCallback onUploadPressed,
    required bool isDocument,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onUploadPressed,
                icon: const Icon(Icons.upload_file, color: Colors.blue),
                label: const Text(
                  "Upload",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (files.isEmpty)
              SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.insert_drive_file,
                        size: 60,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "No files found",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: onUploadPressed,
                        icon: const Icon(Icons.upload, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        label: const Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: files.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final file = files[index];
                  final fileName = path.basename(file.path);

                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _onFileTap(file, isDocument),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isDocument)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      file,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ),
                                  )
                                else
                                  const Icon(
                                    Icons.insert_drive_file,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                const SizedBox(height: 8),
                                Flexible(
                                  child: Text(
                                    fileName,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _deleteFile(file, isDocument),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _onFileTap(File file, bool isDocument) {
    if (isDocument) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Can't preview this file")));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImagePreviewScreen(imageFile: file)),
      );
    }
  }

  Future<void> _deleteFile(File file, bool isDocument) async {
    final prefs = await SharedPreferences.getInstance();
    final key = isDocument ? _docKey : _photoKey;
    final currentPaths = prefs.getStringList(key) ?? [];

    if (await file.exists()) {
      await file.delete();
    }

    currentPaths.remove(file.path);
    await prefs.setStringList(key, currentPaths);

    setState(() {
      if (isDocument) {
        documentFiles.removeWhere((f) => f.path == file.path);
      } else {
        photoFiles.removeWhere((f) => f.path == file.path);
      }
    });
  }
}

// -------------------- Image Preview Screen ------------------------

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;

  const ImagePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Photo Preview",
        clearBtnVisible: false,
        centerTitle: true,
        onClear: () {},
      ),
      body: Center(child: InteractiveViewer(child: Image.file(imageFile))),
    );
  }
}
