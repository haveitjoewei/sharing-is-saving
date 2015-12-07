from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
import os
import unittest
import string
import time
import random

class ListingsTestCase(unittest.TestCase):
	def setUp(self):
		opts = webdriver.ChromeOptions()
		opts.binary_location = "C:\Users\Victor\AppData\Local\Google\Chrome SxS\Application\chrome.exe"
		self.browser = webdriver.Chrome(chrome_options=opts)
		self.url = "https://sharingissaving.herokuapp.com/"
		self.browser.get(self.url)
		self.browser.set_window_size(1200, 900)
		self.addCleanup(self.browser.quit)
	def testLoginLogoutListings(self):
		self.assertEqual(self.url, self.browser.current_url)
		# Log in
		self.browser.find_element_by_link_text('Login').click()
		time.sleep(1)
		self.browser.find_element_by_id('user_email').send_keys('vsutardja@gmail.com')
		self.browser.find_element_by_id('user_password').send_keys('1234567890')
		self.browser.find_element_by_class_name('button').click()
		time.sleep(1)
		# Assert logged in status
		self.assertTrue(self.browser.find_element_by_link_text('vsutardja@gmail.com').is_displayed())
		# Go to listings
		self.browser.find_element_by_id('home-search-button').click()
		time.sleep(2)
		current_url = self.browser.current_url
		part1 = current_url[38:49]
		part2 = current_url[-8:]
		self.assertEqual('posts?utf8=', part1)
		self.assertEqual('&search=', part2)
		# Make sure map shows
		self.assertTrue(self.browser.find_element_by_class_name('gm-style').is_displayed())
		# Test categories
		num_entries = len(self.browser.find_elements_by_class_name('title'))
		self.browser.find_element_by_id('categories').click()
		time.sleep(1)
		self.browser.find_element_by_css_selector('.filter_form p').click()
		self.browser.find_element_by_css_selector('.filter_form input[type="submit"]').click()
		num_entries = num_entries - len(self.browser.find_elements_by_class_name('title'))
		self.assertTrue(num_entries >= 0)
		# Access single post
		self.browser.find_element_by_class_name('title').click()
		time.sleep(1)
		flag = True
		for d in list(self.browser.current_url.split('/')[-1]):
			flag &= (d in string.digits)
		self.assertTrue(flag)
		# Search
		self.browser.find_element_by_id('search-bar').send_keys('military')
		self.browser.find_element_by_id('search-button').click()
		time.sleep(1)
		self.assertEqual(len(self.browser.find_elements_by_class_name('title')), 1)
		# Log out
		self.assertTrue(self.browser.find_element_by_link_text('Logout').is_displayed())
		self.browser.find_element_by_link_text('Logout').click()
		time.sleep(1)


if __name__ == '__main__':
	unittest.main(verbosity=2)
