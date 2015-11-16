from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import unittest
import time

class Loginlogout_buttonTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome('./chromedriver')
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testLogin(self):
		self.browser.find_element_by_id('login').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_email').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('user_password').send_keys('password')
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
	def testLoginUser(self):
		self.browser.find_element_by_id('login').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_email').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('user_password').send_keys('password')
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('username').is_displayed())
	def testLoginlogout_button(self):
		self.browser.find_element_by_id('login').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_email').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('user_password').send_keys('password')
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('logout_button').is_displayed())
	def testlogout_buttonLogin(self):
		self.browser.find_element_by_id('login').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_email').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('user_password').send_keys('password')
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout_button').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('login').is_displayed())
	# def testlogout_buttonUser(self):
	# 	self.browser.find_element_by_id('login').click()
	# 	time.sleep(2)
	# 	self.browser.find_element_by_id('user_email').send_keys('sidwyn@gmail.com')
	# 	self.browser.find_element_by_id('user_password').send_keys('password')
	# 	self.browser.find_element_by_name('commit').click()
	# 	time.sleep(2)
	# 	self.browser.find_element_by_id('logout_button').click()
	# 	time.sleep(2)
	# 	self.assertFalse(self.browser.find_element_by_id('username').is_displayed())
	# def testlogout_buttonlogout_button(self):
	# 	self.browser.find_element_by_id('login').click()
	# 	time.sleep(2)
	# 	self.browser.find_element_by_id('user_email').send_keys('sidwyn@gmail.com')
	# 	self.browser.find_element_by_id('user_password').send_keys('password')
	# 	self.browser.find_element_by_name('commit').click()
	# 	time.sleep(2)
	# 	self.browser.find_element_by_id('logout_button').click()
	# 	time.sleep(2)
	# 	self.assertFalse(self.browser.find_element_by_id('logout_button').is_displayed())

if __name__ == '__main__':
	unittest.main(verbosity=2)
