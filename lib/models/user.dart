class User {
  final int? id;
  final String email;
  final String password;
  final String cpf;
  final String nome;
  final String dataNascimento; // 'YYYY-MM-DD'
  final String tipoUsuario;    // 'USER' ou 'ADMIN'
  final String createdAt;
  final String updatedAt;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.cpf,
    required this.nome,
    required this.dataNascimento,
    this.tipoUsuario = 'USER',
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'cpf': cpf,
      'nome': nome,
      'data_nascimento': dataNascimento,
      'tipo_usuario': tipoUsuario,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      email: map['email'] as String,
      password: map['password'] as String,
      cpf: map['cpf'] as String,
      nome: map['nome'] as String,
      dataNascimento: map['data_nascimento'] as String,
      tipoUsuario: map['tipo_usuario'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
