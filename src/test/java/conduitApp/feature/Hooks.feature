Feature: Hooks

    Background:
        # * def result = callonce read('classpath:helpers/Dummy.feature')
        # * def username = result.username

        #after hooks
        * configure afterScenario = function() {karate.call('classpath:helpers/Dummy.feature')}
        * configure afterFeature = 
        """
        function() {
            karate.log('After Feature text')
        }
        """

    Scenario: First Scenario
        #* print username
        * print 'this is first scenario'

    Scenario: Second Scenario
        #* print username
        * print 'this is second scenario'