Feature: Add Likes

    Background:
        * url apiUrl

    Scenario: Add Likes
    Given path 'articles', slug, 'favorite'
    And request {}
    When method POST
    Then status 200
    * def likesCount = response.article.favoritesCount