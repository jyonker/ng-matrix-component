describe 'ngMatrix', ->

    beforeEach module('ngMatrix')

    basicMatrixData =
        f1:
            wg1: 20
            wg2: 30
            wg3: 40
        f2:
            wg1: 10
            wg2: 0
            wg3: 22

    describe 'basic matrix data', ->
        beforeEach inject ($compile, $rootScope) ->
            $rootScope.matrixData = basicMatrixData
            @matrixElem = $compile('<matrix row-data="matrixData"></matrix>')($rootScope)

        it 'should create an Angular matrix component', ->
            expect(@matrixElem).to.be.ok
            expect(@matrixElem.is('table')).to.be.true
            expect(@matrixElem.hasClass('matrix')).to.be.true

        it 'should create a table with rows for each key in data', ->
            matrixRows = @matrixElem.find('tr')
            expect(matrixRows.length).to.equal(2)

        it 'should create cells in each row', ->
            matrixCells = @matrixElem.find('td')
            expect(matrixCells.length).to.equal(8)

        it 'should have row header cell in each row', ->
            rowHeaderCells = @matrixElem.find('td.domain')
            expect(rowHeaderCells.length).to.equal(2)

    describe 'column definition for matrix data', ->
        beforeEach inject ($compile, $rootScope) ->
            $rootScope.matrixData = basicMatrixData
            $rootScope.matrixCols =
                wg1:
                    title: 'Workgroup 1'
                wg3:
                    title: 'Workgroup 3'

            @matrixElem = $compile('<matrix row-data="matrixData" col-defs="matrixCols"></matrix>')($rootScope)

        it 'should create header cells for column definitions', ->
            matrixHeaders = @matrixElem.find('th')
            expect(matrixHeaders.length).to.equal(3)
            expect(matrixHeaders[0].innerHTML).to.equal('')
            expect(matrixHeaders[1].innerHTML).to.equal('Workgroup 1')
            expect(matrixHeaders[2].innerHTML).to.equal('Workgroup 3')

        it 'should only create cells for columns defined', ->
            matrixCells = @matrixElem.find('td')
            expect(matrixCells.length).to.equal(6)

    subDomainMatrixData =
        initiative1:
            feature11:
                wg1: 20
                wg2: 30
                wg3: 40
            feature12:
                wg1: 10
                wg2: 0
                wg3: 22
        initiative2:
            feature21:
                wg1: 17
                wg2: 12
                wg3: 0
            feature22:
                wg1: 1
                wg2: 27
                wg3: 33
            feature23:
                wg1: 11
                wg2: 2
                wg3: 3

    describe 'sub-domain matrix data', ->
        beforeEach inject ($compile, $rootScope) ->
            $rootScope.matrixData = subDomainMatrixData
            $rootScope.matrixCols =
                wg1:
                    title: 'Workgroup 1'
                wg2:
                    title: 'Workgroup 2'
                wg3:
                    title: 'Workgroup 3'

            @matrixElem = $compile('<matrix row-data="matrixData" col-defs="matrixCols"></matrix>')($rootScope)

        it 'should create matrix with sub-domain', ->
            expect(@matrixElem.find('td').length).to.equal(22)
            matrixDomainCells = @matrixElem.find('td.domain')
            expect(matrixDomainCells.length).to.equal(2)
            expect(matrixDomainCells[0].rowSpan).to.equal(3)
            expect(matrixDomainCells[1].rowSpan).to.equal(4)
            expect(@matrixElem.find('td.subdomain').length).to.equal(5)

    describe 'sub-range matrix data', ->
        beforeEach inject ($compile, $rootScope) ->
            $rootScope.matrixData = subDomainMatrixData
            $rootScope.matrixCols =
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

            @matrixElem = $compile('<matrix row-data="matrixData" col-defs="matrixCols"></matrix>')($rootScope)

        it 'should create matrix with sub-range', ->
            expect(@matrixElem.find('th.range').length).to.equal(2)
            expect(@matrixElem.find('th.subrange').length).to.equal(3)
            expect(@matrixElem.find('th').length).to.equal(9)
