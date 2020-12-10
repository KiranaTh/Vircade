class Score {
  final int id;
  final String name;
  final String imageUrl;
  final String score;

  Score({
    this.id,
    this.name,
    this.imageUrl,
    this.score,
  });
}

final Score sam = Score(
    id: 0,
    name: 'Laxed Siren Beat Loop',
    imageUrl: 'assets/video1.jpg',
    score: '93248');
final Score steven = Score(
    id: 1, name: 'Treasure', imageUrl: 'assets/video1.jpg', score: '78697');
final Score olivia = Score(
    id: 2,
    name: 'Cha Cha Slide',
    imageUrl: 'assets/video1.jpg',
    score: '66757');
final Score john = Score(
    id: 3, name: 'Like that', imageUrl: 'assets/video1.jpg', score: '57678');
final Score greg = Score(
    id: 4,
    name: 'Cha Cha Slide',
    imageUrl: 'assets/video1.jpg',
    score: '49677');
final Score emma = Score(
    id: 5, name: 'Like that', imageUrl: 'assets/video1.jpg', score: '465');
final Score dean = Score(
    id: 6, name: 'Treasure', imageUrl: 'assets/video1.jpg', score: '432');
final Score tiffany = Score(
    id: 7, name: 'Plain Jane', imageUrl: 'assets/video1.jpg', score: '343');
final Score jessica = Score(
    id: 8, name: 'Plain Jane', imageUrl: 'assets/video1.jpg', score: '214');
final Score krystal = Score(
    id: 9, name: 'Lose Control', imageUrl: 'assets/video1.jpg', score: '156');

// FAVORITE CONTACTS
List<Score> tops = [
  sam,
  steven,
  olivia,
  john,
  greg,
  emma,
  dean,
  tiffany,
  jessica,
  krystal
];
