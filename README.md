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
For crud management the users email and password must be sent encoded in the header to make requests.  
Don't worry it is included in the postman collection for johndoe.    
You can create your own encoding in the terminal like this `Base64.encode64("test@test.com:1234")`    




### Api

To fetch all users navigate to api.DOMAINNAME/users in url.  
As you can se i have placed the api string as an subdomain. 
If you can't run the api as subdomain for any reason, remove row 11 in the route file, see the link below.  
https://github.com/rn222cx/1DV450_rn222cx/blob/master/ruby_api/config/routes.rb#L11


To fetch a certain user you need to be authenticated with both token and email.  
Bellow is a curl example with domain name 'ruby_api.dev' as example and the admin as email.  
copy and paste it in the terminal or import it in postman as Raw Text, you have to change to a valid token first.


`curl http://api.ruby_api.dev/users/1 -H 'Authorization: Token   token="a65FXfBVP788uC/LrTl8u7kgoevpWUHvNG8B84KTnYyotwEahHYYJPGedAUujR6zfpZyFQ37YfzMs+o9qViGCQ==", email="admin@admin.com"'`

Admin can fetch all users data and regular users can only check their own.



Enjoy!
