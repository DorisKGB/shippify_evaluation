enum CErrors {
  requiredField,
  invalidEmail,
  invaliadPassword,
  diferentPassword,
  invalidName,
  invalidNumber,
  invalidDescription,
  unknow,
  unavailable,
  maximiumCharacters
}

extension CErrorsDetail on CErrors {
  String getDescription({int? size}) {
    switch (this) {
      case CErrors.requiredField:
        return "";
      case CErrors.invalidEmail:
        return ""; 
      case CErrors.invaliadPassword:
        return ""; 
      case CErrors.invalidName:
        return ""; 
      case CErrors.invalidNumber:
        return ""; 
      case CErrors.invalidDescription:
        return ""; 
      case CErrors.diferentPassword:
        return ""; 
      case CErrors.unknow:
        return ""; 
      case CErrors.unavailable:
        return ""; 
      case CErrors.maximiumCharacters:
        return ""; 
    }
  }
}
