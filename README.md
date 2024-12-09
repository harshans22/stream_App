<!-- create readme for fucntionality of my app -->
Features of the app:
- User can search for a stream 
- User can view the top streams
- User can add stream
- User can delete stream
- User can update stream

Task Completed:
- [x] User can search for a stream
- [x] User add the link of the stream and it search it using the open Graph API and get the meta deta
- [x] Getx for efficient state management
- [x] Proper Folder Structure and separation of concerns
- [x] Mangaged the UI perfection with respect to given in the figma
- [x] search bar functionality searches for input by the user
- [x] Using pagination for efficient data loading
- [x] Interactivite Lottie animaiton for loading more streams
- [x] User custom clipper to meet the UI requirements
- [x] Proper exception handling and code seperation for better readability



# Stream App
lib/view/live_stream_screen.dart
```added the live stream screen for the user to view the live stream and search bar to search for the stream and add button to add stream
```
lib/view/update_stream_screen.dart
```user can update the stream by clicking on the update button and dialog open on clicking the delete button 
```
lib/view/create_stream_screen.dart
```user paste the link and the api fetches the data and populate the feilds and user can add the stream
```

lib/resources/routes.dart
```added the routes for the app
```

lib/resources/app_url.dart
```added the constant app url for the app
```
lib/repository/create_stream_repository.dart
```fetch the data from the api using the NetworkApi class 
```
lib/data/network/network_api_services.dart
```implemented the network api services for the app and network api class implements an base class
```managing custom response 
```
lib/data/api_response.dart
```Handling the api response and creating custom Exceptions
```


# How to check
- Clone the repository
- Run the app using the command flutter run
- The app will run on the emulator or the device connected to the system
- The app will show the live stream screen with the search bar and add button
- User can search for the stream and add the stream
- Scroll down to view more streams and paginated format is using 5 Streams per page
- User can view the top streams
- User can add the stream
- Tap on add button and paste the link and wait to fetch the data
- Feilds will be populated with meta and user can add the stream
- Tap on any stream to update the stream



