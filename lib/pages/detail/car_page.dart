import 'package:carros/models/car.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'car_bloc.dart';

class CarPage extends StatefulWidget {
  Car _car;

  CarPage(this._car);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  CarBloc _bloc = CarBloc();

  @override
  void initState() {
    _bloc.loadLoremIpsum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(widget._car.nome),
      body: _body(context, widget._car),
    );
  }

  _body(BuildContext context, Car car) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _carImage(),
          _carTitle(),
          _carDescription(),
        ],
      ),
    );
  }

  Row _carTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget._car.nome,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget._car.tipo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: _bloc.onClickFavorite,
              iconSize: 44,
              color: Colors.red,
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: _bloc.onClickShare,
              iconSize: 44,
            ),
          ],
        )
      ],
    );
  }

  Container _carImage() {
    return Container(
      margin: EdgeInsets.all(24),
      width: double.infinity,
      child: Image.network(
        widget._car.urlFoto,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  _appBar(String title) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.place),
          onPressed: _bloc.onClickMap,
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: _bloc.onClickVideo,
        ),
        PopupMenuButton<String>(
          onSelected: _bloc.onClickPopupMenu,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: CarBloc.EDIT,
                child: Text('Editar'),
              ),
              PopupMenuItem(
                value: CarBloc.DELETE,
                child: Text('Deletar'),
              ),
              PopupMenuItem(
                value: CarBloc.SHARE,
                child: Text('Share'),
              ),
            ];
          },
        )
      ],
    );
  }

  _carDescription() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          Text(
            'Descrição ${widget._car.nome}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          StreamBuilder<String>(
            stream: _bloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return TextError('Erro ao acessar informações do servidor');
              }

              return Text(snapshot.data ?? ' ');
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
