# 1DV450_rn222cx

### Install
* bundle install
* rake db:migrate
* rake db:seed

You should see a login page when navigate to the site.

#### Admin credentials
admin: admin@admin.com  
password: 1234

### Api

To fetch all users navigate to api.DOMAINNAME/users in url
As you can se i have placed the api string as an subdomain.

To fetch a certain user you need to be authenticated with both token and email.  
Bellow is a curl example with domain name 'ruby_api.dev' as example and the admin as email.  
copy and paste it in the terminal or import it in postman as Raw Text, you have to change to a valid token first.


curl http://api.ruby_api.dev/users/1 -H 'Authorization: Token token="a65FXfBVP788uC/LrTl8u7kgoevpWUHvNG8B84KTnYyotwEahHYYJPGedAUujR6zfpZyFQ37YfzMs+o9qViGCQ==", email="admin@admin.com"'

Admin can fetch all users data and regular users can only check their own.



Enjoy!