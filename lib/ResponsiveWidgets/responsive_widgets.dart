import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
//import '../Widgets/newTransaction.dart';
import '../Widgets/Transaction_List.dart';
import '../Widgets/chart.dart';
import '../Models/Transaction.dart';

class ResponsiveWidgets extends StatefulWidget {
   ResponsiveWidgets(this.appBar, this.userTransactions, this.deleteTransaction, this.recentTransactions);
   final appBar ;
 final List<Transaction> userTransactions; 
  final Function deleteTransaction; 
  final List<Transaction> recentTransactions;
  @override
  _ResponsiveWidgetsState createState() => _ResponsiveWidgetsState();
}
 bool _showChart = false;
class _ResponsiveWidgetsState extends State<ResponsiveWidgets> {
 

  @override
  Widget build(BuildContext context) {
   
        final isLandScape =MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaQuery = MediaQuery.of(context);
  
     final txListWidget = Container(
        height: (mediaQuery.size.height -
                widget.appBar.preferredSize.height-
                mediaQuery.padding.top) *
            0.6,
        child: TransactionList(widget.userTransactions,widget.deleteTransaction));

    return  Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart ?',style: Theme.of(context).textTheme.headline6,),
                Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
          if (!isLandScape)
            Container(
                height: (mediaQuery.size.height -
                        widget.appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(widget.recentTransactions)),
          if (!isLandScape) txListWidget,
          if (isLandScape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            widget.appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(widget.recentTransactions))
                : txListWidget,

// ),
        ],
      );
  }
}