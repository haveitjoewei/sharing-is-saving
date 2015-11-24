from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
import os
import unittest
import time
import string
import random

class UserTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome("spec/frontend/chromedriver")
		self.browser.set_window_size(1080,1000)
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		time.sleep(2)
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testUserProfile(self):
		firstname1 = "George"
		lastname1 = "Necula"
		password1 = "1234567890"
		email1 = "georgenecula@gmail.com"
		firstname2 = "Charles"
		lastname2 = "Xue"
		password2 = "1234567890"
 		email2 = "charlesxue@gmail.com"
		testpost = "Test Post: " + ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(3))

		#Login for User 1
		time.sleep(1)
		self.browser.find_element_by_id('login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys(password1)
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)

		#Make post
		self.browser.find_element_by_id('new_post').click()
		time.sleep(1)
		self.browser.find_element_by_id('post_title').send_keys(testpost)
		select = Select(self.browser.find_element_by_id('post_category'))
		select.select_by_visible_text('Apparel & Accessories')
		self.browser.find_element_by_id('post_image_url').send_keys(os.getcwd()+"/testimage.jpg")
		self.browser.find_element_by_id('post_description').send_keys("Nifty Description")
		self.browser.find_element_by_id('post_street').send_keys("2419 Durant Ave.")
		self.browser.find_element_by_id('post_city').send_keys("Berkeley")
		self.browser.find_element_by_id('post_state').send_keys("CA")
		self.browser.find_element_by_id('post_price').send_keys("1.00")
		self.browser.find_element_by_id('post_security_deposit').send_keys("1.00")
		time.sleep(5)
		self.browser.find_element_by_name('commit').click()

		#Click on User 1 Profile
		self.browser.find_element_by_id('username').click()
		time.sleep(1)

		#Click on Item
		self.browser.find_elements_by_css_selector('.nav-tabs .li')[1].click()
		self.browser.find_element_by_class_name('list-group-item-heading').click()

