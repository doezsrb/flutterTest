// ignore_for_file: file_names

class City {
  const City({required this.image, required this.name, required this.km});
  final String image;
  final String name;
  final String km;

  static List<City> fakeData() {
    return <City>[
      const City(image: '', name: 'Belgrade', km: '1'),
      const City(image: '', name: 'Novi Sad', km: '69'),
      const City(image: '', name: 'Uzice', km: '115'),
      const City(image: '', name: 'Cukarica Urban Municipality', km: '16'),
    ];
  }
}
