class BankAccountModel {
  final int idAccount;
  final int idUser;
  final int accountNumber;
  final double accountAmount;

  BankAccountModel({
    required this.idAccount,
    required this.idUser,
    required this.accountNumber,
    required this.accountAmount,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      idAccount: json["idAccount"] != null ? json["idAccount"] as int : 0,
      idUser: json["idUser"] != null ? json["idUser"] as int : 0,
      accountNumber:
          json["accountNumber"] != null ? json["accountNumber"] as int : 0,
      accountAmount: json["accountAmount"] != null
          ? json["accountAmount"].toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idAccount": idAccount,
      "idUser": idUser,
      "accountNumber": accountNumber,
      "accountAmount": accountAmount,
    };
  }
}
