class UserModel {
  String _usercode;
  String _userName;
  String _userEmail;
  String _userEmpCode;
  String _companyCode;
  List<String> _userLocations;
  List<String> _userPermissions;

  UserModel(
    this._usercode,
    this._userName,
    this._userEmail,
    this._userEmpCode,
    this._companyCode,
    this._userLocations,
    this._userPermissions,
  );

  get usercode => _usercode;
  set usercode(value) => _usercode = value;

  get userName => _userName;
  set userName(value) => _userName = value;

  get userEmail => _userEmail;
  set userEmail(value) => _userEmail = value;

  get userEmpCode => _userEmpCode;
  set userEmpCode(value) => _userEmpCode = value;

  get companyCode => _companyCode;
  set companyCode(value) => _companyCode = value;

  get userLocations => _userLocations;
  set userLocations(value) => _userLocations = value;

  get userPermissions => _userPermissions;
  set userPermissions(value) => _userPermissions = value;
}
