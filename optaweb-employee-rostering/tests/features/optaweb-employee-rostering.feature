@rhdm-7/rhdm74-optaweb-employee-rostering
Feature: Red Hat Business Optimizer OptaWeb Employee Rostering 7.4 tests

  Scenario: Web console is available
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | path     | /gwtui/gwtui.html |
         | expected_status_code | 200 |
         | wait     | 180   |
