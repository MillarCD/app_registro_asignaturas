String? transformDate(DateTime? date) {
  if (date == null) return null;
  return "${date.day}/${date.month}/${date.year}";
}
