StyleMe
=======
A fashion app that utilizes photo recognition technology to match images to shopping results.

How can I use it?
=======
A user is able to take a photo of any arbitrary piece of clothing, upload it into StyleMe, and StyleMe will produce a list of shopping results of where you could buy a similar item. 


How does it work?
=======

![alt text](https://raw.githubusercontent.com/snly2386/StyleMe/master/web/app/assets/images/styleme_dia.jpg)

Summary
=======

CAMFIND API is the image recognition technology that is the crux of our application. Rails was decoupled from the application and is used just as a delivery mechanism here.  This enables easier testing and maintaining of the code.  The backend is ruby code bolstered by rspec testing.  The frontend is skeljs and javascript.  We use sidekiq to run the request to CAMFIND API in the background since there is a loading time of anywhere between 5-30 seconds to register a response from the image processing.  The result of this response(which is a string) is subsequently sent to Amazon Product Marketplace API to generate a list of search results based on the photo.  The orignal uploaded image file is sent to and summarily extracted from AMAZON s3.  Happy to answer any and all questions regarding the app!
