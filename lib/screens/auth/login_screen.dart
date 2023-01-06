import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/providers/auth.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/screens/auth/registration_screen.dart';
import 'package:rider/services/user.service.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/utility/validators.dart';
import 'package:rider/widgets/form_field_maker.dart';
import 'package:rider/widgets/message_snack.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // formkey
  final _formkey = GlobalKey<FormState>();

  // editing controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    authProvider.status == AuthenticationStatus.unknown;
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        _emailController.value;
      },
      validator: ((value) => validEmail(_emailController.text)),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Email", Icons.mail),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        _passwordController.value;
      },
      // validator: (value) => validPassword(_passwordController.text),
      textInputAction: TextInputAction.done,
      decoration: buildInputDecoration("Password", Icons.lock),
    );

    void login(BuildContext context) async {
      final form = _formkey.currentState;

      if (form!.validate()) {
        form.save();

        ScaffoldMessenger.of(context)
            .showSnackBar(showMessage(true, "Please wait authenticating ..."));

        // Update authentication status
        AuthenticationProvider.instance
            .authenticationChanged(AuthenticationStatus.authenticating);

        final res = await UserService().login(data: {
          "email": _emailController.text,
          "password": _passwordController.text
        });
        res.when(
          error: (error) {
            // if (kDebugMode) {
            //   print("An error occured");
            //   print(error.message);
            // }
            ScaffoldMessenger.of(context).showSnackBar(
              showMessage(false, "Incorrect email or password!"),
            );
            authProvider
                .authenticationChanged(AuthenticationStatus.unAuthenticated);
          },
          success: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              showMessage(true, "Login Success"),
            );

            AuthenticationProvider.instance.loginUser(user: data);

            Navigator.pushReplacementNamed(context, AppRoute.home);
          },
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(showMessage(false, 'Invalid form input!'));
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
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
                          "Sign in",
                          style: TextStyle(
                              color: AppTheme.darkColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sign in to continue",
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
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                emailField,
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                passwordField,
                const SizedBox(
                  height: 32,
                ),
                authProvider.status == AuthenticationStatus.authenticating
                    ? ButtonLoading(
                        title: "Login",
                        function: () {},
                      )
                    : submitButton("Login", () => login(context)),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account? ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => RegistrationScreen()),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
