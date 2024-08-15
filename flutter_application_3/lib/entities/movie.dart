class Movie {
  String id;
  String titile; 
  String director;
  int ano;
  String? poster;

  Movie({
    required this.id,
    required this.director, 
    required this.ano, 
    required this.titile,
    this.poster
    });
}