@Regression @Clockify
Feature: Clockify API TP4

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @GetWorkspaces
  Scenario: Get all workspaces
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[3].id

  @CreateProject
  Scenario: Create project inside workspace
    Given call ClockifyAPI.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And body jsons/bodies/newProject.json
    When execute method POST
    Then the status code should be 201

  @GetProjects
  Scenario: Get projects inside workspace
    Given call ClockifyAPI.feature@GetWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @FindProjectByID
  Scenario: Get specific project by its ID
    Given call ClockifyAPI.feature@GetProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200
    And response should be $.name = TP4 - LowCode_test

  @EditProject
  Scenario: Edit project
    Given call ClockifyAPI.feature@FindProjectByID
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200