// ignore: file_names
// ignore_for_file: avoid_unnecessary_containers
import 'package:delverplace/core/responsive.dart';
import 'package:delverplace/src/model/lead.dart';
import 'package:delverplace/src/view/widget/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

SizeConfig size = SizeConfig();

class CardsLeads extends StatefulWidget {
  final color;
  final colorname;
  final Lead lead;
  final int index;

  const CardsLeads({
    super.key,
    required this.index,
    required this.color,
    required this.colorname,
    required this.lead,
  });

  @override
  State<CardsLeads> createState() => _CardsLeadsState();
}

class _CardsLeadsState extends State<CardsLeads>
    with SingleTickerProviderStateMixin {
  //set animation arrow indicator
  late final AnimationController _controller;

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void didChangeDependencies() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    istaped[widget.index] = false;
    super.initState();
  }

  //add index map
  static Map<int, bool> istaped = {};
  Future<void> _changeHeight() async {
    setState(() {
      istaped[widget.index] = true;
    });
    await Future.delayed(const Duration(seconds: 8), (() {
      setState(() {
        istaped[widget.index] = false;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return GestureDetector(
      onTap: () {
        _changeHeight();
      },
      child: Stack(
        children: [
          Container(
            child: Slidable(
              startActionPane: ActionPane(
                extentRatio: 0.8,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    foregroundColor: Colors.white,

                    onPressed: ((context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StatusView(
                                  tracking: widget.lead.tracking.toString(),
                                  city: widget.lead.city.toString(),
                                  products: widget.lead.products!,
                                  name: widget.lead.name.toString(),
                                  address: widget.lead.address.toString(),
                                  phone: widget.lead.phone.toString(),
                                  phone2: widget.lead.phone2.toString(),
                                  prix: widget.lead.price.toString(),
                                  status_livrison:
                                      widget.lead.statusLivrison.toString(),
                                )),
                      );
                    }),
                    backgroundColor: Colors.orange,
                    icon: Icons.autorenew,
                    label: "Change State",

                    //borderRadius: BorderRadius.circular(9),
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                // motion: const StretchMotion(),
                dragDismissible: true,
                //openThreshold: 0.5,
                extentRatio: 0.8,
                //closeThreshold: 0.1,
                motion: const BehindMotion(),
                children: [
                  /*
                SlidableActionModel(
                    border: -10,
                    title: 'Call',
                    image: 'assets/images/delivred.png',
                    color: Colors.black45),*/
                  SlidableAction(
                    onPressed: (context) {
                      launch("tel://${widget.lead.phone}");
                    },
                    backgroundColor: Colors.blue,
                    icon: Icons.call,
                    label: "Call",
                  )
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    // margin: const EdgeInsets.only(bottom: 30),
                    //  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    // width: 300,
                    // height: 150,
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 2
                            // spreadRadius: 1,
                            )
                      ],

                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.lead.name}',
                                style: GoogleFonts.poppins().copyWith(
                                    color: const Color(0xff011842),
                                    fontSize: 23),
                              ),
                              Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 2),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    color: Color(0xffefc394),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "№  : ${widget.lead.tracking}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Adress : ${widget.lead.address}',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'City : ${widget.lead.city}',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Phone : ${widget.lead.phone}',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Price : ${widget.lead.phone2}',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "${widget.lead.statusLivrison}",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  color: const Color(0xff011842),
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 200,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Price :",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          TextSpan(
                            text: "${widget.lead.price} Dh",
                            style: GoogleFonts.poppins(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ),
                  istaped[widget.index] == true
                      ? Positioned(
                          top: 80,
                          right: 20,
                          child: SlideTransition(
                            position: _offsetAnimation,
                            child: SvgPicture.asset('assets/icons/arrow2.svg',
                                width: 24.0, height: 24.0, color: Colors.blue),
                          ),
                        )
                      : const Center(),
                  istaped[widget.index] == true
                      ? Positioned(
                          top: 80,
                          left: 20,
                          child: SlideTransition(
                            position: _offsetAnimation2,
                            child: Image.asset('assets/icons/arrow3.png',
                                width: 24.0,
                                height: 24.0,
                                color: Colors.orange),
                          ),
                        )
                      : const Center(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
