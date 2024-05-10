@Regression @Workspaces
Feature: Workspaces section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

    @Smoke @WorkspacesSuccessful @GetWorkspaces
    Scenario: Get all workspaces
      Given endpoint /v1/workspaces
      When execute method GET
      Then the status code should be 200
      * define workspaceId = $.[4].id

    @Smoke @WorkspacesSuccessful
    Scenario: Add new workspace
      Given endpoint /v1/workspaces
      And body jsons/bodies/newWorkspace.json
      When execute method POST
      Then the status code should be 201

    @Smoke @WorkspacesFailure
    Scenario: 400 Bad Request cause: Missing body
      Given endpoint /v1/workspaces
      When execute method POST
      Then the status code should be 400
      And response should be message contains Required request body is missing

    @Smoke @WorkspacesFailure
    Scenario: 401 Unauthorized cause: Missing or mutltiple tokens.
      Given endpoint /v1/workspaces
      And header x-api-key = *
      When execute method GET
      Then the status code should be 401
      And response should be message contains Multiple or none auth tokens present

    @Smoke @WorkspacesFailure
    Scenario: 404 Not found cause: wrong endpoint.
      Given endpoint api/workspace
      And header x-api-key = OGI1NzZiMzAtOWU2Ni00MzFjLWI0MmItYjMzYzQyN2ZiZWFl
      When execute method GET
      Then the status code should be 404
      And response should be error contains Not Found
