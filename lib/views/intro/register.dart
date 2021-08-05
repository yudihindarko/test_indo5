import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_indo5/api/base_feature.dart';
import 'package:test_indo5/model/base_feature/location.dart';
import 'package:test_indo5/model/base_feature/registration.dart';
import 'package:test_indo5/utils/checkJwt.dart';
import 'package:test_indo5/widgets/intro/global_styled_text.dart';
import 'package:test_indo5/widgets/intro/appbar.dart';
import 'package:test_indo5/widgets/intro/button.dart';
import 'package:test_indo5/widgets/intro/textfield.dart';
import 'package:loader_overlay/loader_overlay.dart';

enum LocationFetch {
  provinsi,
  kota,
  kecamatan,
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final storage = FlutterSecureStorage();
  RegistrationModel data = RegistrationModel();
  UtilsJwt utilsJwt = UtilsJwt();
  bool agreementAgreed = false;

  String? Function(dynamic) validateField(RegisterFields field) => (value) {
        switch (field) {
          case RegisterFields.provinsi:
          case RegisterFields.kota:
          case RegisterFields.kecamatan:
            if (value == null || value.name.isEmpty) {
              return 'Please input the valid value';
            }
            return null;
          case RegisterFields.nama:
            if (value == null || value.isEmpty) {
              return 'Please input the valid value';
            }
            String pattern = r'^[a-zA-Z ]*$';
            if (!RegExp(pattern).hasMatch(value)) {
              return 'The name can only contain letters and space';
            }
            return null;
          case RegisterFields.email:
            if (value == null || value.isEmpty) {
              return 'Please input the valid value';
            }
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            if (!RegExp(pattern).hasMatch(value)) {
              return 'The email is not valid';
            }
            return null;
          case RegisterFields.phoneNumber:
          case RegisterFields.alamat:
          case RegisterFields.kodepos:
          case RegisterFields.password:
          case RegisterFields.confirmPassword:
          default:
            if (value == null || value.isEmpty) {
              return 'Please input the valid value';
            }
            return null;
        }
      };

