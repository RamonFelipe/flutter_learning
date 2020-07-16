import 'package:flutter/material.dart';

import '../widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? _buildLayoutBuilder() : _buildListView();
  }

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png'),
          ),
        ],
      );
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionItem(
            transaction: transactions[index],
            deleteTransaction: deleteTransaction);
      },
    );
  }
}
