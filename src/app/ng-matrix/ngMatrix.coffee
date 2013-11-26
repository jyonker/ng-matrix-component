ngMatrixModule = angular.module 'ngMatrix', []

ngMatrixModule.directive 'matrix', () ->
    restrict: 'E'
    replace: true
    template: '<table class="matrix"></table>'
    link: (scope, element, attrs) ->
        loadData = () ->
            colDefs = scope[attrs.colDefs]
            rowData = scope[attrs.rowData]

            for key, row of rowData
                matrixRow = angular.element "<tr></tr>"
                hasSubDomain = _hasSubData(row)
                if hasSubDomain
                    _createMatrixRowsWithSubDomain(matrixRow, key, row)
                else
                    _createMatrixRow(matrixRow, key, row, colDefs)

            if colDefs
                _createHeaderRow(colDefs, hasSubDomain)

        _createHeaderRow = (colDefs, hasSubDomain) ->
            headerRow = angular.element '<tr></tr>'
            headerRow.append "<th></th>"
            for col, rangeValue of colDefs
                hasSubRange = true if rangeValue.children
                if hasSubRange
                    rangeSize = _.size(angular.copy(rangeValue.children))
                    headerRow.append "<th class='range' colspan='#{rangeSize}'>#{rangeValue.title}</th>"
                else
                    headerRow.append "<th class='range'>#{rangeValue.title}</th>"

            headerRow.prepend "<th></th>" if hasSubDomain
            subHeaderRow = _createSubHeaderRow(colDefs)
            subHeaderRow.prepend "<th></th>" if hasSubDomain

            element.prepend subHeaderRow if hasSubRange
            element.prepend headerRow

        _createSubHeaderRow = (colDefs) ->
            subHeaderRow = angular.element '<tr></tr>'
            subHeaderRow.append "<th></th>"
            for col, rangeValue of colDefs
                for subCol, subRangeValue of rangeValue.children
                    subHeaderRow.append "<th class='subrange'>#{subRangeValue.title}</th>"

            return subHeaderRow

        _hasSubData = (data) ->
            return (_.size(angular.copy(data[_.keys(data)[0]])) > 0)

        _createMatrixRowsWithSubDomain = (matrixRow, key, row) ->
            domainSize = _.size(angular.copy(row))
            matrixRow.append "<td class='domain' rowspan='#{domainSize + 1}'>#{key}</td>"
            element.append matrixRow

            for innerKey, value of row
                domainRow = angular.element "<tr></tr>"
                domainRow.append "<td class='subdomain'>#{innerKey}</td>"

                for subKey, subValue of value
                    domainRow.append "<td class='cellvalue'>#{subValue}</td>"

                element.append domainRow

        _createMatrixRow = (matrixRow, key, row, colDefs) ->
            matrixRow.append "<td class='domain'>#{key}</td>"
            for innerKey, value of row
                matrixRow.append "<td class='cellvalue'>#{value}</td>" if (colDefs and colDefs[innerKey]) or not colDefs

            element.append matrixRow

        loadData()

