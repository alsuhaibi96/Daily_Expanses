//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Models/Transaction.dart';
import '../Widgets/Transaction_Item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  const TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                 const SizedBox(height: 50),
                  Container(
                      height: constrains.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (transContext, index) {
              return TransactionItem(userTransaction: _userTransactions[index], deleteTx: _deleteTx);
            },
            itemCount: _userTransactions.length,
          );
  }
}

  

