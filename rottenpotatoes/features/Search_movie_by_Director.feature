Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add director to existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Alien" should be "Ridley Scott"

Scenario: find movie with same director
  Given I am on the details page for "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the RottenPotatoes home page 
  And   I should see "'Alien' has no director info"
  
  
Scenario: add movie
  Given I am on the RottenPotatoes home page
  And  I follow "Add new movie"
  Then I should be on the new movie page
  When I fill in "Title" with "The Infiltrator"
  And I select "R" from "Rating"
  # And I select "2016-07-15" from "Release On"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "The Infiltrator was successfully created."
  
Scenario: sort movies alphabetically
  Given I am on the RottenPotatoes home page
  When I follow "Movie Title"
  Then I should see "Blade Runner" before "Star Wars"
  And I should see "Alien" before "THX-1138"

