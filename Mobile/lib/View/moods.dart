import 'package:flutter/cupertino.dart';
import 'package:mobile/View/widgets/navbar.dart';

class MoodsView extends StatefulWidget {
  const MoodsView({Key? key}) : super(key: key);

  @override
  _MoodsViewState createState() => _MoodsViewState();
}

class _MoodsViewState extends State<MoodsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Navbar(),
    );
  }
}
