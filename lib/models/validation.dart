String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Enter you E-mail Address';
  } else if (!formEmail.contains('@') || !formEmail.contains('.')) {
    return 'Enter a valid Email adresss';
  }
  return null;
}

String? validateNumber(String? formNumber) {
  if (formNumber == null || formNumber.isEmpty) {
    return 'Enter you Phone Number';
  } else if (formNumber.length != 10) {
    return 'Enter a valid Mobile Number';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Enter a password';
  } else if (password.length < 8) {
    return 'Your Password must have at least 8 characters';
  }
  return null;
}
