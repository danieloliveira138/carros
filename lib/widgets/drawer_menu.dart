import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Daniel de Jesus Oliveira'),
            accountEmail: Text('danieloliveira138@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://scontent.fssz2-1.fna.fbcdn.net/v/t1.0-9/48928995_537445950057067_7971421857851113472_n.jpg?_nc_cat=102&_nc_oc=AQm3ZxKChrap3QXyVf0E-d_2QLbuOI9qguVqIerZJz417eG-C6VjsPVUiH1bKYBpFOY&_nc_ht=scontent.fssz2-1.fna&oh=19383957fce1baed5b264a41f05f8920&oe=5DCFF7CA"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Favoritos'),
            subtitle: Text('Tela de lista de favoritos'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.picture_in_picture),
            title: Text('Fotos do mês'),
            subtitle: Text('Veja as melhores fotos do mês'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            subtitle: Text('Configure o App para sua melhor experiência.'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _onClickLogout(context),
          ),
          Center(
            child: Text("Hello word")
          )
        ],
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    nav(context, LoginPage(), replace: true);
    return;
  }
}
