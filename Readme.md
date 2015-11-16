# Running Tests on Frontend
1. Install Selenium using this [link](http://selenium-python.readthedocs.org/installation.html) and follow the instructions to set it up on port 4444.

2. Run Selenium by typing into the Terminal `spec/frontend/launch_selenium_server.sh`. Wait till the server fully launches. If this script does not work, you may launch it manually by opening `public/old/testing/selenium-server-standalone-2.28.0.jar`.

3. Run `spec/frontend/run_frontend_tests.sh`. If that doesn't work, we currently have five tests for frontend located in `spec/frontend/` folder. Please `cd public/testing`, and type the following to test the three tests:

> `python listings_tests.py`

> `python login_logout_tests.py`

> `python post_test.py`

> `python review_test.py`

> `python signup_test.py`


# Running Tests on Backend
1. Ensure that all gems are installed by running `bundle install`.
2. In the main folder, type `bundle exec rspec spec` which runs the tests using `rspec` in the `spec` directory. The tests are mostly located within `spec/models` and `spec/controllers`. You may also choose to run these tests (that are within the models and the controllers folder) by running `bundle exec rspec spec` respectively.