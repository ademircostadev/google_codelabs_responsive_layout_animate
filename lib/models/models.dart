class Attachment {
  final String url;

  Attachment({required this.url});
}

class Email {
  final User sender;
  final List<User> recipients;
  final String subject, content;
  final List<Attachment> attachments;
  final double replies;

  Email(
      {required this.sender,
        required this.recipients,
        required this.subject,
        required this.content,
        this.attachments = const [],
        this.replies = 0});
}

class Name {
  final String first;
  final String last;

  String get fullName => '$first $last';

  Name({
    required this.first,
    required this.last,
  });
}

class User {
  final Name name;
  final String avatarUrl;
  final DateTime lastActive;

  User({
    required this.name,
    required this.avatarUrl,
    required this.lastActive,
  });
}