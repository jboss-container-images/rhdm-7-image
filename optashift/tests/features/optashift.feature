@rhdm-7/rhdm70-optashift
Feature: RHDM Employee Rostering Business Optimizer tests

  Scenario: Web console is available
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | path     | /gwtui/gwtui.html |
         | expected_status_code | 200 |
         | wait     | 180   |

