from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import unittest
import time

class LoginLogoutTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome('./chromedriver')
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testDialog(self):
		self.browser.find_element_by_id('login').click()
		self.assertTrue(self.browser.find_element_by_id('darken').is_displayed())
	def testDarken(self):
		self.browser.find_element_by_id('login').click()
		self.assertTrue(self.browser.find_element_by_id('login_dialog').is_displayed())
	def testLoginDarken(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('darken').is_displayed())
	def testLoginDialog(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('login_dialog').is_displayed())
	def testLoginUser(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('user').is_displayed())
	def testLoginLogout(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('logout').is_displayed())
	def testLogoutLogin(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout').click()
		time.sleep(2)
		self.assertTrue(self.browser.find_element_by_id('login').is_displayed())
	def testLogoutUser(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('user').is_displayed())
	def testLogoutLogout(self):
		self.browser.find_element_by_id('login').click()
		self.browser.find_element_by_id('login_dialog').click()
		self.browser.find_element_by_id('loginemail').send_keys('sidwyn@gmail.com')
		self.browser.find_element_by_id('loginpassword').send_keys('password')
		self.browser.find_element_by_id('login_submit').click()
		time.sleep(2)
		self.browser.find_element_by_id('logout').click()
		time.sleep(2)
		self.assertFalse(self.browser.find_element_by_id('logout').is_displayed())

if __name__ == '__main__':
	unittest.main(verbosity=2)
