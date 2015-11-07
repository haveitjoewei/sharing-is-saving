from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import unittest
import string
import time
import random

class ListingsTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		chrome_options.binary_location = 'C:\Users\Victor\AppData\Local\Google\Chrome SxS\Application\chrome.exe'
		self.url = 'http://sharingissaving.herokuapp.com/'
		self.browser = webdriver.Chrome(chrome_options=chrome_options)
		self.browser.get(self.url)
		self.addCleanup(self.browser.quit)
	def testLoginLogoutListings(self):
		# Sign up
		self.assertTrue(self.browser.find_element_by_link_text('Sign Up').is_displayed())
		self.browser.find_element_by_link_text('Sign Up').click()
		time.sleep(1)
		self.assertEqual(self.url + 'users/sign_up', self.browser.current_url)
		# Enter new account information and submit
		email = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(5)) + '@email.com'
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys('1234567890')
		self.browser.find_element_by_id('user_password_confirmation').send_keys('1234567890')
		self.browser.find_element_by_id('user_first_name').send_keys('Test')
		self.browser.find_element_by_id('user_last_name').send_keys('User')
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)
		self.assertEqual(self.url, self.browser.current_url)
		# Assert logged in status
		# self.assertTrue(self.browser.find_element_by_link_text(email).is_displayed())
		# Log out
		self.assertTrue(self.browser.find_element_by_link_text('Logout').is_displayed())
		self.browser.find_element_by_link_text('Logout').click()
		time.sleep(1)
		# Log back in
		self.assertTrue(self.browser.find_element_by_link_text('Login').is_displayed())
		self.browser.find_element_by_link_text('Login').click()
		time.sleep(1)
		self.assertEqual(self.url + 'users/sign_in', self.browser.current_url)
		# Enter account information and submit
		self.browser.find_element_by_id('user_email').send_keys(email)
		self.browser.find_element_by_id('user_password').send_keys('1234567890')
		self.browser.find_element_by_name('commit').click()
		time.sleep(1)
		# Go to listings
		self.browser.find_element_by_link_text('Find Stuff').click()
		time.sleep(2)
		self.assertEqual(self.url + 'posts', self.browser.current_url)
		# Make sure map shows
		self.assertTrue(self.browser.find_element_by_class_name('gm-style').is_displayed())
		# Access single post
		self.browser.find_element_by_class_name('title').click()
		time.sleep(1)
		flag = True
		for d in list(self.browser.current_url.split('/')[-1]):
			flag &= (d in string.digits)
		self.assertTrue(flag)
		self.browser.find_element_by_link_text('Listings').click()
		time.sleep(1)
		self.assertEqual(self.url + 'posts', self.browser.current_url)
		self.browser.find_element_by_link_text(email.lower()).click()
		time.sleep(1)
		self.assertEqual(self.url + 'profile', self.browser.current_url)
		self.browser.find_element_by_link_text('Profile').click()
		time.sleep(1)
		self.browser.find_element_by_css_selector('form.button_to input[type="submit"]').click()
		time.sleep(1)
		alert = self.browser.switch_to_alert()
		alert.accept()


if __name__ == '__main__':
	unittest.main(verbosity=2)
