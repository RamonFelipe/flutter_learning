// naotemsenha132
// r/material.dart';1
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_produtct_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false).removeItem(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Delete failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
// jriurrjt
// joao pedro
// 0jefjjd g fmamikrujtjt rnfgbyhvjghggjdujfjfjf
// bomdia
// itrutgi8h8tgu8ttit
// ttiitifujrujr
// uriririririkt
// toyoytoyoy
// i6ii9yiy7iyi6i6
// 'y6ititu585u
// i5itu7t58675785

// 6tuhti
