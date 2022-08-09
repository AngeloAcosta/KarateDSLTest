Feature: Articles

    Background: Define URL
         * url apiUrl
         * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
         * def dataGenerator = Java.type('helpers.DataGenerator')
         * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title;
         * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description;
         * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body;

    Scenario: Create a new article
        Given path 'articles'
        And request articleRequestBody
        When method POST
        Then status 200
        * print response
        And match response.article.title == articleRequestBody.article.title

    Scenario: Create and delete an article
        # Creamos articulo nuevo
        Given path 'articles'
        And request articleRequestBody
        And method POST
        Then status 200
        * def creatingArticle = response.article.title
        * def articleToDelete = response.article.slug
        * print response

        #Validamos que exista en la lista total de articulos
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method GET
        Then status 200
        * print creatingArticle
        * print response
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




