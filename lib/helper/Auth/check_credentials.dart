class FirebaseExeptionHandler {
  String? errorMessage = 'error not found in firebase exeption';
  String getMessageFromErrorCode(String error) {
    switch (error) {
      case "ERROR_INVALID_EMAIL":
      case "error_invalid_email":
      case "invalid-email":
        return errorMessage = "Your email address appears to be malformed.";

      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return errorMessage = "Your password is wrong.";

      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return errorMessage = "User with this email doesn't exist.";

      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return errorMessage = "User with this email has been disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
        return errorMessage = "Too many requests. Try again later.";

      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return errorMessage =
            "Signing in with Email and Password is not enabled.";
      case "ERROR_INVALID_CREDENTIAL":
        return errorMessage =
            "The supplied auth credential is malformed or has expired.";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return errorMessage =
            "The email address is already in use by another account.";
      case "ERROR_MISSING_EMAIL":
        return errorMessage = "An email address must be provided.";

      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return errorMessage = 'Email address already used';

      default:
        return errorMessage = "Login failed. Please try again.";
    }
  }
}


//  ("ERROR_USER_MISMATCH", "The supplied credentials do not correspond to the previously signed in user."));
//  ("ERROR_REQUIRES_RECENT_LOGIN", "This operation is sensitive and requires recent authentication. Log in again before retrying this request."));
//  ("ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL", "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address."));
//  ("", ""));
//  ("ERROR_CREDENTIAL_ALREADY_IN_USE", "This credential is already associated with a different user account."));
//  ("ERROR_USER_DISABLED", "The user account has been disabled by an administrator."));
//  ("ERROR_USER_TOKEN_EXPIRED", "The user\'s credential is no longer valid. The user must sign in again."));
//  ("", "There is no user record corresponding to this identifier. The user may have been deleted."));
//  ("ERROR_INVALID_USER_TOKEN", "The user\'s credential is no longer valid. The user must sign in again."));
//  ("ERROR_OPERATION_NOT_ALLOWED", "This operation is not allowed. You must enable this service in the console."));
//  ("ERROR_WEAK_PASSWORD", "The given password is invalid."));
