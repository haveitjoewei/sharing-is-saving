# Sharing Is Saving Backend API
This Rails backend will support creation of users, posts and reviews. Since there is only three of us working on the backend, we shouldn't need to use `git branch` to ensure that we don't have merge conflicts. But if you feel that your part interferes with other major components, please branch off and merge in later.

## Installation

Here are some steps to get your local machine set up:

1. Make sure [psql](http://www.postgresql.org/download/) is installed. For Mac OS X, there is a [fantastic app](http://postgresapp.com) that you should use, which is a simple drag-and-drop application. Once downloaded, please ensure it is running.
2. Clone this repo in an appropriate directory 
>`git clone https://sidwynkoh@bitbucket.org/sidwynkoh/cs169-project.git`

3. Run these commands inside `backend/sharing_is_saving/` to ensure that you have your database configured: 
> `bundle exec rake db:create; bundle exec rake db:migrate`

---

## Authentication

We are using [simple-token-authentication](https://github.com/gonzalo-bulnes/simple_token_authentication) and [Devise](https://github.com/plataformatec/devise) for authentication. To understand how it works, please see `application_controller.rb`. It requires a user email and user token that is sent in using the headers `X-API-EMAIL` and `X-API-TOKEN` for the API to properly authenticate the user. These are given when the user logs in.

### Methods That Do Not Need Authentication

Authentication is automatically run for **every** method. To prevent authentication, add `skip_before_filter :authenticate_user!, :only => [:YOUR_METHOD_NAME, :YOUR_METHOD_NAME_2]` to the top of your controller. This will prevent the authentication from taking place for your method. Look at the `#create` method in `SessionsController` for an example.

---

## Databases And The Psql Console
Databases are configured in `database.yml`. From the psql console, we can easily see what rows we have created.

To bring up the sql console, you can click the elephant in your menu bar (on Mac OS) and hit 'Open psql' or type the following which will directly launch psql in your Terminal:
> `rails dbconsole`

From the psql console, you may use these commands:

1. To list all databases: `\l`.
2. To connect to a database: `\c sis_development`.
3. To show all tables in the database: `\dt`.
4. To show all information in a particular table: `select * from users;`. Make sure you terminate your statement with a semicolon!
5. To quit the console: `\q`.
6. To wipe all users/posts/etc from your table: `truncate users restart identity cascade`.

---

## Heroku
We have begun deployment of the backend to [Heroku](https://sis-backend.herokuapp.com). Some useful Heroku commands are:

1. To push to Heroku: `git subtree push --prefix backend/sharing_is_saving heroku master`. Please do **not** push the main folder to Heroku.
2. To see logs on Heroku: `heroku logs --app sis-backend --tail`
3. To migrate the database on Heroku: `heroku run rake db:migrate`. Be sure to do this if you introduced a new migration.
4. To log into psql on Heroku: `heroku pg:psql`.

---

## Postman
We will use [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en) to launch and post requests. For each table, we will make a new `Collection`, and save all the possible calls within that `Collection`. There is also a global environment that we will use for configuration (e.g. variables). To load the configuration, click the top right hand corner with the down arrow, and hit `Manage Environments`, and import the collection found in `backend/sharing_is_saving/postman`. Finally, please export all your collections periodically to this folder, so that we are all in sync. As of now, there are Users and Posts collections available to all.

---

## Documentation
As you go along, it is important to document the API so we all know how the function works. Please document your code in the [Design Document](https://docs.google.com/document/d/19r1ms0wZ_XMxo6AKDbafWvAqUgW5u80PpRomPyyRThg/edit#).

---

## Debugging and Testing
For debugging, please use `byebug`. For writing tests, use `rspec` and `FactoryGirl`. In order to ensure and maintain stability, please ensure that you continually write tests as soon as you finish a model.