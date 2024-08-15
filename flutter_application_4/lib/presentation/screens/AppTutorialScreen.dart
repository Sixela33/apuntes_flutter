import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/presentation/Entities/SlideInfo.dart';
import 'package:go_router/go_router.dart';

class AppTutorialScreen extends StatelessWidget {
  static String name = 'tutorial screen';
  const AppTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _AppTutorialScreen(),),
    );
  }
}

class _AppTutorialScreen extends StatefulWidget {
  const _AppTutorialScreen({
    super.key,
  });

  @override
  State<_AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<_AppTutorialScreen> {

  bool endReached = false;
  PageController _pagecontoller = PageController();

  @override
  void initState() {
    super.initState();
    _pagecontoller.addListener(() { 
      if(!endReached && _pagecontoller.page! > slides.length -1.5) {
        setState(() {
          endReached = true;
        });
      }
      else if (endReached && _pagecontoller.page! < slides.length -1.5){
        setState(() {
          endReached = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pagecontoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pagecontoller,
          children: 
            slides.map((slide) {
              return SlideView(
                caption: slide.caption, 
                title: slide.title, 
                imageURL: slide.imageURL
              );
            }).toList(),
      ),
      SafeArea(
        child: Align(
          alignment: Alignment.topRight, 
          child: TextButton(
            onPressed: () {
              context.pop();
            } ,
            child: Text('skip'),
            ),
          )
        ),
        endReached ?
        SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.bottomRight, 
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              } ,
              child: Text('Start'),
              ),
            ),
        )
        ) : const SizedBox()
      ]
    );
  }
}

class SlideView extends StatelessWidget {
  final String title;
  final String caption;
  final String imageURL;

  
  const SlideView({
    super.key, 
    required this.title, 
    required this.caption, 
    required this.imageURL
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Image.asset(imageURL),
        SizedBox(height: 20),
        Text(
          title,
          style: textStyle.titleLarge,
          ),
        SizedBox(height: 10,),
        Text(
          caption,
          style: textStyle.bodyLarge,
          )
      ],),
    );
  }
}