== README

Pearson Engine, REST based ruby engine running off a MongoDB.

This README will document whatever steps are necessary to get the
application up and running.

* Ruby version: 1.9.3-p125

* System dependencies: run bundle install -> all dependancies have been included in Gemfile

* Configuration

* Database creation
	Need one local mongo db with a db named Pearson

* Database initialization

* Services (job queues, cache servers, search engines, etc.)
	MongoDB intialized with a DB named Pearson, only needs one collectin named Numbers

* Deployment instructions

1. install ruby 1.9.3-p125
2. install mongo
3. copy pearson_engine folder and run bundle install in this folder
4. startup mongo server and create needed db, collections.
5. in pearson_engine folder exectue ruby server.rb -v. this will start up the Pearson Engine on Port 9000


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
