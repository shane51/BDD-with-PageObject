# encoding: utf-8
Given /^I open "(.*?)"$/ do |site|
  openSite(site)
end

When /^I search for "(.*?)"$/ do |keyword|
  searchKeyWord(keyword)
end

And /^I open the first book$/ do
  openFirstItemInSearchResult
end

And /^I add the first book to shopping cart$/ do
  getCurrentItemTitle
  addToShoppingCart
end

Then /^I should see the book in my shopping cart$/ do
  verifyItemAddedToShoppingCart
  verifyItemAddedShownInShoppingCart
end

def openSite(site)
  @driver.get(site)
end

def searchKeyWord(keyword)
  searchKeyWord = findElementBy("id", "twotabsearchtextbox")
  searchKeyWord.clear
  searchKeyWord.send_keys keyword
  element = findElementBy("class", "nav-input")
  element.click
end

def openFirstItemInSearchResult
  element = findElementBy("xpath","//div[@id=\"result_0\"]//span[@class=\"a-link-normal\"]")
  element.click
end

def getCurrentItemTitle
    @bookTitle = findElementBy("id","productTitle").text
end

def addToShoppingCart
  element = findElementBy("name","submit.add-to-cart")
  element.click
end

def verifyItemAddedToShoppingCart
  confirm = findElementBy("id", "confirm-text")
  confirm.text.include?("1 item added to Cart")
end

def verifyItemAddedShownInShoppingCart
  book = findElementBy("xpath","//div[@class=\"a-row-a-size-base word-break\"]/a")
  book.attribute("title").should == @bookTitle
end

def findElementBy(type, value)
  case type
  when "class"
    @driver.find_element(:class => value)
  when "id"
    element = @driver.find_element(:id => value)
  when "name"
    element = @driver.find_element(:name => value)
  when "css"
    element = @driver.find_element(:css => value)
  when "id"
    element = @driver.find_element(:id => value)
  when "link"
    element = @driver.find_element(:link => value)
  when "partial_link"
    element = @driver.find_element(:partial_link => value)
  when "tag"
    element = @driver.find_element(:link => value)
  when "xpath"
    element = @driver.find_element(:xpath => value)
  else
    puts "Unknown type"
  end
end
