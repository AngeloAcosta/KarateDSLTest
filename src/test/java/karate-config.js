function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  // Si ponemos en el CLI mvn test "-Dkarete.options=--tags @debug" "-Dkarate.env=dev" ejecutará los test con tags @debug con variables de el ambiente dev
  if (env == 'dev') {
    config.userEmail = 'karateUdemy1@test.com'
    config.userPassword = 'karate123'
  }
  // Si ponemos en el CLI mvn test "-Dkarete.options=--tags @debug" "-Dkarate.env=qa" ejecutará los test con tags @debug con variables de el ambiente qa
  if (env == 'qa') {
    config.userEmail = 'karateUdemy2@test.com'
    config.userPassword = 'karate12345'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature',config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}