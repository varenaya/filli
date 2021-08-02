class UserData {
  late String username;
  late String email;
  late String userId;
  late String imageUrl;
  late String coverUrl;
  late Map status;
  late Map online;
  late List companies;
  late List invitation;
  late List projects;

  UserData(
      {required this.email,
      required this.username,
      required this.userId,
      required this.imageUrl,
      required this.coverUrl,
      required this.online,
      required this.status,
      required this.companies,
      required this.projects,
      required this.invitation});
}
