// ignore_for_file: unnecessary_const, prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:news_blocks/news_blocks.dart';
import 'package:news_blocks_ui/news_blocks_ui.dart';

import '../helpers/helpers.dart';

void main() {
  const category = PostCategory.technology;
  const author = 'Sean Hollister';
  final publishedAt = DateTime(2022, 3, 9);
  const imageUrl =
      'https://cdn.vox-cdn.com/thumbor/OTpmptgr7XcTVAJ27UBvIxl0vrg='
      '/0x146:2040x1214/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset'
      '/file/22049166/shollister_201117_4303_0003.0.jpg';
  const title = 'Nvidia and AMD GPUs are returning to shelves '
      'and prices are finally falling';

  const premiumText = 'Subscriber Exclusive';
  const shareText = 'Share';

  group('ArticleIntroduction', () {
    setUpAll(setUpTolerantComparator);

    final technologyArticleIntroduction = ArticleIntroductionBlock(
      category: category,
      author: author,
      publishedAt: publishedAt,
      imageUrl: imageUrl,
      title: title,
    );

    testWidgets('renders correctly', (tester) async {
      await mockNetworkImages(
        () async => tester.pumpContentThemedApp(
          SingleChildScrollView(
            child: Column(
              children: [
                ArticleIntroduction(
                  block: technologyArticleIntroduction,
                  premiumText: premiumText,
                  shareText: shareText,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ArticleIntroduction), findsOneWidget);
    });

    testWidgets('calls onSharePressed when ShareButton is pressed',
        (tester) async {
      final completer = Completer<void>();

      await tester.pumpContentThemedApp(
        SingleChildScrollView(
          child: Column(
            children: [
              ArticleIntroduction(
                block: technologyArticleIntroduction,
                premiumText: premiumText,
                shareText: shareText,
                onSharePressed: completer.complete,
              ),
            ],
          ),
        ),
      );

      final shareButton = find.byKey(Key('articleIntroduction_shareButton'));

      await tester.ensureVisible(shareButton);

      await tester.tap(shareButton);

      expect(completer.isCompleted, isTrue);
    });
  });
}