import 'dart:html';
import 'package:foodyweb/constant/const.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/firebase_services.dart';
import 'package:foodyweb/sidebar.dart';
import 'package:ars_dialog/ars_dialog.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';

class CategoryCreateWidget extends StatefulWidget {
  @override
  _CategoryUploadImageState createState() => _CategoryUploadImageState();
}

class _CategoryUploadImageState extends State<CategoryCreateWidget> {
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();
  var categoryPriceTextController = TextEditingController();
  var categoryNameTextController = TextEditingController();
  var categoryComPriceTextController = TextEditingController();
  var categoryDiscriptionTextController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool _visible = false;
  bool imageSelected = true;
  // Reference _url;
  PickedFile pickedFile;
  DateTime datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ProgressDialog _progressDialog = ProgressDialog(
      context,
      blur: 2,
      backgroundColor: Color(0xFF84c225).withOpacity(.3),
      transitionDuration: Duration(microseconds: 500),
    );
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Form(
          key: _formKey,
          child: Row(children: [
            Visibility(
              visible: _visible,
              child: Container(
                //height: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: categoryNameTextController,
                            validator: (String value) {
                              // categoryNameTextController.text = value;
                              if (value.isEmpty) {
                                return 'Please Enter  Product name';
                              }
                              // if (!RegExp(
                              //         r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                              //     .hasMatch(value)) {
                              //   return 'Please enter a valid Employee';
                              // }
                              return null;
                            },
                            decoration:
                                buildInputDecoration(Icons.category, "product"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: 200,
                            height: 30,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: categoryPriceTextController,
                              validator: (String value) {
                                // categoryPriceTextController.text = value;
                                if (value.isEmpty) {
                                  return 'Please product price';
                                }
                                if (!RegExp(r"^-?[0-9]+$").hasMatch(value)) {
                                  return 'enter valid price';
                                }
                                return null;
                              },
                              decoration:
                                  buildInputDecoration(Icons.money, "Price"),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: 200,
                            height: 30,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: categoryComPriceTextController,
                              validator: (String value) {
                                //categoryComPriceTextController.text = value;
                                if (value.isEmpty) {
                                  return 'Please enter compared price';
                                }
                                if (!RegExp(r"^-?[0-9]+$").hasMatch(value)) {
                                  return 'enter valid compared price';
                                }
                                return null;
                              },
                              decoration: buildInputDecoration(
                                  Icons.money, "Compared price"),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: categoryDiscriptionTextController,
                            validator: (String value) {
                              // categoryDiscriptionTextController.text = value;
                              if (value.isEmpty) {
                                return 'Please enter description of product';
                              }
                              if (!RegExp(
                                      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                  .hasMatch(value)) {
                                return 'Please enter a valid description';
                              }
                              return null;
                            },
                            decoration: buildInputDecoration(
                                Icons.description, "Description"),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 120.0),
                          child: TextButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Text(
                              'Pick image',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black54),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            String downloadUrl =
                                await uploadStorage(pickedFile);
                            // if (categoryNameTextController.text.isEmpty) {
                            //   _services.showMyDialog(
                            //       title: 'add new product',
                            //       message: 'new product name is not given',
                            //       context: context);
                            // }
                            _progressDialog.show();
                            if (_formKey.currentState.validate()) {
                              bool result =
                                  await _services.UploadCategoryImageTodb(
                                      downloadUrl,
                                      categoryNameTextController.text,
                                      categoryPriceTextController.text,
                                      categoryComPriceTextController.text,
                                      categoryDiscriptionTextController.text);
                              if (result) {
                                _progressDialog.dismiss();
                                _services.showMyDialog(
                                    title: 'New product ',
                                    message: 'saved product successfully',
                                    context: context);
                              } else {
                                _services.showMyDialog(
                                    title: 'New product',
                                    message: 'Cannot be saved ',
                                    context: context);
                              }

                              categoryNameTextController.clear();
                              categoryPriceTextController.clear();
                              categoryComPriceTextController.clear();
                              categoryDiscriptionTextController.clear();
                            }
                          },
                          child: Text(
                            'Save image',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                imageSelected
                                    ? Colors.black12
                                    : Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visible ? false : true,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: Text(
                  'Add new product',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black54),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void pickImage() async {
    pickedFile = await _picker.getImage();
    //fileNameTextController.text = path.basename(pickedFile.path);
    setState(() {});
    // InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    // uploadInput.click();
    // uploadInput.onChange.listen((event) {
    //   final file = uploadInput.files.first;
    //
    // });
  }
  // void uploadStorage() {

  Future<String> uploadStorage(PickedFile file) async {
    final path = 'categoryImage';

    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(path)
        .child('${categoryNameTextController.text}');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();

    return downloadUrl;
    // return Future.value(uploadTask);
  }

  // uploadImage(onSelected: (file) {
  //   if (file != null) {
  //     setState(() {
  //       fileNameTextController.text = file.name;
  //       imageSelected = false;
  //       _url = path;
  //     });
  //     db
  //         .storage()
  //         .refFromURL(
  //             'https://console.firebase.google.com/project/foodyfyp/storage/foodyfyp.appspot.com/files')
  //         .child(path)
  //         .put(file);
  //   }
  // });
  // }

}
