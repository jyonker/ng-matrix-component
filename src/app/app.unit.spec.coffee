describe "AppCtrl", ->

    beforeEach module("AngularCafe")

    beforeEach inject(($rootScope, $location, $controller) ->
        @scope = $rootScope.$new()
        @AppCtrl = $controller("AppCtrl",
            $scope: @scope
            $location: $location
        )
    )

    it "should have an AppCtrl", ->
        expect(@AppCtrl).to.be.defined
        @AppCtrl.should.be.defined
        assert.isDefined(@AppCtrl,"fail message")



