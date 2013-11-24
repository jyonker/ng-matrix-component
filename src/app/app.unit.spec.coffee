
describe "AngularCafe", ->
    AppCtrl = undefined
    scope = undefined
    location = undefined
    controller = undefined

    beforeEach module("AngularCafe")

    beforeEach inject(($rootScope, $controller, $location) ->
        scope = $rootScope.$new()
        location = $location
        controller = $controller
    )

    describe "AppCtrl", ->
        beforeEach inject(($rootScope, $location) ->
            scope = $rootScope.$new()
            location = $location
            AppCtrl = controller("AppCtrl",
                $scope: scope
                $location: location
            )
        )

        it "should have an AppCtrl", ->
            expect(AppCtrl).to.be.defined
            AppCtrl.should.be.defined
            assert.isDefined(AppCtrl,"fail message")



