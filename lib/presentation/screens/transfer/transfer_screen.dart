import 'package:bank_mobile/presentation/providers/transfer_provider.dart';
import 'package:bank_mobile/presentation/widgets/shared/pop_up/pop_up_general.dart';
import 'package:bank_mobile/presentation/widgets/inputs/inputs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatelessWidget {
  final int user;
  final int idAccountSender;

  const TransferScreen({
    Key? key,
    required this.user,
    required this.idAccountSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TransferProvider>(
          lazy: false,
          create: (_) => TransferProvider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transferencia'),
        ),
        body: SafeArea(
            child: TransferBody(user: user, idAccountSender: idAccountSender)),
      ),
    );
  }
}

class TransferBody extends StatefulWidget {
  final int user;
  final int idAccountSender;

  const TransferBody({
    Key? key,
    required this.user,
    required this.idAccountSender,
  }) : super(key: key);

  @override
  _TransferBodyState createState() =>
      _TransferBodyState(user: user, idAccountSender: idAccountSender);
}

class _TransferBodyState extends State<TransferBody> {
  final int user;
  final int idAccountSender;
  late int idAccountReceiver;
  late double amount;

  _TransferBodyState({required this.user, required this.idAccountSender});

  @override
  Widget build(BuildContext context) {
    final transferProvider = context.watch<TransferProvider>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          TextFormsModel(
            textInputType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: 'Cuenta de destino',
                icon: Icon(FontAwesomeIcons.person)),
            onChanged: (String value) =>
                idAccountReceiver = int.tryParse(value.trim()) ?? 0,
            validator: (String? value) {
              transferProvider.accountValidator.validate(value: value!);
              return transferProvider.accountValidator.erroMessage;
            },
          ),
          const SizedBox(height: 20),
          TextFormsModel(
            textInputType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Monto',
              icon: Icon(FontAwesomeIcons.dollarSign),
            ),
            onChanged: (String value) =>
                amount = double.tryParse(value.trim()) ?? 0,
            validator: (String? value) {
              transferProvider.amountValidator.validate(value: value!);
              return transferProvider.amountValidator.erroMessage;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await transferProvider.createTransfer(
                  context: context,
                  idAccountSender: widget.idAccountSender,
                  idAccountReceiver: idAccountReceiver,
                  amount: amount,
                );
                Navigator.of(context).pop();
              } else {
                PopUpGeneral.showMessage(context,
                    'Datos inválidos. No se pudo realizar la transferencias');
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear Transferencia'),
          ),
        ],
      ),
    );
  }
}
