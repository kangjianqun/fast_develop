import 'package:flutter/widgets.dart';

class RatingBar extends StatefulWidget {
  final int count;
  final double maxRating;
  final double value;
  final double size;
  final double padding;
  final String normalImage;
  final String selectImage;
  final bool selectAble;
  final ValueChanged<String> onRatingUpdate;

  const RatingBar(
      {Key? key, this.maxRating = 10.0,
      this.count = 5,
      this.value = 10.0,
      this.size = 20,
      required this.normalImage,
      required this.selectImage,
      this.padding = 5,
      this.selectAble = false,
      required this.onRatingUpdate}) : super(key: key);

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double? value;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerMove: (PointerMoveEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerUp: (_) {},
      behavior: HitTestBehavior.deferToChild,
      child: buildRowRating(),
    );
  }

  pointValue(double dx) {
    if (!widget.selectAble) {
      return;
    }
    if (dx >=
        widget.size * widget.count + widget.padding * (widget.count - 1)) {
      value = widget.maxRating;
    } else {
      for (double i = 1; i < widget.count + 1; i++) {
        if (dx > widget.size * i + widget.padding * (i - 1) &&
            dx < widget.size * i + widget.padding * i) {
          value = i * (widget.maxRating / widget.count);
          break;
        } else if (dx > widget.size * (i - 1) + widget.padding * (i - 1) &&
            dx < widget.size * i + widget.padding * i) {
          value = (dx - widget.padding * (i - 1)) /
              (widget.size * widget.count) *
              widget.maxRating;
          break;
        }
      }
    }
    setState(() {
      widget.onRatingUpdate(value!.toStringAsFixed(1));
    });
  }

  int fullStars() {
    if (value != null) {
      return (value! / (widget.maxRating / widget.count)).floor();
    }
    return 0;
  }

  double star() {
    if (value != null) {
      if (widget.count / fullStars() == widget.maxRating / value!) {
        return 0;
      }
      return (value! % (widget.maxRating / widget.count)) /
          (widget.maxRating / widget.count);
    }
    return 0;
  }

  List<Widget> buildRow() {
    int full = fullStars();
    List<Widget> children = [];
    for (int i = 0; i < full; i++) {
      children.add(Image.asset(
        widget.selectImage,
        height: widget.size,
        width: widget.size,
      ));
      if (i < widget.count - 1) {
        children.add(
          SizedBox(
            width: widget.padding,
          ),
        );
      }
    }
    if (full < widget.count) {
      children.add(ClipRect(
        clipper: SMClipper(rating: star() * widget.size),
        child: Image.asset(widget.selectImage,
            height: widget.size, width: widget.size),
      ));
    }

    return children;
  }

  List<Widget> buildNormalRow() {
    List<Widget> children = [];
    for (int i = 0; i < widget.count; i++) {
      children.add(Image.asset(
        widget.normalImage,
        height: widget.size,
        width: widget.size,
      ));
      if (i < widget.count - 1) {
        children.add(SizedBox(
          width: widget.padding,
        ));
      }
    }
    return children;
  }

  Widget buildRowRating() {
    return Stack(
      children: <Widget>[
        Row(children: buildNormalRow()),
        Row(children: buildRow())
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }
}

class SMClipper extends CustomClipper<Rect> {
  final double rating;
  SMClipper({required this.rating});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, rating, size.height);
  }

  @override
  bool shouldReclip(SMClipper oldClipper) {
    return rating != oldClipper.rating;
  }
}
