class DashboardStatModel {
  const DashboardStatModel({
    required this.icon,
    required this.value,
    required this.label,
    this.isSvg = true,
  });
  final String icon;
  final String value;
  final String label;
  final bool isSvg;
}
