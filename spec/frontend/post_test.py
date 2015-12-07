from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.keys import Keys
import os
import unittest
import time
import string
import random

class PostTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome("spec/frontend/chromedriver")
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		time.sleep(2)
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testPostSequence(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		# self.browser.find_element_by_link_text("List Item")
		self.browser.find_element_by_name('commit').click()
	def testPostItemView(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)
		self.assertTrue(self.browser.find_element_by_class_name('listing').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('images').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('content').is_displayed())
		self.assertTrue(self.browser.find_element_by_class_name('actionbar').is_displayed())
	def testPostToListingsUser1(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()

		#Check Item was posted on Listings
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(2)
		# self.assertTrue(self.browser.find_element_by_id('update').is_displayed())
		# time.sleep(1)
	def testPostToListingsUser2(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
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
		self.assertTrue(self.browser.find_element_by_id('borrow').is_displayed())
		time.sleep(1)
	def testAcceptRejectButtonsExist(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"spec/frontend/testimage.jpg")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		# self.browser.find_element_by_id('post_security_deposit').send_keys(Keys.RETURN)
		# self.browser.find_element_by_xpath("//div[@class='actions']/input").click()
		self.browser.find_element_by_name('commit').click()
		time.sleep(3)
	
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
		# self.assertTrue(self.browser.find_element_by_id('update').is_displayed())
		self.assertTrue(self.browser.find_element_by_id('accept').is_displayed())
		self.assertTrue(self.browser.find_element_by_id('reject').is_displayed())
		time.sleep(1)
	def testReturnedButtonExist(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
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
		time.sleep(1)
		self.browser.find_element_by_id('accept').click()
		time.sleep(1)
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		# self.assertTrue(self.browser.find_element_by_id('update').is_displayed())
		self.assertTrue(self.browser.find_element_by_id('returned').is_displayed())
		time.sleep(1)
	def testCancelledButtonExist(self):
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
		# self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
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
		self.browser.find_element_by_id('listings_tab').click()
		time.sleep(1)
		self.assertTrue(self.browser.find_element_by_id('cancel').is_displayed())
		time.sleep(1)


if __name__ == '__main__':
	unittest.main(verbosity=2)
