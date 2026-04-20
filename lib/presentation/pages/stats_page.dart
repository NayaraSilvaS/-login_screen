import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:login_screen/presentation/stores/item_store.dart';
import 'package:characters/characters.dart';


class StatsPage extends StatefulWidget {
    final ItemStore store;


   StatsPage({super.key, required this.store});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

Map<String, int> _calculateStats() {
  int letters = 0;
  int numbers = 0;

  final letterRegex = RegExp(r'\p{L}', unicode: true);
  final numberRegex = RegExp(r'\p{N}', unicode: true);

  for (var item in widget.store.items) {
    for (var c in item.text.characters) {
      if (numberRegex.hasMatch(c)) {
        numbers++;
      } else if (letterRegex.hasMatch(c)) {
        letters++;
      }
    }
  }

  return {
    'letters': letters,
    'numbers': numbers,
  };
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Estatísticas"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 16,
            vertical: 16,
          ),
          child: Observer(
            builder: (_) {
              final stats = _calculateStats();

              final totalEdits =
                  widget.store.items.fold(0, (s, i) => s + i.edits);

              final totalChars =
                  widget.store.items.fold(0, (s, i) => s + i.text.length);

              return Column(
                children: [
                  _buildHeader(
                    widget.store.items.length,
                    totalEdits,
                    totalChars,
                    isSmall,
                    isTablet,
                  ),

                  SizedBox(height: isTablet ? 50 : 30),

                  Expanded(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (_, __) {
                        return _buildChart(
                          stats['letters']!,
                          stats['numbers']!,
                          animation.value,
                          size,
                        );
                      },
                    ),
                  ),

                  SizedBox(height: isTablet ? 30 : 16),

                  _buildLegend(isSmall),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      int items, int edits, int chars, bool isSmall, bool isTablet) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            Icons.list_alt,
            Colors.blue,
            "Itens",
            items.toString(),
            isSmall,
          ),
        ),
        Expanded(
          child: _statCard(
            Icons.edit,
            Colors.purple,
            "Edições",
            edits.toString(),
            isSmall,
          ),
        ),
        Expanded(
          child: _statCard(
            Icons.text_fields,
            Colors.green,
            "Caracteres",
            chars.toString(),
            isSmall,
          ),
        ),
      ],
    );
  }

  Widget _statCard(
      IconData icon, Color color, String title, String value, bool isSmall) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.all(isSmall ? 10 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF171A21),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: isSmall ? 20 : 28),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isSmall ? 11 : 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmall ? 16 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildChart(
      int letters, int numbers, double progress, Size size) {
    final maxValue =
        letters > numbers ? letters.toDouble() : numbers.toDouble();

    final maxHeight = size.height * 0.35;

    double getHeight(int value) {
      if (maxValue == 0) return 4;
      return (value / maxValue) * maxHeight * progress;
    }

    final barWidth = size.width * 0.18;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _bar(
          "Letras",
          letters,
          getHeight(letters),
          barWidth,
          const LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        _bar(
          "Números",
          numbers,
          getHeight(numbers),
          barWidth,
          const LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }

  Widget _bar(String label, int value, double height, double width,
      Gradient gradient) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _bubble(label, value),
        const SizedBox(height: 8),

        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height < 6 ? 6 : height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        const SizedBox(height: 10),

        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _bubble(String title, int value) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 11)),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        CustomPaint(
          size: const Size(10, 6),
          painter: _TrianglePainter(),
        )
      ],
    );
  }

  Widget _buildLegend(bool isSmall) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.blue, "Letras", isSmall),
        const SizedBox(width: 20),
        Container(width: 1, height: 20, color: Colors.white24),
        const SizedBox(width: 20),
        _legendItem(Colors.orange, "Números", isSmall),
      ],
    );
  }

  Widget _legendItem(Color color, String text, bool isSmall) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: isSmall ? 12 : 14,
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
