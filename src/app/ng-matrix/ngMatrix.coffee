ngMatrixModule = angular.module 'ngMatrix', []

ngMatrixModule.directive 'matrix', () ->
    restrict: 'E'
    replace: true
    template: '<table></table>'
    link: (scope, element, attrs) ->
        loadData = () ->
            cols = scope[attrs.colDefs]
            data = scope[attrs.rowData]

            if cols
                headerRow = angular.element '<tr></tr>'
                for col, def of cols
                    headerRow.append "<th>#{def.title}</th>"

                element.append headerRow

            for key, row of data
                matrixRow = angular.element "<tr id=\"mrow-#{key}\"></tr>"
                for innerKey, value of row
                    matrixRow.append "<td>#{innerKey}: #{value}</td>" if (cols and cols[innerKey]) or not cols

                element.append matrixRow

        loadData()
