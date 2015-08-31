Feature:
In order to purchase it later
As a consumer
I want to add a book to my shopping cart



Scenario: Consumer can add a book to shopping cart
    Given I open "http://www.amazon.com"
    When I search for "The Lean Startup"
    And I open the first book
    And I add the first book to shopping cart
    Then I should see the book in my shopping cart
