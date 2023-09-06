import 'package:expense/widgets/new_transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> allTransactions;
  final Function deleteTransaction;
  final Function updateTransaction;

  const TransactionList(
      {super.key,
      required this.allTransactions,
      required this.deleteTransaction,
      required this.updateTransaction});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return allTransactions.isEmpty
          // No Transactions
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "It's lonely out here!",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 22.0,
                        fontFamily: "Quicksand",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.8,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.contain,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            )
          // Transactions Present
          : ListView.builder(
              itemCount: allTransactions.length,
              itemBuilder: (context, index) {
                Transaction txn = allTransactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 3.0),
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 1.0,
                      horizontal: 15.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.80,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                child: NewTransactionForm(
                                  addTransaction: (){},updateTransaction: updateTransaction,
                                ),
                              );
                            });
                      },
                      child: ListTile(
                        leading: Container(
                          width: 70.0,
                          height: 50.0,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.green[700],
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              '₹${txn.txnAmount}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          txn.txnTitle,
                          style: const TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('MMMM d, y -')
                              .add_jm()
                              .format(txn.txnDateTime),
                          // DateFormat.yMMMMd().format(txn.txnDateTime),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTransaction(txn.txnId),
                          tooltip: "Delete Transaction",
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
    });
  }
}
