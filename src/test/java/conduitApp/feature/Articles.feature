Feature: Articles

    Background: Define URL
         Given url apiUrl
        * def tokenResponse = callonce   read('classpath:helpers/CreateToken.feature')
        * def token = tokenResponse.authToken

    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Unique text1","description": "teteste","body": "tesat"}}
        When method POST
        Then status 200
        And match response.article.title == 'Unique text1'

@debug
    Scenario: Create and delete an article

        #Limpiamos el primer articulo, para validar que no exista el nuestro
        Given header Authorization = 'Token ' + token
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        * print response
        * def firtsArticle = response.articles[0].slug

        Given header Authorization = 'Token ' + token
        And path 'articles', firtsArticle
        When method DELETE
        Then status 200

        # Creamos articulo nuevo
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete Method test","description": "Article to delete","body": "Delete test"}}
        And method POST
        Then status 200
        * def creatingArticle = response.article.title
        * def articleToDelete =  response.article.slug

        #Validamos que exista en la lista total de articulos
        Given header Authorization = 'Token ' + token
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles[0].title == creatingArticle

        #Borramos el articulo previamente creado
        Given header Authorization = 'Token ' + token
        Given path 'articles', articleToDelete
        When method DELETE
        Then status 200
        
        #Validamos que ya no exista en la lista total de articulos
        Given header Authorization = 'Token ' + token
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles[0].title != creatingArticle




