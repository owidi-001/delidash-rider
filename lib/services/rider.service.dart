
import 'package:rider/domain/exception.dart';
import 'package:rider/domain/user.model.dart';
import 'package:rider/domain/rider.model.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/services/http_client.dart';

class RiderService {
  

// saveRider
  Future<HttpResult<Rider>> saveRider({required Map<String, String> data}) =>
      HttpClient.post2<Rider>(
        ApiUrl.riders,
        data: data,
        der: (data) => Rider.fromJson(data),
      );

  // // Update brand
  Future<HttpResult<User>> updateBrand({required Map<String, String> data}) =>
      HttpClient.put2<User>(
        ApiUrl.riders,
        data: data,
        der: (data) => User.fromJson(data),
      );

    
}
