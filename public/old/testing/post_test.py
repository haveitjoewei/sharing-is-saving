from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
import unittest
import time
import string
import random

class PostTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		self.browser = webdriver.Chrome("./chromedriver")
		self.browser.get('http://localhost:3000/')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		time.sleep(2)
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testPost(self):
		email1 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		email2 = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10)) + '@email.com'
		testpost = "Test Post: " + ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(3))

		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("John")
		self.browser.find_element_by_id('user_last_name').send_keys("Hancock")
		self.browser.find_element_by_id('user_email').send_keys(email1)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)

		self.browser.find_element_by_id('new_post').click()
		time.sleep(2)
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
	
		self.browser.find_element_by_id('logout_button').click()

		self.browser.find_element_by_id('home').click()
		self.browser.find_element_by_id('signup').click()
		time.sleep(2)
		self.browser.find_element_by_id('user_first_name').send_keys("Jane")
		self.browser.find_element_by_id('user_last_name').send_keys("Felder")
		self.browser.find_element_by_id('user_email').send_keys(email2)
		self.browser.find_element_by_id('user_password').send_keys("1234567890")
		self.browser.find_element_by_id('user_password_confirmation').send_keys("1234567890")
		self.browser.find_element_by_name('commit').click()
		time.sleep(2)

		self.browser.find_element_by_id('listings_tab').click()
		# self.browser.find_element_by_xpath("//*[@id='mainbody']/section/article[1]/div[3]/a").click()
		time.sleep(2)



if __name__ == '__main__':
	unittest.main(verbosity=2)
