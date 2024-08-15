class SlideInfo{
  final String title;
  final String caption;
  final String imageURL;

  SlideInfo({
    required this.title,
    required this.caption,
    required this.imageURL
  });
}

final List<SlideInfo> slides = [
  SlideInfo(title: 'Ranita chikiada!', caption:'Se ha chokiado la ranita :v', imageURL: 'assets/images/iguana.jpg'),
  SlideInfo(title: 'title2', caption:'caption', imageURL: 'assets/images/iguana.jpg'),
  SlideInfo(title: 'title2', caption:'caption', imageURL: 'assets/images/iguana.jpg'),
];