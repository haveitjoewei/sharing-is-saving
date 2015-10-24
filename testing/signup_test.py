from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import unittest
import time
import string
import random

class SignupTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		chrome_options.binary_location = "/Users/josephwei/Downloads/chromedriver"
		self.browser = webdriver.Chrome("/Users/josephwei/Downloads/chromedriver")
		self.browser.get('http://sharingissaving.herokuapp.com/')
		self.addCleanup(self.browser.quit)

	def testPageTitle(self):
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testDialog(self):
		self.browser.find_element_by_id('signup').click()
		self.assertTrue(self.browser.find_element_by_id('darken').is_displayed())
	def testDarken(self):
		self.browser.find_element_by_id('signup').click()
		self.assertTrue(self.browser.find_element_by_id('signup_dialog').is_displayed())
	def testSignupDarken(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('darken').is_displayed())
	def testSignupDialog(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('signup_dialog').is_displayed())
	def testSignupUser(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('user').is_displayed())
	def testSignupLogout(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('logout').is_displayed())
	def testLogoutSignup(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('signup').is_displayed())
	def testLogoutUser(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('user').is_displayed())
	def testLogoutLogout(self):
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		self.browser.find_element_by_id('signup').click()
		self.browser.find_element_by_id('signup_dialog').click()
		self.browser.find_element_by_id('first_name').send_keys("John")
		self.browser.find_element_by_id('last_name').send_keys("Hancock")
		self.browser.find_element_by_id('email').send_keys(email)
		self.browser.find_element_by_id('password').send_keys("1234567890")
		self.browser.find_element_by_id('password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_id('date_of_birth').send_keys("0000-01-01")
		self.browser.find_element_by_id('signup_submit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('logout').is_displayed())

if __name__ == '__main__':
	unittest.main(verbosity=2)
