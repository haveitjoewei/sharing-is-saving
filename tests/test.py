from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys
import time

# Get local session of chrome
browser = webdriver.Chrome("/Users/josephwei/Downloads/chromedriver") 

# Load page
browser.get("https://sharingissaving.herokuapp.com/")
assert "Sharing Is Saving" in browser.title
time.sleep(1.2)

# Initialize stuff
listings_button = browser.find_element_by_id('listings')
post_button = browser.find_element_by_id('post')
signup_button = browser.find_element_by_id('signup')
signup_submit = browser.find_element_by_id('signup_submit')
login_button = browser.find_element_by_id('login')
login_submit = browser.find_element_by_id('login_submit')
outside = browser.find_element_by_id('darken')

# Post Test

# Signup Test
signup_button.click()
outside.click()
signup_button.click()
# fill out
signup_submit.click()

# Login Test 
login_button.click()
outside.click() 
login_button.click()
# fill out
login_submit.click()



# elem = browser.find_element_by_name("p") # Find the query box
# elem.send_keys("seleniumhq" + Keys.RETURN)
# time.sleep(0.2) # Let the page load, will be added to the API
# try:
#     browser.find_element_by_xpath("//a[contains(@href,'http://seleniumhq.org')]")
# except NoSuchElementException:
#     assert 0, "can't find seleniumhq"
browser.close()