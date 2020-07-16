import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // bool _isLoading = false;

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then(
  //     (_) async {
  //       setState(() {
  //         _isLoading = true;
  //       });

  //       await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();

  //       setState(() {
  //         _isLoading = false;
  //       });
  //     },
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        builder: (ctx, datasnapshot) {
          if (datasnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (datasnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
      ),
    );
  }
}
