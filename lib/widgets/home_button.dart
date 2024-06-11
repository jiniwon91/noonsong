import 'package:flutter/material.dart';

class homeButton extends StatelessWidget {
  final String location;
  final Widget destination;

  const homeButton({
    super.key,
    required this.location,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: const Color(0x40191C32),
        elevation: 10,
      ),
      child: Container(
        width: 280,
        height: 63,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              location,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).textTheme.displayLarge!.color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
