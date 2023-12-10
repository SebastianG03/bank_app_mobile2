import 'package:bank_mobile/config/helpers/bank_account_answer.dart';
import 'package:bank_mobile/config/helpers/user_answer.dart';
import 'package:bank_mobile/infrastructure/models/bank_account_model.dart';
import 'package:bank_mobile/infrastructure/models/transfer_model.dart';
import 'package:bank_mobile/infrastructure/models/user_model.dart';
import 'package:flutter/material.dart';

class TransferDetailsProvider extends ChangeNotifier {
  final _accountAnswer = BankAccountAnswer();
  final _userAnswer = UserAnswer();
  static UserModel? userSender;
  static UserModel? userReceiver;

  BankAccountProvider({required TransferModel transfer}) {
    initialize(transfer);
  }

  Future<void> initialize(TransferModel transfer) async {
    final BankAccountModel accountReceiver =
        await _accountAnswer.getAccountByAccountId(transfer.idAccountReceiver);
    UserModel responseReceiver =
        await _userAnswer.getUserById(accountReceiver.idUser);
    final BankAccountModel accountSender =
        await _accountAnswer.getAccountByAccountId(transfer.idAccountSender);
    UserModel responseSender =
        await _userAnswer.getUserById(accountSender.idUser);
    userSender = responseSender;
    userReceiver = responseReceiver;
    notifyListeners();
  }
}
