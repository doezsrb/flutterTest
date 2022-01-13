class Dest {
  Dest({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  static List<Dest> getFakeData() {
    return <Dest>[
      Dest(title: 'Phoenix', subtitle: 'Arizona'),
      Dest(title: 'Hot Springs', subtitle: 'Arkansas'),
      Dest(title: 'Los Angeles', subtitle: 'California'),
      Dest(title: 'San Diego', subtitle: 'California'),
      Dest(title: 'San Francisco', subtitle: 'California'),
      Dest(title: 'Barcelona', subtitle: 'Catalonia'),
    ];
  }
}
