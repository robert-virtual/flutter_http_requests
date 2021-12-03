import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_request/models/usuario.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 10.0.2.2 = localhost = 127.0.0.1

  final url = Uri.parse("http://10.0.2.2:3030/usuarios");

  late Future<List<Usuario>> usuarios;
  final nombre = TextEditingController();
  final email = TextEditingController();
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  @override
  void initState() {
    super.initState();
    usuarios = getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: FutureBuilder<List<Usuario>>(
          future: usuarios,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(snap.data![i].nombre),
                          subtitle: Text(snap.data![i].email),
                        ),
                        const Divider()
                      ],
                    );
                  });
            }
            if (snap.hasError) {
              return const Center(
                child: Text("Ups ha habido un error"),
              );
            }

            return const CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarUsuario,
        child: const Icon(Icons.add),
      ),
    );
  }

  void agregarUsuario() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Crear Usuario"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(hintText: "Nombre"),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    crearUsuario();
                  },
                  child: const Text("Guardar")),
            ],
          );
        });
  }

  Future<List<Usuario>> getUsuarios() async {
    final res = await http.get(url);
    List datos = List.from(jsonDecode(res.body));

    final lista = datos.map((user) => Usuario(
        id: user["id"],
        activo: user["activo"],
        nombre: user["nombre"],
        email: user["email"],
        createdAt: user["createdAt"],
        updatedAt: user["updatedAt"]));
    return lista.toList();
  }

  void crearUsuario() async {
    final usuario = {'nombre': nombre.text, 'email': email.text};
    await http.post(url, headers: headers, body: jsonEncode(usuario));
    nombre.clear();
    email.clear();
    setState(() {
      usuarios = getUsuarios();
    });
  }
}
