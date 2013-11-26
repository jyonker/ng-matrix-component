angular.module("AngularCafe",["ngRoute", "ui.router", "templates-app", "templates-common", "AngularCafe.home", "titleService", "ngMatrix"])
.config(($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise "/home"
)
.run((titleService) ->
    titleService.setSuffix " | ng-matrix"
)
.controller "AppCtrl", ($scope) ->
    $scope.withsubdomains =
        Web:
            Angular:
                g1: 20
                g2: 10
                g3: 0
            Grunt:
                g1: 30
                g2: 0
                g3: 30
            LESS:
                g1: 0
                g2: 10
                g3: 10
        Agile:
            "TDD because it is the only way.":
                g1: 0
                g2: 0
                g3: 10
            "Full Bower Integration":
                g1: 0
                g2: 30
                g3: 10

    $scope.domains =
        Angular:
            g1: 20
            g2: 10
            g3: 0
        Grunt:
            g1: 30
            g2: 0
            g3: 30
        LESS:
            g1: 0
            g2: 10
            g3: 10

    $scope.ranges =
        g1:
            title: "Space Age"
        g2:
            title: "Wondermunt"
        g3:
            title: "Lions"

    $scope.withsubranges =
        a1:
            title: 'Group 1'
            children:
                g1:
                    title: 'Z1'
                g2:
                    title: 'Z2'
        a2:
            title: 'Group 2'
            children:
                g3:
                    title: 'Z3'
