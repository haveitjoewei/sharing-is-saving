# Running Tests on Frontend
1. Install Selenium using this [link](http://selenium-python.readthedocs.org/installation.html) and follow the instructions to set it up on port 4444.
2. We currently have three tests for frontend located in `public/testing/` folder. Please `cd public/testing`, and type the following to test the three tests:
> `python listings_tests.py`

> `python login_logout_tests.py`

> `python signup_test.py`

# Running Tests on Backend
1. Ensure that all gems are installed by running `bundle install`.
2. In the main folder, type `bundle exec rspec spec` which runs the tests using `rspec` in the `spec` directory. The tests are mostly located within `spec/models` and `spec/requests`. You may also choose to run these tests (that are within the models and the requests folder) by running `bundle exec rspec spec/models` or `bundle exec rspec spec/requests` respectively.