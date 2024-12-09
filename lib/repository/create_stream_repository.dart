import 'package:stream_management_flutter/models/stream_model.dart';
import 'package:stream_management_flutter/resources/app_url.dart';

import '../data/network/network_api_services.dart';

class CreateStreamRepository {
  
  final _apiService  = NetworkApiServices() ;


  Future<StreamModel> getMetaData(String inputUrl) async{
    final encodedUrl = Uri.encodeComponent(inputUrl);
    dynamic response = await _apiService.getApi(AppUrl.getMetadataUrl(encodedUrl, AppUrl.apiKey));
    Map<String,String> result=  {
          "platform": response["hybridGraph"]["site_name"] ?? "Unknown Platform",
          "title": response["hybridGraph"]["title"] ?? "Untitled Stream",
          "thumbnail": response["hybridGraph"]["image"] ?? "",
          "favicon" : response['hybridGraph']['favicon'] ?? "",
          "link" : inputUrl
        };
    return StreamModel.fromJson(result) ;
  }
}