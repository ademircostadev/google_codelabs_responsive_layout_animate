import 'package:google_codelabs_responsive_layout_animado/consts/image_repository.dart';
import 'package:google_codelabs_responsive_layout_animado/models/models.dart';

final User user_0 = User(
  name: Name(first: 'Me', last: '2'),
  avatarUrl: avatar01,
  lastActive: DateTime.now(),
);

final User user_1 = User(
  name: Name(first: '老', last: '强'),
  avatarUrl: avatar02,
  lastActive: DateTime.now().subtract(
    const Duration(seconds: 420),
  ),
);

final User user_2 = User(
  name: Name(first: 'So', last: 'Duri'),
  avatarUrl: avatar03,
  lastActive: DateTime.now().subtract(
    const Duration(seconds: 1620),
  ),
);

final User user_3 = User(
  name: Name(first: 'Lily', last: 'McDonald'),
  avatarUrl: avatar04,
  lastActive: DateTime.now().subtract(
    const Duration(minutes: 420),
  ),
);

final User user_4 = User(
  name: Name(first: 'Ziad', last: 'Aouad'),
  avatarUrl: avatar05,
  lastActive: DateTime.now().subtract(
    const Duration(hours: 420),
  ),
);

final List<Email> emails = [
  Email(
    sender: user_1,
    recipients: [],
    subject: '豆花鱼',
    content: '最近忙吗？昨晚我去了你最爱的那家饭馆，点了他们的特色豆花鱼，吃着吃着就想你了。',
  ),
  Email(
      sender: user_2,
      recipients: [],
      subject: 'Dinner Club',
      content: 'I think it\'s time for us to finally try that new noodle shop downtown that doesn\'t use menus. Anyone else have other suggestions for dinner club this week? I\'m so intrigued by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)\n\nSo'),
  Email(
      sender: user_3,
      recipients: [],
      subject: '',
      content: 'Ping– you\'d love this new food show I started watching. It\'s produced by a Thai drummer who started getting recognized for the amazing vegan food she always brought to shows.',
  attachments: [Attachment(url: thumbnail01)]),
  Email(
      sender: user_4,
      recipients: [],
      subject: 'Volunteer EMT with me?',
      content: 'What do you think about training to be volunteer EMTs? We could do it together for moral support. Think about it??.'),
];

List<Email> replies = [
  Email(
    sender: user_2,
    recipients: [
      user_3,
      user_2,
    ],
    subject: 'Re: Happyhour',
    content: 'Lets GO',
  ),
  Email(
    sender: user_0,
    recipients: [
      user_3,
      user_2,
    ],
    subject: 'Re: Happyhour',
    content: 'Go Go Go Go',
  ),



];
