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
                headerRow = _createHeaderRow(colDefs)

            for key, row of rowData
                matrixRow = angular.element "<tr></tr>"
                hasSubDomain = _hasSubDomain(row)
                if hasSubDomain
                    _createMatrixRowsWithSubDomain(matrixRow, key, row)
                else
                    _createMatrixRow(matrixRow, key, row, colDefs)

            headerRow.prepend "<th></th>" if hasSubDomain

        _createHeaderRow = (colDefs) ->
            headerRow = angular.element '<tr></tr>'
            headerRow.append "<th></th>"
            for col, def of colDefs
                headerRow.append "<th>#{def.title}</th>"

            element.append headerRow

            return headerRow

        _hasSubDomain = (row) ->
            return (_.size(angular.copy(row[_.keys(row)[0]])) > 0)

        _createMatrixRowsWithSubDomain = (matrixRow, key, row) ->
            domainSize = _.size(angular.copy(row))
            matrixRow.append "<td class='domain' rowspan='#{domainSize + 1}'>#{key}</td>"
            element.append matrixRow

            for innerKey, value of row
                domainRow = angular.element "<tr></tr>"
                domainRow.append "<td class='subdomain'>#{innerKey}</td>"

                for subKey, subValue of value
                    domainRow.append "<td>#{subValue}</td>"

                element.append domainRow

        _createMatrixRow = (matrixRow, key, row, colDefs) ->
            matrixRow.append "<td class='domain'>#{key}</td>"
            for innerKey, value of row
                matrixRow.append "<td>#{value}</td>" if (colDefs and colDefs[innerKey]) or not colDefs

            element.append matrixRow

        loadData()
