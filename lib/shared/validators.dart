String? emailValidator(value, String errorMessage) {
  if (value == null || value.isEmpty) {
    return errorMessage;
  }
  return null;
}

String? passwordValidator(value, int requiredLength) {
  if (value == null || value.length < requiredLength) {
    return 'Enter password at least $requiredLength characters long';
  }
  return null;
}

String? passwordConfirmationValidator(value1, value2, int requiredLength) {
  if (value1 == null ||
      value2 == null ||
      value1.length < requiredLength ||
      value2.length < requiredLength) {
    return 'Enter password at least $requiredLength characters long';
  }
  if (value1 != value2) {
    return 'Passwords do not match';
  }
  return null;
}
