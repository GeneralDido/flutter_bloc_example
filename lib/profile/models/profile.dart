class Profile {
  final String name;
  final int age;

  const Profile({
    required this.name,
    required this.age,
  });

  Profile copyWith({String? name, int? age}) {
    return Profile(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}