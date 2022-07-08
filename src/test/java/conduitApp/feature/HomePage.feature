
Feature: Test for the home page

    Background: Define URL
    Given url apiUrl

    Scenario: Get all tags

        Given path 'tags'
        When method GET
        Then status 200
        And match response.tags contains 'welcome'

    Scenario: Get 3 articles from page

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles == '#[3]'