@Regression @Workspaces
Feature: Workspaces section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @Smoke @GetWorkspaces
  Scenario: Get all workspaces
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[4].id

  @Smoke
  Scenario: Add new workspace
    Given endpoint /v1/workspaces
    And body jsons/bodies/newWorkspace.json
    When execute method POST
    Then the status code should be 201

