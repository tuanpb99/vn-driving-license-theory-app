import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/exam_models.dart';
import '../models/question_list_response.dart';
import '../models/question_model.dart';
import '../models/statistics_model.dart';

part 'question_api_service.g.dart';

@RestApi()
abstract class QuestionApiService {
  factory QuestionApiService(Dio dio, {String baseUrl}) = _QuestionApiService;

  @GET('/api/questions')
  Future<QuestionListResponse> getQuestions({
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
    @Query('category') String? category,
  });

  @GET('/api/questions/{number}')
  Future<QuestionModel> getQuestion(@Path('number') int number);

  @GET('/api/questions/search/{keyword}')
  Future<QuestionListResponse> searchQuestions(
    @Path('keyword') String keyword, {
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
  });

  @GET('/api/questions/random')
  Future<List<QuestionModel>> getRandomQuestions({
    @Query('count') int count = 30,
    @Query('category') String? category,
  });

  @GET('/api/questions/critical/list')
  Future<QuestionListResponse> getCriticalQuestions({
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
  });

  @GET('/api/questions/images/list')
  Future<QuestionListResponse> getQuestionsWithImages({
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
  });

  @GET('/api/categories')
  Future<List<String>> getCategories();

  @GET('/api/statistics')
  Future<StatisticsModel> getStatistics();

  @POST('/api/exam/generate')
  Future<ExamResponse> generateExam(@Body() ExamConfigRequest config);
}
