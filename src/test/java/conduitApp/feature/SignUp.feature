Feature: Testing Sign Up Feature

    Background: Define URL
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given url apiUrl

    Scenario: Creating User

        Given path 'users'
        And request
            """
            {
            "user": {
            "email": #(randomEmail),
            "password": "UdemyKarateAuto1",
            "username": #(randomUsername)
            }
            }
            """
        When method POST
        Then status 200
        And match response.user ==
            """
            {
            "email": '#(randomEmail)',
            "username": '#(randomUsername)',
            "bio": '#null',
            "image": '#null',
            "token": '#string'
            }
            """


    @debug
    Scenario Outline: Validate Sign Up error messages

        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
            """
        When method POST
        Then status 422
        And match response == <errorMessage>

        Examples: Types of error messages

            | email                             | password         | username          | errorMessage                                       |
            | #(randomEmail)                    | UdemyKarateAuto1 | karateUser123     | {"errors":{"username":["has already been taken"]}} |
            | UdemyKarateAuto166@mailinator.com | UdemyKarateAuto1 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
