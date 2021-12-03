class Usuario {
  final int id;
  final String nombre;
  final String email;
  final bool activo;
  final String createdAt;
  final String updatedAt;

  Usuario({
    required this.id, 
    required this.activo, 
    required this.nombre,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Usuario.fromJson(Map json) {
    return Usuario(
      id: json["id"], 
      nombre: json["nombre"], 
      email: json["email"],
      activo: json["activo"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

}
