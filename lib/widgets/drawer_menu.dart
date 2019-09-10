import 'package:carros/models/user.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<User> future = User.loadUser();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<User>(
              future: future,
              builder: (context, snapshot) {
                User user = snapshot.data;
                return user != null ? _header(user) : Container();
              },
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
          ],
        ),
      ),
    );
  }

  _header(User user) {
    return UserAccountsDrawerHeader(
          accountName: Text(user.nome),
          accountEmail: Text(user.email),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
              user.urlFoto
            ),
          ),
        );
  }

  _onClickLogout(BuildContext context) {
    User.clear();
    Navigator.pop(context);
    nav(context, LoginPage(), replace: true);
    return;
  }
}
