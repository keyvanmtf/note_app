class Note {
  String id;
  String title;
  String content;
  // DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    // required this.modifiedTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // ایجاد Note از Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
