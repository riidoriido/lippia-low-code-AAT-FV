@Regression @Tasks
Feature: Tasks section

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk

  @Smoke
  Scenario: Add new task to project
    Given call 2_Projects.feature@GetProjects
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks
    And body jsons/bodies/newTask.json
    When execute method POST
    Then the status code should be 201

  @Smoke @GetTasks
  Scenario: Get tasks from project
    Given call 2_Projects.feature@FindProjectByID
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks
    When execute method GET
    Then the status code should be 200
    * define taskId = $.[0].id

  @Smoke
  Scenario: Update task on project
    Given call 4_Tasks.feature@GetTasks
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks/{{taskId}}
    And body jsons/bodies/editTask.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.name = Task edited with Lippia

  @Smoke
  Scenario: Delete task from project
    Given call 4_Tasks.feature@GetTasks
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks/{{taskId}}
    When execute method DELETE
    Then the status code should be 200