import 'dart:io';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import '../ResponsiveWidgets/responsive_widgets.dart';
import './Widgets/newTransaction.dart';
import 'Models/Transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp]
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expanses',
      home: MyHomePage(),
      theme: ThemeData(
          primaryColor: Colors.blue[700],
          accentColor: Colors.blue[400],
          errorColor: Colors.redAccent,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                button:const TextStyle(color: Colors.white),
              ),
          // fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id:DateTime.now().toString() , amount: 50, date: DateTime.now(), title: "New Shoes"),
    // Transaction(
    //     id: DateTime.now().toString() , amount: 146757, date: DateTime.now(), title: "A diamond ring"),
    //      Transaction(
    //     id:DateTime.now().toString() , amount: 40, date: DateTime.now(), title: "A silver ring"),
    //      Transaction(
    //     id: DateTime.now().toString() , amount: 1000, date: DateTime.now(), title: "An application"),
  ];

  @override
void initState(){
WidgetsBinding.instance.addObserver(this);
  super.initState();
}
@override
 void didChangeAppLifecycleState(AppLifecycleState state){
print(state);

 }
 @override
 dispose(){
   WidgetsBinding.instance.removeObserver(this);
super.dispose();
 }


  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final txNew = Transaction(
        title: txTitle,
        amount: txAmount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(txNew);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  Widget build(BuildContext context) {
    //  final themeAcess=Theme.of(context);
    // final isLandScape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    // final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expanses'),
            trailing: Row (
              mainAxisSize: MainAxisSize.min,
              children:<Widget> [
              GestureDetector(
                child: const Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              )
            ],),
          )
        : AppBar(
            title:const Text("Personal Expanses"),
            actions: <Widget>[
              IconButton(
                icon:const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
   

    final bodyContent = SafeArea(child:SingleChildScrollView(
      //child:Container(),
      child: ResponsiveWidgets(appBar ,_userTransactions,_deleteTransaction,_recentTransactions),
    ),);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyContent,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyContent,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
