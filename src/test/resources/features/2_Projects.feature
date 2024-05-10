@Regression @Projects
Feature: Projects section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @Smoke
  Scenario: Create project inside workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201

  @Smoke @GetProjects
  Scenario: Get projects inside workspace
    Given call 1_Workspaces.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @Smoke @FindProjectByID
  Scenario: Get specific project by its ID
    Given call 2_Projects.feature@GetProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @Smoke
  Scenario: Edit project
    Given call 2_Projects.feature@FindProjectByID
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200

  @DeleteProject
  Scenario: Delete project
    Given call 2_Projects.feature@FindProjectByID
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method DELETE
    Then the status code should be 200