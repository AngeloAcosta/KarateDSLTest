Feature: Articles

    Background: Define URL
         Given url apiUrl

    Scenario: Create a new article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Unique text1","description": "teteste","body": "tesat"}}
        When method POST
        Then status 200
        And match response.article.title == 'Unique text1'

    Scenario: Create and delete an article
        # Creamos articulo nuevo
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete Method test","description": "Article to delete","body": "Delete test"}}
        And method POST
        Then status 200
        * def creatingArticle = response.article.title
        * def articleToDelete = response.article.slug

        #Validamos que exista en la lista total de articulos
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles[0].title == creatingArticle

        #Borramos el articulo previamente creado
        Given path 'articles', articleToDelete
        When method DELETE
        Then status 200
        
        #Validamos que ya no exista en la lista total de articulos
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles[0].title != creatingArticle




