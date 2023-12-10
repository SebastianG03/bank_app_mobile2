import 'package:bank_mobile/infrastructure/models/transfer_model.dart';
import 'package:bank_mobile/presentation/providers/list_transfer_provider.dart';
import 'package:bank_mobile/presentation/widgets/custom/transfer_details_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTransferScreen extends StatefulWidget {
  final int idAccount;

  const ListTransferScreen({Key? key, required this.idAccount})
      : super(key: key);

  @override
  _ListTransferScreenState createState() => _ListTransferScreenState();
}

class _ListTransferScreenState extends State<ListTransferScreen> {
  late ListTransferProvider listTransferProvider;

  @override
  void initState() {
    super.initState();
    listTransferProvider = ListTransferProvider();
    listTransferProvider
        .getListTransfer(widget.idAccount); // Inicialización aquí
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListTransferProvider>(
      lazy: false,
      create: (_) => listTransferProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de transferencias'),
        ),
        body: ListTransferBody(idAccount: widget.idAccount),
      ),
    );
  }
}

class ListTransferBody extends StatelessWidget {
  final int idAccount;

  const ListTransferBody({
    Key? key,
    required this.idAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listTransferProvider = context.watch<ListTransferProvider>();
    final List<TransferModel> listTransfer =
        listTransferProvider.transferencias;

    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: listTransfer.length,
      itemBuilder: (context, i) => ListTile(
        title: Text('Transferencia ${listTransfer[i].idTransfer}'),
        subtitle: Text('Monto: ${listTransfer[i].amount.toString()}'),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        onTap: () => TransferDetailsPopUp.transferDetailsPopUp(
            context: context, transferModel: listTransfer[i]),
      ),
      separatorBuilder: (_, __) => const Divider(
        height: 10,
      ),
    );
  }
}
