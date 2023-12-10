class TransferModel {
    final int idTransfer;
    final int idAccountSender;
    final int idAccountReceiver;
    final double amount;
    final DateTime dateIssue;

    TransferModel({
        this.idTransfer = 0,
        required this.idAccountSender,
        required this.idAccountReceiver,
        required this.amount,
        required this.dateIssue,
    });

    factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        idTransfer: json["idTransfer"],
        idAccountSender: json["idAccountSender"],
        idAccountReceiver: json["idAccountReceiver"],
        amount: json["amount"].toDouble(),
        dateIssue: DateTime.parse(json["dateIssue"]),
    );

    Map<String, dynamic> toJson() => {
        "idTransfer": idTransfer,
        "idAccountSender": idAccountSender,
        "idAccountReceiver": idAccountReceiver,
        "amount": amount,
        "dateIssue": dateIssue.toIso8601String(),
    };
}
