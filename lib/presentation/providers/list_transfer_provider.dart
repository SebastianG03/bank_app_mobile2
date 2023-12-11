import 'package:bank_mobile/config/helpers/bank_account_answer.dart';
import 'package:bank_mobile/config/helpers/transfer_answer.dart';
import 'package:bank_mobile/config/helpers/user_answer.dart';
import 'package:bank_mobile/infrastructure/models/bank_account_model.dart';
import 'package:bank_mobile/infrastructure/models/transfer_model.dart';
import 'package:bank_mobile/infrastructure/models/user_model.dart';
import 'package:flutter/material.dart';

class ListTransferProvider extends ChangeNotifier {
  List<TransferModel> transferencias = [];
  static UserModel? userSender;
  static UserModel? userReceiver;

  Future<void> getListTransfer(int idTransfer) async {
    final response = await TransferAnswer().getTransfer(idTransfer);
    transferencias = response;
    notifyListeners();
  }

  // Future<void> displayDialog(
  //     BuildContext context, TransferModel transfer) async {
  //   await getUsers(transfer);
  //   TransferDetailsPopUp.transferDetailsPopUp(
  //       context: context,
  //       transferModel: transfer,
  //       userSender: userSender!,
  //       userReceiver: userReceiver!);
  // }

  Future<void> getUsers(TransferModel transfer) async {
    final BankAccountModel accountReceiver = await BankAccountAnswer()
        .getAccountByUserId(transfer.idAccountReceiver);
    UserModel responseReceiver =
        await UserAnswer().getUserById(accountReceiver.idUser);
    final BankAccountModel accountSender =
        await BankAccountAnswer().getAccountByUserId(transfer.idAccountSender);
    UserModel responseSender =
        await UserAnswer().getUserById(accountSender.idUser);
    userSender = responseSender;
    userReceiver = responseReceiver;
    notifyListeners();
  }
}
