
class Film {

  String name;
  String year;
  String genre;
  String artist;

	Film.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		year = map["year"],
		genre = map["genre"],
		artist = map["artist"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['year'] = year;
		data['genre'] = genre;
		data['artist'] = artist;
		return data;
	}
}
