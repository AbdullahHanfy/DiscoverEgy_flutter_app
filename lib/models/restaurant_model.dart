class Restaurant {
  String imageUrl;
  String name;
  String specialDiets;
  double rate;

  Restaurant({this.imageUrl, this.name, this.specialDiets, this.rate});
}

final List<Restaurant> restaurants = [
  Restaurant(
      imageUrl:
          'https://media-cdn.tripadvisor.com/media/photo-s/16/9e/c7/79/testi-kebab-tavuk-jarra.jpg',
      name: 'Nisantasi',
      specialDiets: 'Turkish',
      rate: 4.5)
];
