String? transformDate(DateTime? date) {
  if (date == null) return null;
  return "${date.day}/${date.month}/${date.year}";
}

DateTime toDateTime(String date) {
  final d = date.split('/');
  return DateTime(int.parse(d[2]),int.parse(d[1]),int.parse(d[0]),);
}