import 'package:bank_mobile/config/helpers/bank_account_answer.dart';
import 'package:bank_mobile/config/helpers/transfer_answer.dart';
import 'package:bank_mobile/infrastructure/form_validations/forms_validations.dart';
import 'package:flutter/material.dart';

class TransferProvider extends ChangeNotifier {
  final AccountValidator accountValidator = AccountValidator();
  final AmountValidator amountValidator = AmountValidator();

  Future<dynamic> createTransfer({
    required BuildContext context,
    required int idAccountSender,
    required int idAccountReceiver,
    required double amount,
  }) async {
    final response = await BankAccountAnswer().putTransferAccount(
        context, idAccountSender, idAccountReceiver, amount);

    if (response != null) {
      await TransferAnswer().createTransfer(
        idAccountSender: idAccountSender,
        idAccountReceiver: idAccountReceiver,
        amount: amount,
      );
    }

    return response;
  }
}
