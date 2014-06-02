StyleMe
=======
A fashion app that utilizes photo recognition technology to match images to shopping results.

How can I use it?
=======
A user is able to take a photo of any arbitrary piece of clothing, upload it into StyleMe, and StyleMe will produce a list of shopping results of where you could buy a similar item. 


How does it work?
=======

![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/styleme_dia.jpg)


How does it look?
=======

Landing Page
=======
![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/landing.png)

Sign In
=======
![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/signin.png)

Personalized Photobooth
=======
Users get a personalized "photobooths page". You have access to other users' search results and are able to upload images on this page.

![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/photobooth.png)

Upload Photo
=======
This is where users are able to upload a photo and run a shopping search. 
![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/upload.png)

Photobooth History
=======
This shows the most recent search results from other users.
![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/search%20results.png)

Profile Page 
=======
This is the user's profile page. 
![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/profile.png)

Summary
=======

CAMFIND API is the image recognition technology that is the crux of our application. Rails was decoupled from the application and is used just as a delivery mechanism here.  This enables easier testing and maintaining of the code.  The backend is ruby code bolstered by rspec testing.  The frontend is skeljs and javascript.  We use sidekiq to run the request to CAMFIND API in the background since there is a loading time of anywhere between 5-30 seconds to register a response from the image processing.  The result of this response(which is a string) is subsequently sent to Amazon Product Marketplace API to generate a list of search results based on the photo.  The orignal uploaded image file is sent to and summarily extracted from AMAZON s3.  Happy to answer any and all questions regarding the app!
