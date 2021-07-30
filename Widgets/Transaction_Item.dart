import 'package:flutter/material.dart';
import '../Models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required Transaction userTransaction,
    @required Function deleteTx,
  }) : _userTransaction = userTransaction, _deleteTx = deleteTx, super(key: key);

  final Transaction _userTransaction;
  final Function _deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      child: ListTile(
        leading: CircleAvatar(
          //  maxRadius: 70,
          // minRadius: 50,
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
                child: Text('\$${_userTransaction.amount}',
                    style:const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold)

                    //TextStyle(color: Colors.black),
                    )),
          ),
        ),
        title: Text(_userTransaction.title,
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          DateFormat.yMMMMEEEEd()
              .format(_userTransaction.date),
        ),

        // ignore: missing_required_param
        trailing: MediaQuery.of(context).size.width > 400
            // ignore: deprecated_member_use
            // ignore: missing_required_param
            // ignore: deprecated_member_use
            ? FlatButton.icon(
              icon:const Icon(Icons.delete),
              textColor: Theme.of(context).errorColor,
              label: const Text('Delete'),
                onPressed: () =>
                    _deleteTx(_userTransaction.id))
            
            : IconButton(
                icon:const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    _deleteTx(_userTransaction.id)),
      ),
    );
  }}