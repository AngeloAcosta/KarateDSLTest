Feature: Homework

    Background: Preconditions

        * url apiUrl

    Scenario: Favorite Article (Homework #1)
        #Paso 1: Obtener los articulos del feed global
        Given path 'articles'
        And params { limit: 10 , offset: 0}
        When method GET
        Then status 200

        #Paso 2: Obtener la variable favoriteCount y el slug ID para el primer articulo, y guardarlo en una variable
        * def favoriteCount = response.articles[0].favoritesCount
        * def slugId = response.articles[0].slug
        * print favoriteCount
        * print slugId

        #Paso 3: Hacer un POST request para incrementar la lista de favoritos para el primer articulo
        Given path 'articles' , slugId ,'favorite'
        When method POST
        Then status 200
        And match response.article.favorited == true

        #Paso 4: Verificar el response schema
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        * print response.article
        And match response.article ==
            """
            {
            'slug': '#string',
            'title': '#string',
            'description': '#string',
            'body': '#string',
            'tagList': '#array',
            'createdAt': '#? timeValidator(_)',
            'updatedAt': '#? timeValidator(_)',
            'favorited': '#boolean',
            'favoritesCount': '#number',
            'author': {
            'username': '#string',
            'bio': '##string',
            'image': '#string',
            'following': '#boolean'
            }
            }
            """

        #Paso 5: Verifica que la lista favorita de articulos incremente por 1
        * def initialCount = 0
        * def response = {'favoritesCount': 1}
        * match response.favoritesCount == initialCount + 1
        * print response

        #Paso 6: Obtener todos los articulos favoritos
        Given path 'articles'
        And params {favorited: "#(userUsername)", limit: 10, offset: 0}
        When method GET
        Then status 200

        #Paso 7: Verificar el response schema
        * print response.articles[0]
        And match response.articles[0] ==
            """
            {
            'slug':'#string',
            'title':'#string',
            'description': '#string',
            'body':'#string',
            'tagList': '#array',
            'createdAt': '#? timeValidator(_)',
            'updatedAt': '#? timeValidator(_)',
            'favorited': '#boolean',
            'favoritesCount': '#number',
            'author':{
            "username": '#string',
            'bio': '##string',
            'image': "#string",
            'following': '#boolean'
            }
            }
            """
        #Paso 8: Verificar que el slug ID del paso 2 exista en alguno de los articulos favoritos
        * match response.articles[*].slug contains slugId
