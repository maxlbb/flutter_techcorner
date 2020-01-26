abstract class FilterEvent {}

class BrandFilterEvent extends FilterEvent {
  final String brand;

  BrandFilterEvent(this.brand);
}

class StatusFilterEvent extends FilterEvent {
  final String status;

  StatusFilterEvent(this.status);
}
