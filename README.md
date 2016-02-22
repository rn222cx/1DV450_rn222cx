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

#### Known issue
I personaly use the api as an subdomain but I guess most people use localhost:3000 so I created the postman collection for localhost:3000. The problem I encountered when I did the postman collection is that the hateoas url does not include api as a parameter in the url. I know why it happens but I will not spend time on it for a peer-review.

To create requests you have to generate your own Api-Key or login as admin and copy the existing one.

The api works for booth json and xml.


Enjoy!
