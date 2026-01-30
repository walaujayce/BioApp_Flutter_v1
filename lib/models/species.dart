class Species{
  final String id;
  final String speciesName;
  final String imageUrl;
  final bool isUploaded;
  final DateTime imageTakenTime;
  final double latitude;
  final double longitude;
  final String? description;
  final bool isLocalImage;

  const Species({
    required this.id,
    required this.speciesName,
    required this.imageUrl,
    this.isUploaded = false,
    required this.imageTakenTime,
    required this.latitude,
    required this.longitude,
    this.description,
    this.isLocalImage = false
  });

  Species copyWith({
    String? id,
    String? speciesName,
    String? imageUrl,
    bool? isUploaded,
    DateTime? imageTakenTime,
    double? latitude,
    double? longitude,
    String? description,
    bool? isLocalImage,
}){
    return Species(
      id: id ?? this.id,
      speciesName: speciesName ?? this.speciesName,
      imageUrl: imageUrl ?? this.imageUrl,
      isUploaded: isUploaded ?? this.isUploaded,
      imageTakenTime: imageTakenTime ?? this.imageTakenTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
      isLocalImage: isLocalImage ?? this.isLocalImage,
    );
  }
}

List<Species> speciesTemplateList = [
  Species(
    id: "1",
    speciesName: "山茶花",
    imageUrl: "assets/images/bai_cha_hua.jpg",
    isUploaded: true,
    imageTakenTime: DateTime.now().add(const Duration(hours: 50)),
    latitude: 25.08171299406442,
    longitude: 121.23214863645964,
    description: "白色的山茶花",
  ),
  Species(
    id: "2",
    speciesName: "山茶花",
    imageUrl: "assets/images/hong_cha_hua.jpg",
    isUploaded: true,
    imageTakenTime: DateTime.now().subtract(const Duration(hours: 20)),
    latitude: 24.154618057219977,
    longitude: 120.66976444322164,
  ),
  Species(
    id: "3",
    speciesName: "Hydrangeas",
    imageUrl: "assets/images/xiu_qiu_hua.jpg",
    isUploaded: true,
    imageTakenTime: DateTime.now().subtract(const Duration(hours: 20)),
    latitude: 24.154618057219977,
    longitude: 120.66976444322164,
    description: "Tiffany blue flower.",
  ),
  // Species(
  //   id: "4",
  //   speciesName: "銀喉長尾山雀",
  //   imageUrl: "assets/images/xue_zhi_yao_jing.jpg",
  //   isUploaded: true,
  //   imageTakenTime: DateTime.now(),
  //   latitude: 22.6272351184457,
  //   longitude: 120.30199430392332,
  //   description: "雪之妖精",
  // ),
  // Species(
  //   id: "5",
  //   speciesName: "老鷹",
  //   imageUrl: "assets/images/lao_ying.jpg",
  //   isUploaded: true,
  //   imageTakenTime: DateTime.now(),
  //   latitude: 22.6272351184457,
  //   longitude: 120.30199430392332,
  // ),
  // Species(
  //   id: "6",
  //   speciesName: "天鵝",
  //   imageUrl: "assets/images/tian_er.png",
  //   isUploaded: true,
  //   imageTakenTime: DateTime.now(),
  //   latitude: 22.6272351184457,
  //   longitude: 120.30199430392332,
  //   description:
  //       "This picture shown a flying swarm on a lake. They are usually spotted in the morning. They are usually white as adult but black as child.",
  // ),
  // Species(
  //   id: "7",
  //   speciesName: "天鵝2",
  //   imageUrl: "assets/images/tian_er.png",
  //   isUploaded: true,
  //   imageTakenTime: DateTime.now(),
  //   latitude: 22.6272351184457,
  //   longitude: 120.30199430392332,
  //   description:
  //       "This picture shown a flying swarm on a lake. They are usually spotted in the morning. They are usually white as adult but black as child.",
  // ),
  // Species(
  //   id: "8",
  //   speciesName: "天鵝3",
  //   imageUrl: "assets/images/tian_er.png",
  //   isUploaded: true,
  //   imageTakenTime: DateTime.now(),
  //   latitude: 22.6272351184457,
  //   longitude: 120.30199430392332,
  //   description:
  //       "This picture shown a flying swarm on a lake. They are usually spotted in the morning. They are usually white as adult but black as child.",
  // ),
  // Species(
  //   id: "9",
  //   speciesName: "天鵝4",
  //   imageUrl: "assets/images/tian_er.png",
  //   isUploaded: true,
  //   imageTakenTime: DateTime.now(),
  //   latitude: 22.6272351184457,
  //   longitude: 120.30199430392332,
  //   description:
  //       "This picture shown a flying swarm on a lake. They are usually spotted in the morning. They are usually white as adult but black as child.",
  // ),
];