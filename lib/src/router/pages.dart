Pages pageFromPath(String code) {
  return Pages.values.firstWhere((Pages element) => element.getPath() == code,
      orElse: () => Pages.signUp);
}

enum Pages {
  signUp,
  
}

extension PagesExtension on Pages {
  String getPath() {
    switch (this) {
      case Pages.signUp:
        return "/sign-up";
    }
  }

    String getKey() {
    switch (this) {
      case Pages.signUp:
        return "sign-up";
    }
  }
}
