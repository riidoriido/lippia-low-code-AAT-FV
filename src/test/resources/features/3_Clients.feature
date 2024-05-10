@Regression @Clients
Feature: Clients section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @Smoke
  Scenario: Add new client to workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/clients
    And body jsons/bodies/newClient.json
    When execute method POST
    Then the status code should be 201

  @Smoke
  Scenario: Get clients from workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/clients
    When execute method GET
    Then the status code should be 200
    And response should be $.[1].name = Client_TP5

