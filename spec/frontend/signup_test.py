from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import unittest
import time
import string
import random

class SignupTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome("spec/frontend/chromedriver")
		self.browser.set_window_size(1080,800)
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		time.sleep(2)
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testSignupClick(self):
		self.browser.find_element_by_id('signup').click()
		# self.assertTrue(self.browser.find_element_by_id('signup_dialog').is_displayed())
	def testSignup(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("John")
		self.browser.find_element_by_id('user_last_name').send_keys("Hancock")
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
	def testSignupUser(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("John")
		self.browser.find_element_by_id('user_last_name').send_keys("Hancock")
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('username').is_displayed())
	def testSignupLogout(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("John")
		self.browser.find_element_by_id('user_last_name').send_keys("Hancock")
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('logout_button').is_displayed())
	def testLogoutSignup(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("John")
		self.browser.find_element_by_id('user_last_name').send_keys("Hancock")
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout_button').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('signup').is_displayed())
	def testLogoutUser(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("John")
		self.browser.find_element_by_id('user_last_name').send_keys("Hancock")
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout_button').click()
		time.sleep(2)

if __name__ == '__main__':
	unittest.main(verbosity=2)
