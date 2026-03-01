import 'package:flutter/cupertino.dart';

class VilleDetailScreen extends StatefulWidget {
  final String cityName; // ← ajout du paramètre

  const VilleDetailScreen({super.key, required this.cityName}); // ← ajout ici

  @override
  State<VilleDetailScreen> createState() => _VilleDetailScreenState();
}

class _VilleDetailScreenState extends State<VilleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Tu peux accéder à la ville avec : widget.cityName
    return const Placeholder();
  }
}