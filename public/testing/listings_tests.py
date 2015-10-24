from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import unittest

class ListingsTestCase(unittest.TestCase):
	def setUp(self):
		chrome_options = Options()
		chrome_options.binary_location = 'C:\Users\Victor\AppData\Local\Google\Chrome SxS\Application\chrome.exe'
		self.browser = webdriver.Chrome(chrome_options=chrome_options)
		self.browser.get('http://sharingissaving.herokuapp.com/listings.html')
		self.addCleanup(self.browser.quit)
	def testPageTitle(self):
		self.assertIn('Sharing Is Saving', self.browser.title)
	def testHomeLink(self):
		self.browser.find_element_by_link_text('Sharing Is Saving').click()
		self.assertEqual('http://sharingissaving.herokuapp.com/home.html', self.browser.current_url)
	def testListingsLink(self):
		self.browser.find_element_by_link_text('Listings').click()
		self.assertEqual('http://sharingissaving.herokuapp.com/listings.html', self.browser.current_url)
	def testPostLink(self):
		self.browser.find_element_by_link_text('Post').click()
		self.assertEqual('http://sharingissaving.herokuapp.com/post.html', self.browser.current_url)

if __name__ == '__main__':
	unittest.main(verbosity=2)
