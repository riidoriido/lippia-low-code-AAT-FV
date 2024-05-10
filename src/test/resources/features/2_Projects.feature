@Regression @Projects
Feature: Projects section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @Smoke @ProjectSuccessful
  Scenario: Create project inside workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201

  @Smoke @ProjectSuccessful @GetProjects
  Scenario: Get projects inside workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @Smoke @ProjectSuccessful @FindProjectByID
  Scenario: Get specific project by its ID
    Given call 2_Projects.feature@GetProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @Smoke @ProjectSuccessful
  Scenario: Edit project
    Given call 2_Projects.feature@FindProjectByID
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200

  @DeleteProject @ProjectSuccessful
  Scenario: Delete project
    Given call 2_Projects.feature@FindProjectByID
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method DELETE
    Then the status code should be 200

  @Smoke @ProjectFailure
  Scenario: 401 Unauthorized cause: Missing or mutltiple tokens.
    Given endpoint /v1/workspaces/653a91fd9aa6dc598ef16102/projects
    And header x-api-key = OGI1NzZiMzAtOWU2Ni00MzFjLWI0MmItYjMzYzQyN2ZiZWFl
    When execute method GET
    Then the status code should be 401
    And response should be message contains Multiple or none auth tokens present

  @Smoke @ProjectFailure
  Scenario: 404 Not found cause: Not found, wrong endpoint.
    Given endpoint api/v1/workspaces/653a91fd9aa6dc598ef16102/project/
    When execute method GET
    Then the status code should be 404
    And response should be error contains Not Found

  @Smoke @ProjectFailure
  Scenario: 400 Bad Request cause: Project ID isn't found in workspace.
    Given call Clockify.feature@GetProjects
    And endpoint /v1/workspaces/653a91fd9aa6dc598ef16102/projects/induce_error
    When execute method GET
    Then the status code should be 400