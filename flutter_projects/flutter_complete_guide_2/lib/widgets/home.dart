import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide_2/widgets/chart.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = _getAppBar(context);
    final pageBody = _getPageBody(context, appBar.preferredSize.height);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }

void _addTransaction(String title, double amount, DateTime chosenDate) {
    final Transaction transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      return _userTransactions
          .removeWhere((transaction) => transaction.id == id);
    });
  }

  Widget _getChart({double sizeOccupedSpace, double height}) {
    return Container(
      height: sizeOccupedSpace * 0.3,
      child: Chart(_recentTransactions),
    );
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? SafeArea(
            child: CupertinoNavigationBar(
              middle: Text('Personal Expenses'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () => _startAddNewTransaction(context),
                  ),
                ],
              ),
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    return appBar;
  }

  Widget _getPageBody(BuildContext context, double appBarPreferredSizeHeight) {
    final mediaQueryContext = MediaQuery.of(context);
    final sizeOccupedSpace = mediaQueryContext.size.height -
        appBarPreferredSizeHeight -
        mediaQueryContext.padding.top;
    final bool isLandscape =
        mediaQueryContext.orientation == Orientation.landscape;
    final Widget transactionsListWidget = Container(
      height: sizeOccupedSpace * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.title,
                ),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (switchState) {
                    setState(() {
                      _showChart = switchState;
                    });
                  },
                )
              ],
            ),
          if (!isLandscape)
            _getChart(sizeOccupedSpace: sizeOccupedSpace, height: 0.3),
          if (!isLandscape) transactionsListWidget,
          if (isLandscape)
            _showChart
                ? _getChart(sizeOccupedSpace: sizeOccupedSpace, height: 0.7)
                : transactionsListWidget,
        ],
      ),
    );
  }
}
