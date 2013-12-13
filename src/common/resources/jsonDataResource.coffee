angular.module("resources", ['ngResource'])
.factory('jsonDataResource',
    ($resource) ->
        $resource('/data/:filename',
            filename: '@filename'
        )
    )