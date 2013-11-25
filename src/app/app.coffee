angular.module("AngularCafe",["ngRoute", "ui.router", "templates-app", "templates-common", "AngularCafe.home", "titleService", "ngMatrix"])
.config(($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise "/home"
)
.run((titleService) ->
    titleService.setSuffix " | AngularCafe Project Template"
)
.controller "AppCtrl", ($scope) ->
    $scope.initiatives =
        Web:
            Angular:
                wg1: 20
                wg2: 10
                wg3: 0
            Grunt:
                wg1: 30
                wg2: 0
                wg3: 30
            LESS:
                wg1: 0
                wg2: 10
                wg3: 10
        Agile:
            "TDD because it is the only way.":
                wg1: 0
                wg2: 0
                wg3: 10
            "Full Bower Integration":
                wg1: 0
                wg2: 30
                wg3: 10

    $scope.features =
        Angular:
            wg1: 20
            wg2: 10
            wg3: 0
        Grunt:
            wg1: 30
            wg2: 0
            wg3: 30
        LESS:
            wg1: 0
            wg2: 10
            wg3: 10

    $scope.workgroups =
        wg1:
            title: "Space Age"
        wg2:
            title: "Wondermunt"
        wg3:
            title: "Lions"

    $scope.capacityGroups =
        cg1:
            title: 'Capacity Group 1'
            children:
                wg1:
                    title: 'Workgroup 1'
                wg2:
                    title: 'Workgroup 2'
        cg2:
            title: 'Capacity Group 2'
            children:
                wg3:
                    title: 'Workgroup 3'