  _saveValue(RegisterFields field) => (value) {
        switch (field) {
          case RegisterFields.nama:
            data.nama = value;
            break;
          case RegisterFields.email:
            data.email = value;
            break;
          case RegisterFields.phoneNumber:
            data.phoneNumber = value;
            break;
          case RegisterFields.alamat:
            data.alamat = value;
            break;
          case RegisterFields.password:
            data.password = value;
            break;
          case RegisterFields.confirmPassword:
            data.confirmPassword = value;
            break;
          default:
            break;
        }
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IntroAppbar(),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              GlobalStyledText(
                "Register",
                fontSize: 28,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFieldRegister(
                      labelText: "Nama",
                      validator: validateField(RegisterFields.nama),
                      onSaved: _saveValue(RegisterFields.nama),
                    ),
                    SizedBox(height: 20),
                    TextFieldRegister(
                      labelText: "Email",
                      validator: validateField(RegisterFields.email),
                      onSaved: _saveValue(RegisterFields.email),
                    ),
                    SizedBox(height: 20),
                    TextFieldRegister(
                      labelText: "No Handphone",
                      validator: validateField(RegisterFields.phoneNumber),
                      onSaved: _saveValue(RegisterFields.phoneNumber),
                      type: TextFieldIntroType.phone,
                    ),
                    SizedBox(height: 20),
                    TextFieldRegister(
                      labelText: "Alamat",
                      validator: validateField(RegisterFields.alamat),
                      onSaved: _saveValue(RegisterFields.alamat),
                    ),
                    SizedBox(height: 20),
                    TextFieldRegister(
                      labelText: "Kata Sandi",
                      validator: validateField(RegisterFields.password),
                      onSaved: _saveValue(RegisterFields.password),
                      type: TextFieldIntroType.password,
                    ),
                    SizedBox(height: 20),
                    TextFieldRegister(
                      labelText: "Konfirmasi Sandi",
                      validator: validateField(RegisterFields.confirmPassword),
                      onSaved: _saveValue(RegisterFields.confirmPassword),
                      type: TextFieldIntroType.password,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: agreementAgreed,
                          onChanged: (val) {
                            setState(() {
                              agreementAgreed = !agreementAgreed;
                            });
                          },
                          fillColor:
                              MaterialStateProperty.all(Colors.orange.shade400),
                        ),
                        Expanded(
                          child: GlobalStyledText(
                            "I acknowledge that I have read and accept the Terms of Use Agreement and consent to the Privacy Policy",
                            maxLines: 3,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ButtonIntro(
                      label: "Register",
                      textColor: Colors.white,
                      onPressed: () async {
                        bool allFieldsValid = formkey.currentState!.validate();
                        formkey.currentState!.save();

                        if (!allFieldsValid) {
                          _showAlert(
                            context,
                            "Make sure all the fields is valid, Please check your input again",
                          );
                          return;
                        }

                        if (!agreementAgreed) {
                          _showAlert(
                            context,
                            "Make sure you are agreed to the Terms of Use Agreement and the Privacy Policy",
                          );
                          return;
                        }

                        if (data.password != data.confirmPassword) {
                          _showAlert(
                            context,
                            "The password didn't match",
                          );
                          return;
                        }

                        context.loaderOverlay.show();
                        var api = APIBaseFeature();
                        var respons = await api.postRegistration(context, data);
                        context.loaderOverlay.hide();
                        if (utilsJwt.checkJwt(respons))
                          storage.write(key: "jwt", value: respons);
                        Navigator.pushReplacementNamed(
                            context, '/superapp/home');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  _fetchLocation(LocationFetch type) => (keyword) async {
        var api = APIBaseFeature();
        List<LocationModel> list;
        switch (type) {
          case LocationFetch.provinsi:
            list = await api.getProvinsi(context);
            break;
          case LocationFetch.kota:
            list = await api.getKota(context, data.provinsi.name);
            break;
          case LocationFetch.kecamatan:
            list = await api.getKecamatan(context, data.kota.name);
            break;
          default:
            list = [];
            break;
        }

        return list;
        // return list.map((item) => item['name'] ?? "").toList();
      };

  _showAlert(context, msg) {
    var scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
      ),
    );
  }
}

class DropdownRegister extends StatelessWidget {
  final String labelText;
  final String? Function(dynamic)? validator;
  final Future<List<LocationModel>> Function(String) onFind;
  final void Function(dynamic)? onSaved;
  final onChanged;

  const DropdownRegister({
    this.labelText = "",
    this.validator,
    required this.onFind,
    this.onSaved,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GlobalStyledText(
          labelText,
          color: Colors.white,
          fontSize: 18,
        ),
        SizedBox(height: 10),
        DropdownSearch<LocationModel>(
          popupBackgroundColor: Colors.black,
          popupItemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                child: GlobalStyledText(
                  item.name,
                  color: Colors.white,
                ),
              ),
            );
          },
          dropdownBuilder: (context, selectedItem, itemAsString) {
            return Text(selectedItem?.name ?? "",
                style: Theme.of(context).textTheme.subtitle1);
          },
          dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.grey,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding: EdgeInsets.only(left: 10),
          ),
          searchBoxDecoration: InputDecoration(
            filled: true,
            focusColor: Colors.grey,
            fillColor: Colors.grey,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          filterFn: (item, filter) =>
              item.name.toLowerCase().contains(filter.toLowerCase()),
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          mode: Mode.DIALOG,
          showSearchBox: true,
          autoFocusSearchBox: true,
          onFind: onFind,
        ),
      ],
    );
  }
}

class TextFieldRegister extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final TextFieldIntroType type;
  final void Function(String?)? onSaved;

  const TextFieldRegister({
    this.labelText = "",
    this.validator,
    this.type = TextFieldIntroType.text,
    this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalStyledText(
          labelText,
          color: Colors.white,
          fontSize: 18,
        ),
        SizedBox(height: 10),
        TextFieldIntro(
          labelText: "",
          validator: validator,
          onSaved: onSaved,
          fillColor: Colors.grey,
          textColor: Colors.black,
          type: type,
        ),
      ],
    );
  }
}
