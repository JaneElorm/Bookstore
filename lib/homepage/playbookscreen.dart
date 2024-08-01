import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayBookScreen extends StatelessWidget {
  final String bookTitle;

  const PlayBookScreen({super.key, required this.bookTitle});
  static const routeName = '/play-book-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          bookTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            const SizedBox(height: 20),
            // Video Player
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('images/after-9781982111007_hr.jpg'), // Replace with actual image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.heart),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.backwardStep),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.play),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.forwardStep),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomListTile(
              leading: Icon(FontAwesomeIcons.bookOpen),
              titleText: 'After',
            ),
            const SizedBox(height: 15),
            const CustomListTile(
              leading: Icon(FontAwesomeIcons.user),
              titleText: 'Anna Todd',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {required this.leading, required this.titleText, super.key});
  final Widget leading;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        const SizedBox(width: 10),
        Text(
          titleText,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

class CustomBodyText extends StatelessWidget {
  final String text;

  const CustomBodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
