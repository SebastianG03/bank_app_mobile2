import 'package:bank_mobile/config/helpers/bank_account_answer.dart';
import 'package:bank_mobile/config/helpers/transfer_answer.dart';
import 'package:bank_mobile/infrastructure/form_validations/forms_validations.dart';
import 'package:flutter/material.dart';

class TransferProvider extends ChangeNotifier {
  final AccountValidator accountValidator = AccountValidator();
  final AmountValidator amountValidator = AmountValidator();

  //Todo: Transfer
  Future<dynamic> createTransfer({
    required int idAccountSender,
    required int idAccountReceiver,
    required double amount,
  }) async {
    final response = await TransferAnswer().createTransfer(
      idAccountSender: idAccountSender,
      idAccountReceiver: idAccountReceiver,
      amount: amount,
    );
    final response2 = await BankAccountAnswer()
        .putTransferAccount(idAccountSender, idAccountReceiver, amount);
    return response2;
  }
}
