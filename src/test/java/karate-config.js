function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'karateUdemy1@test.com'
    config.userPassword = 'karate123'
  }
  if (env == 'qa') {
    config.userEmail = 'karateUdemy2@test.com'
    config.userPassword = 'karate12345'
  }
  return config;
}