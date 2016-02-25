# 1DV450_rn222cx

### Install
* bundle install
* rake db:migrate
* rake db:seed

You should see a login page when navigate to the site.

#### Admin credentials
username: admin  
email: admin@admin.com  
password: 1234  

### Non admin user  
username: johndoe  
email: test@test.com  
password: 1234  
For CrUD management the users email and password must be sent encoded in the header to make requests.  
Don't worry it's included in the postman collection for johndoe.    
You can create your own encoding in the terminal like this `Base64.encode64("test@test.com:1234")`    

### Api

Postman collection https://www.getpostman.com/collections/0893639f23f89b9ca0fe

#### Known issue
I personaly use the api as an subdomain but I guess most people use localhost:3000 so I created the postman collection for localhost:3000. The problem I encountered when I did the postman collection is that the hateoas url does not include api as a parameter in the url. I know why it happens but I will not spend time on it because the app should use api as subdomain in production.

To create requests you have to generate your own Api-Key or login as admin and copy the existing one.

The index and show methods are generated with RABL and are located in the views directory.

The api works for booth json and xml.


Enjoy!
