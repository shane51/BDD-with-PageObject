# encoding: utf-8
Given /^I open "(.*?)"$/ do |site|
  openSite(site)
end

When /^I search for "(.*?)"$/ do |keyword|
  searchKeyWord(keyword)
end

And /^I open the first book$/ do
  element = @driver.find_element(:xpath =>"//div[@id=\"result_0\"]//span[@class=\"a-link-normal\"]")
  element.click
end

And /^I add the first book to shopping cart$/ do
  @bookTitle = @driver.find_element(:id => "productTitle").text
  element = @driver.find_element :name => "submit.add-to-cart"
  element.click
end

Then /^I should see the book in my shopping cart$/ do
  confirm = @driver.find_element(:id => "confirm-text")
  confirm.text.include?("1 item added to Cart")
  book = @driver.find_element(:xpath => "//div[@class=\"a-row-a-size-base word-break\"]/a")
  book.attribute("title").should == @bookTitle
end

def openSite(site)
  @driver.get(site)
end

def searchKeyWord(keyword)
  searchKeyWord = @driver.find_element(:id => "twotabsearchtextbox")
  searchKeyWord.clear
  searchKeyWord.send_keys keyword
  element = @driver.find_element :class => "nav-input"
  element.click
end
