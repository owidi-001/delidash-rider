String? validEmail(String email) {
  String? message;

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  // Null or empty email is invalid
  if (email.isEmpty) {
    message = "Your email is required";
  } else if (!regExp.hasMatch(email)) {
    message = "Please provide a valid email address!";
  }
  return message;
}

String? validName(String name) {
  String? message;

  // Null or empty name is invalid
  if (name.isEmpty) {
    message = "Your name is required";
  } 
  
  return message;
}


String? validNationalId(String id) {
  String? message;

  const pattern = r"^.{8}$";
  final regExp = RegExp(pattern);

  // Null or empty id is invalid
  if (id.isEmpty) {
    message = "National ID required!";
  } else if (!regExp.hasMatch(id)) {
    message = "Enter valid ID";
  }
  return message;
}

String? validLicense(String license) {
  String? message;


  // Null or empty id is invalid
  if (license.isEmpty) {
    message = "This field cannot be empty";
  } 
  return message;
}

String? validPhone(String phone) {
  String? message;

  const pattern = r"^(\+254|0)\d{9}$";
  final regExp = RegExp(pattern);

  // Null or empty phone is invalid
  if (phone.isEmpty) {
    message = "Your phone number is required";
  } else if (!regExp.hasMatch(phone)) {
    message = "Please provide a valid phone number!";
  }
  return message;
}

String? validPassword(String password) {
  String? message;

  const pattern = r"^.{8,}$";
  final regExp = RegExp(pattern);

  // Null or empty password is invalid
  if (password.isEmpty) {
    message = "Password field required!";
  } else if (!regExp.hasMatch(password)) {
    message = "Enter a strong password (> 8 characters)";
  }
  return message;
}

String? passwordMatch(String password1, String password2) {
  String? message;

  if (!password1.endsWith(password2)) {
    message = "Password Mismatch!";
  }

  return message;
}
