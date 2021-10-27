class UserIdentityProvieder {
  ///
  String _token;
  String _id;
  String _role;
  String _firstName;
  String _lastName;
  String _phoneNumber;

  static final UserIdentityProvieder _instance =
      UserIdentityProvieder._internal();

  factory UserIdentityProvieder() {
    return _instance;
  }

  UserIdentityProvieder._internal();

  void setToken(String token) {
    this._token = token;
  }

  String getToken() => _token;

  bool hasToken() => _token != null && _token != '';

  String getId() => _id;

  String getRole() => _role;

  void setId(String id) {
    this._id = id;
  }

  void setRole(String role) {
    this._role = role;
  }

  void setIdentity(String role, String id, String token) {
    this._role = role;
    this._id = id;
    this._token = token;
  }

  void setAccountInfo(String firstName, String lastName, String phoneNumber) {
    this._firstName = firstName;
    this._lastName = lastName;
    this._phoneNumber = phoneNumber;
  }

  String getFullName() {
    return '$_firstName $_lastName';
  }

  String getPhoneNumber() {
    return this._phoneNumber;
  }

  void reset() {
    this._firstName = null;
    this._lastName = null;
    this._id = null;
    this._role = null;
    this._token = null;
    this._phoneNumber = null;
  }

  bool get hasIdentity => _role != null && _id != null && _token != null;
}
