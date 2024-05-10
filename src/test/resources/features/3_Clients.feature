@Regression @Clients
Feature: Clients section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @Smoke @ClientsSuccessful
  Scenario: Add new client to workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/clients
    And body jsons/bodies/newClient.json
    When execute method POST
    Then the status code should be 201

  @Smoke @ClientsSuccessful
  Scenario: Get clients from workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/clients
    When execute method GET
    Then the status code should be 200
    And response should be $.[1].name = Client_TP5

  @Smoke @ClientsFailure
  Scenario: 400 Bad Request cause: Missing body
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/clients
    When execute method POST
    And the status code should be 400
    Then response should be message contains Required request body is missing

  @Smoke @ClientsFailure
  Scenario: 401 Unauthorized cause: Missing or multiple tokens.
    Given endpoint /v1/workspaces/{{workspaceId}}/clients
    And header x-api-key = *
    When execute method GET
    And the status code should be 401
    Then response should be message contains Multiple or none auth tokens present

  @Smoke @ClientsFailure
  Scenario: 404 Not found cause: wrong endpoint.
    Given endpoint /v1/clients
    And header x-api-key = OGI1NzZiMzAtOWU2Ni00MzFjLWI0MmItYjMzYzQyN2ZiZWFl
    When execute method GET
    And the status code should be 404
    Then response should be error contains Not Found