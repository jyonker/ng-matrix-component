ngMatrixModule = angular.module 'ngMatrix', []

ngMatrixModule.directive 'matrix', () ->
    restrict: 'E'
    replace: true
    template: '<table class="matrix"></table>'
    link: (scope, element, attrs) ->
        loadData = () ->
            colDefs = scope[attrs.colDefs]
            rowData = scope[attrs.rowData]

            if colDefs
                headerRow = angular.element '<tr></tr>'
                headerRow.append "<th></th>"
                for col, def of colDefs
                    headerRow.append "<th>#{def.title}</th>"

                element.append headerRow

            for key, row of rowData
                matrixRow = angular.element "<tr></tr>"
                matrixRow.append "<td class='domain'>#{key}</td>"
                for innerKey, value of row
                    matrixRow.append "<td>#{value}</td>" if (colDefs and colDefs[innerKey]) or not colDefs

                element.append matrixRow

        loadData()
