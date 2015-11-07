from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
import unittest
import time
import string
import random

class ReviewTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome("./chromedriver")
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		time.sleep(2)
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testPostandReviewSequence(self):
		firstname1 = "George"
		lastname1 = "Necula"
		password1 = "1234567890"
		email1 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		firstname2 = "Charles"
		lastname2 = "Xue"
		password2 = "1234567890"
 		email2 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		testpost = "Test Post: " + ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(3))

		#Signup for User 1
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname1)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Make post
		self.browser.find_element_by_id('new_post').click()
		time.sleep(1)
		self.browser.find_element_by_id('post_title').send_keys(testpost)
		select = Select(self.browser.find_element_by_id('post_category'))
		select.select_by_visible_text('Apparel & Accessories')
		self.browser.find_element_by_id('post_image_url').send_keys("/Users/josephwei/Downloads/IMG_0039.JPG")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()
	
		#Signup for User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname2)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname2)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Borrow User 1's item
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('borrow').click()
		time.sleep(1)

		#Login to User 1
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Accept User 2's request
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(2)
		self.browser.find_element_by_id('accept').click()
		time.sleep(1)

		#Mark item as returned
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('returned').click()

		#Login to User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Click on User 2 Profile
		self.browser.find_element_by_id('username').click()
		time.sleep(1)

		#Leave a review
		self.browser.find_element_by_id('notificationLink').click()
		self.browser.find_element_by_class_name('review_status').click()
		time.sleep(1)
		select2 = Select(self.browser.find_element_by_id('reviews_rating'))
		select2.select_by_visible_text('1')
		self.browser.find_element_by_id('reviews_content').send_keys("Nifty Review")
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)
	def testReviewPageExists(self):
		firstname1 = "George"
		lastname1 = "Necula"
		password1 = "1234567890"
		email1 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		firstname2 = "Charles"
		lastname2 = "Xue"
		password2 = "1234567890"
 		email2 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		testpost = "Test Post: " + ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(3))

		#Signup for User 1
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname1)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Make post
		self.browser.find_element_by_id('new_post').click()
		time.sleep(1)
		self.browser.find_element_by_id('post_title').send_keys(testpost)
		select = Select(self.browser.find_element_by_id('post_category'))
		select.select_by_visible_text('Apparel & Accessories')
		self.browser.find_element_by_id('post_image_url').send_keys("/Users/josephwei/Downloads/IMG_0039.JPG")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()
	
		#Signup for User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname2)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname2)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Borrow User 1's item
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('borrow').click()
		time.sleep(1)

		#Login to User 1
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Accept User 2's request
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(2)
		self.browser.find_element_by_id('accept').click()
		time.sleep(1)

		#Mark item as returned
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('returned').click()

		#Login to User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Click on User 2 Profile
		self.browser.find_element_by_id('username').click()
		time.sleep(1)

		#Leave a review
		self.browser.find_element_by_id('notificationLink').click()
		self.browser.find_element_by_class_name('review_status').click()
		time.sleep(1)
		select2 = Select(self.browser.find_element_by_id('reviews_rating'))
		select2.select_by_visible_text('1')
		self.browser.find_element_by_id('reviews_content').send_keys("Nifty Review")
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)
		self.assertTrue(self.browser.find_element_by_class_name('review').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('reviewed_by').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('rating').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('review_content').is_displayed())
	def testReviewExistsOnItemView(self):
		firstname1 = "George"
		lastname1 = "Necula"
		password1 = "1234567890"
		email1 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		firstname2 = "Charles"
		lastname2 = "Xue"
		password2 = "1234567890"
 		email2 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		testpost = "Test Post: " + ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(3))

		#Signup for User 1
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname1)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Make post
		self.browser.find_element_by_id('new_post').click()
		time.sleep(1)
		self.browser.find_element_by_id('post_title').send_keys(testpost)
		select = Select(self.browser.find_element_by_id('post_category'))
		select.select_by_visible_text('Apparel & Accessories')
		self.browser.find_element_by_id('post_image_url').send_keys("/Users/josephwei/Downloads/IMG_0039.JPG")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()
	
		#Signup for User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname2)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname2)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Borrow User 1's item
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('borrow').click()
		time.sleep(1)

		#Login to User 1
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Accept User 2's request
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(2)
		self.browser.find_element_by_id('accept').click()
		time.sleep(1)

		#Mark item as returned
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('returned').click()

		#Login to User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Click on User 2 Profile
		self.browser.find_element_by_id('username').click()
		time.sleep(1)

		#Leave a review
		self.browser.find_element_by_id('notificationLink').click()
		self.browser.find_element_by_class_name('review_status').click()
		time.sleep(1)
		select2 = Select(self.browser.find_element_by_id('reviews_rating'))
		select2.select_by_visible_text('1')
		self.browser.find_element_by_id('reviews_content').send_keys("Nifty Review")
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Mark item as returned
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(2)
		self.browser.find_element_by_class_name('title').click()
		time.sleep(1)
		self.assertTrue(self.browser.find_element_by_class_name('review').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('reviewed_by').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('rating').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('review_content').is_displayed())
	def testReviewButtonWorksOnce(self):
		firstname1 = "George"
		lastname1 = "Necula"
		password1 = "1234567890"
		email1 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		firstname2 = "Charles"
		lastname2 = "Xue"
		password2 = "1234567890"
 		email2 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		testpost = "Test Post: " + ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(3))

		#Signup for User 1
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname1)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Make post
		self.browser.find_element_by_id('new_post').click()
		time.sleep(1)
		self.browser.find_element_by_id('post_title').send_keys(testpost)
		select = Select(self.browser.find_element_by_id('post_category'))
		select.select_by_visible_text('Apparel & Accessories')
		self.browser.find_element_by_id('post_image_url').send_keys("/Users/josephwei/Downloads/IMG_0039.JPG")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()
	
		#Signup for User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('signup').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_first_name').send_keys(firstname2)
		self.browser.find_element_by_id('user_last_name').send_keys(lastname2)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_id('user_password_confirmation').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Borrow User 1's item
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('borrow').click()
		time.sleep(1)

		#Login to User 1
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Accept User 2's request
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(2)
		self.browser.find_element_by_id('accept').click()
		time.sleep(1)

		#Mark item as returned
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.browser.find_element_by_id('returned').click()

		#Login to User 2
		self.browser.find_element_by_id('logout_button').click()
		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys(password2)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Click on User 2 Profile
		self.browser.find_element_by_id('username').click()
		time.sleep(1)

		#Leave a review
		self.browser.find_element_by_id('notificationLink').click()
		self.browser.find_element_by_class_name('review_status').click()
		time.sleep(1)
		select2 = Select(self.browser.find_element_by_id('reviews_rating'))
		select2.select_by_visible_text('1')
		self.browser.find_element_by_id('reviews_content').send_keys("Nifty Review")
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Click on User 2 Profile
		self.browser.find_element_by_id('username').click()
		time.sleep(1)

		#Check Review Label
		self.browser.find_element_by_id('notificationLink').click()
		labelText = self.browser.find_element_by_class_name('review_status').text
		self.assertTrue("You've left a review for this item" in labelText)

		#Check Review label redirects correctly
		self.browser.find_element_by_class_name('review_status').click()
		time.sleep(1)
		self.assertTrue(self.browser.find_element_by_class_name('listing').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('images').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('content').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('actionbar').is_displayed())
		
		


if __name__ == '__main__':
	unittest.main(verbosity=2)
