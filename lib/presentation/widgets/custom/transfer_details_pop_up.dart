import 'package:bank_mobile/infrastructure/models/transfer_model.dart';
import 'package:bank_mobile/infrastructure/models/user_model.dart';
import 'package:flutter/material.dart';

class TransferDetailsPopUp {
  static void transferDetailsPopUp({
    required BuildContext context,
    required TransferModel transferModel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        titlePadding: const EdgeInsets.all(15),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: _buildTitle(transferModel),
        content: _buildContent(transferModel),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  color: Color(0xFF374472),
                  fontSize: 18,
                ),
              )),
        ],
      ),
    );
  }

  static Widget _buildTitle(TransferModel transferModel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Monto: ${transferModel.amount.toString()} USD',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.account_balance,
            color: Color(0xFF374472),
            size: 20,
          ),
        )
      ],
    );
  }

  static Widget _buildContent(TransferModel transferModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Fecha: ${transferModel.dateIssue.day}/${transferModel.dateIssue.month}/${transferModel.dateIssue.year}',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Emisor: ${transferModel.idAccountSender.toString()}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            'Receptor: ${transferModel.idAccountReceiver.toString()}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
