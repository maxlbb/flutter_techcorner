class StatusFilter {
  final String status;

  StatusFilter(this.status);

  static const String FEATURED = "FEATURED";
  static const String NEW = "NEW";
  static const String UPCOMING = "UPCOMING";

  static List<StatusFilter> get getStatusList => <StatusFilter>[
        StatusFilter(FEATURED),
        StatusFilter(NEW),
        StatusFilter(UPCOMING)
      ];
}
