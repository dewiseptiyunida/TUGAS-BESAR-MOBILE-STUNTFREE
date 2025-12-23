class Artikel {
  final String id;
  final String judul;
  final String isi;
  final String gambar;
  final String createdAt;

  Artikel({
    required this.id,
    required this.judul,
    required this.isi,
    required this.gambar,
    required this.createdAt,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    const baseImageUrl =
        'https://pgdqcupfmoofpdjzpftf.supabase.co/storage/v1/object/public/artikel/';

    return Artikel(
      id: json['id_artikel'].toString(),
      judul: json['judul'] ?? '',
      isi: json['isi'] ?? '',
      gambar: json['gambar'] != null && json['gambar'] != ''
          ? baseImageUrl + json['gambar']
          : '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
