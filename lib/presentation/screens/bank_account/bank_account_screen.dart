import 'package:bank_mobile/presentation/providers/bank_account_provider.dart';
import 'package:bank_mobile/presentation/screens/list_transfer/list_transfer_screen.dart';
import 'package:bank_mobile/presentation/screens/transfer/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccountScreen extends StatefulWidget {
  static const String name = 'bank_account_screen';
  final int user;

  const BankAccountScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BankAccountProvider>(
          lazy: false,
          create: (_) {
            final bankAccountProvider = BankAccountProvider(user: widget.user);
            return bankAccountProvider;
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bank Account Details'),
        ),
        body: SafeArea(
          child: SizedBox(
            height: height * 0.3,
            width: width * 0.95,
            child: BankAccountDetailsWidget(
              user: widget.user,
            ),
          ),
        ),
      ),
    );
  }
}

class BankAccountDetailsWidget extends StatelessWidget {
  final int user;

  const BankAccountDetailsWidget({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bankAccountProvider = Provider.of<BankAccountProvider>(context);
    bankAccountProvider.initialize();

    final bankAccount = bankAccountProvider.bankAccount;

    if (bankAccount != null) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListTransferScreen(
              idAccount: bankAccount.idAccount,
            ),
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Numero de Cuenta bancaria: ${bankAccount.idAccount}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Numero del usuario: ${bankAccount.idUser}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Tipo de cuenta: ${bankAccount.accountNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Cantidad: ${bankAccount.accountAmount}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransferScreen(
                              user: user,
                              idAccountSender: bankAccount.idAccount,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.currency_exchange),
                      label: const Text(
                        'Transferir',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
