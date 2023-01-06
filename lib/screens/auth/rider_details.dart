import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/providers/auth.provider.dart';
import 'package:rider/providers/rider.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/services/rider.service.dart';
import 'package:rider/services/user.service.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/utility/validators.dart';
import 'package:rider/widgets/form_field_maker.dart';
import 'package:rider/widgets/message_snack.dart';

class RiderDetailsScreen extends StatelessWidget {
  RiderDetailsScreen({Key? key}) : super(key: key);

  // formkey
  final _formkey = GlobalKey<FormState>();

  // editing controllers
  final TextEditingController _brandController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _nationalIdController = TextEditingController();

  final TextEditingController _licenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final riderProvider = Provider.of<RiderProvider>(context);

    // name field
    final brandField = TextFormField(
      autofocus: false,
      controller: _brandController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        _brandController.value;
      },
      validator: ((value) => validName(_brandController.text)),
      textInputAction: TextInputAction.next,
      decoration:
          buildInputDecoration("eg. Oti rides", Icons.branding_watermark),
    );

    // DOB field
    final dobField = TextFormField(
      autofocus: false,
      controller: _dobController,
      keyboardType: TextInputType.datetime,
      inputFormatters: [DateTextFormatter()],
      maxLength: 10,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onSaved: (value) {
        _dobController.value;
      },
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("DD/MM/YYYY", Icons.calendar_month),
    );

    // national id field
    final nationalIdField = TextFormField(
      autofocus: false,
      obscureText: false,
      controller: _nationalIdController,
      maxLength: 8,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      keyboardType: TextInputType.number,
      validator: ((value) => validNationalId(_nationalIdController.text)),
      onSaved: (value) {
        _nationalIdController.value;
      },
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("National ID", Icons.assignment_ind),
    );

    // license field
    final licenseField = TextFormField(
      autofocus: false,
      obscureText: false,
      controller: _licenseController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        _licenseController.value;
      },
      textInputAction: TextInputAction.done,
      validator: ((value) => validLicense(_licenseController.text)),
      decoration: buildInputDecoration("License document", Icons.book_outlined),
    );

    // Handle register
    void saveDriver(BuildContext context) async {
      final form = _formkey.currentState;

      if (form!.validate()) {
        form.save();

        // // Update authentication status
        // authProvider.authenticationChanged(AuthenticationStatus.authenticating);
        final res = await RiderService().saveRider(data: {
          "brand": _brandController.text,
          "dob": _dobController.text,
          "national_id": _nationalIdController.text,
          "license": _licenseController.text
        });

        res.when(error: (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(showMessage(false, error.message));
        }, success: (data) {
          ScaffoldMessenger.of(context)
              .showSnackBar(showMessage(true, "Rider info saved"));

          // Update provider to read user
          riderProvider.loginRider(rider: data);

          Navigator.pushReplacementNamed(context, AppRoute.home);
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(showMessage(false, "Please fill the form properly"));
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: AppTheme.primaryColor,
            )),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Rider info",
                          style: TextStyle(
                              color: AppTheme.darkColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Enter rider information",
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Brand Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                brandField,
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Date of Birth",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                dobField,
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "National ID",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                nationalIdField,
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "License number",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                licenseField,
                const SizedBox(
                  height: 32,
                ),
                riderProvider.status == AuthenticationStatus.authenticating
                    ? ButtonLoading(title: "Saving", function: () => {})
                    : submitButton("Save", () => saveDriver(context)),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

// For formatting the date field
class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '/');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
