import 'dart:convert';
import 'package:carros/models/car.dart';
import 'package:http/http.dart' as http;

class CarsApi {

  static final String baseUrl = 'https://carros-springboot.herokuapp.com/api/v1/carros';

  static final String CLASSICOS = '/tipo/classicos';

  static final String LUXO = '/tipo/luxo';

  static final String ESPORTIVOS = '/tipo/esportivos';

  static Future<List<Car>> getListCars({type}) async {

    try {

      String url = type != null ? baseUrl + type : baseUrl;

      var response = await http.get(url);

      List mapResponse = json.decode(response.body);

      return mapResponse.map<Car>((map) => Car.fromJson(map)).toList();

    } catch (error) {

      return null;

    }

  }

  static Future<List<Car>> mockListCar() async {

    await Future.delayed(Duration(seconds: 2));

    return [
      Car(
          nome: 'Ferrari 250 GTO',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Ferrari_250_GTO.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Bel-Air',
          urlFoto:
              'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Impala Coupe',
          urlFoto:
              'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Impala_Coupe.png',
          tipo: "classicos"),
      Car(
          nome: 'Cadillac Deville Convertible',
          urlFoto:
              'http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Bel-Air',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Impala Coupe',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Impala_Coupe.png',
          tipo: "classicos"),
      Car(
          nome: 'Cadillac Deville Convertible',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Bel-Air',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Impala Coupe',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Impala_Coupe.png',
          tipo: "classicos"),
      Car(
          nome: 'Cadillac Deville Convertible',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Bel-Air',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png',
          tipo: "classicos"),
      Car(
          nome: 'Chevrolet Impala Coupe',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_Impala_Coupe.png',
          tipo: "classicos"),
      Car(
          nome: 'Cadillac Deville Convertible',
          urlFoto:
          'http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png',
          tipo: "classicos"),
    ];
  }
}
