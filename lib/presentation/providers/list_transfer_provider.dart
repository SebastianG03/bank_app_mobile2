import 'package:bank_mobile/config/helpers/transfer_answer.dart';
import 'package:bank_mobile/infrastructure/models/transfer_model.dart';
import 'package:flutter/material.dart';

class ListTransferProvider extends ChangeNotifier {
  List<TransferModel> transferencias = [];

  Future<void> getListTransfer(int idTransfer) async {
    final response = await TransferAnswer().getTransfer(idTransfer);
    transferencias = response;
    notifyListeners();
  }
}
