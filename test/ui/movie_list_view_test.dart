import 'package:cinema/app/data/response/movie/movie_model.dart';
import 'package:cinema/app/modules/MovieList/controllers/movie_list_controller.dart';
import 'package:cinema/app/modules/MovieList/views/movie_list_view.dart';
import 'package:cinema/app/modules/MovieList/widgets/movie_card.dart';
import 'package:cinema/app/modules/app_widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:mockito/mockito.dart';

// Mock MovieController for testing
class MockMovieController extends GetxController
    with Mock
    implements MovieListController {}

void main() {
  late MockMovieController mockController;

  setUp(() {
    mockController = MockMovieController();
    Get.put<MovieListController>(mockController);
  });

  testWidgets('displays the AppBar with correct title',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: MovieListView(),
    ));

    expect(find.text('Movies'), findsOneWidget);
    expect(find.byIcon(Icons.theaters), findsOneWidget);
  });

  testWidgets('displays loading indicator when loading',
      (WidgetTester tester) async {
    when(mockController.showLoading).thenReturn(true);

    await tester.pumpWidget(const GetMaterialApp(
      home: MovieListView(),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays NotFoundWidget when movie lists are empty',
      (WidgetTester tester) async {
    when(mockController.showLoading).thenReturn(false);
    when(mockController.trendingList).thenReturn([]);
    when(mockController.popularList).thenReturn([]);
    when(mockController.upcomingList).thenReturn([]);

    await tester.pumpWidget(const GetMaterialApp(
      home: MovieListView(),
    ));

    expect(find.byType(NotFoundWidget), findsOneWidget);
  });

  testWidgets('displays a list of movies when trendingList is not empty',
      (WidgetTester tester) async {
    when(mockController.showLoading).thenReturn(false);
    when(mockController.trendingList).thenReturn([
      MovieModel(id: 1, title: 'Movie 1', posterPath: 'path1'),
      MovieModel(id: 2, title: 'Movie 2', posterPath: 'path2'),
    ]);
    when(mockController.popularList).thenReturn([]);
    when(mockController.upcomingList).thenReturn([]);

    await tester.pumpWidget(const GetMaterialApp(
      home: MovieListView(),
    ));

    expect(find.byType(MovieCard), findsNWidgets(2));
    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);
  });

  testWidgets('displays "See More" and navigates when tapped',
      (WidgetTester tester) async {
    when(mockController.showLoading).thenReturn(false);
    when(mockController.trendingList).thenReturn([
      MovieModel(id: 1, title: 'Movie 1', posterPath: 'path1'),
    ]);

    await tester.pumpWidget(const GetMaterialApp(
      home: MovieListView(),
    ));

    expect(find.text('See More'), findsOneWidget);
    await tester.tap(find.text('See More'));
    verify(mockController.onTrendingNowSeeMore()).called(1);
  });
}
