Feature: Test for the home page

    Background: Define URL
        * url apiUrl

    Scenario: Get all tags

        Given path 'tags'
        When method GET
        Then status 200
        And match response.tags contains 'welcome'
        And match response.tags !contains 'truck'
        And match response.tags contains any ['fish','dog','codebaseShow']
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 3 articles from Page

        * def timeValidator = read('classpath:helpers/timeValidator.js')

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles == '#[3]'
        And match each response.articles ==
            """
            {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": '#boolean',
            "favoritesCount": '#number',
            "author": {
            "username": "#string",
            "bio": ##string,
            "image": "#string",
            "following": '#boolean'
            }
            }
            """

    Scenario: Conditional Logic
        Given params { limit : 10, offset: 0 }
        Given path 'articles'
        When method GET
        Then status 200
        * print response
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        * if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)

        Given params { limit : 10, offset: 10 }
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles[0].favoritesCount == 1

    Scenario: Retry call

        * configure retry = { attemps: 10, interval: 5000 }

        Given params { limit : 10, offset: 0 }
        Given path 'articles'
        And retry until response.articles[0].favoritesCount == 1
        When method GET
        Then status 200

    @debug
    ### HARD-CODING SLEEP FUCTION.
    Scenario: Sleep call

        * def sleep = function(pause) { java.lang.Thread.sleep(pause) }

        Given params { limit : 10, offset: 0 }
        Given path 'articles'
        When method GET
        * eval sleep(5000)
        Then status 200
