class StatusFilter {

  final String status;
  bool isSelected;

  StatusFilter(this.status, this.isSelected);

  static const String FEATURED = "FEATURED";
  static const String NEW = "NEW";
  static const String UPCOMING = "UPCOMING";
}