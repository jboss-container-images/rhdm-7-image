@rhdm-7/rhdm74-decisioncentral
Feature: Standalone Decision Central tests

  Scenario: Web console is available
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | path     | /kie-drools-wb.jsp |
         | expected_status_code | 200 |
         | wait     | 120   |
