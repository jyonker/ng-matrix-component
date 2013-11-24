describe 'ngMatrix', ->

    beforeEach module('ngMatrix')

    matrixData =
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
            $rootScope.matrixData = matrixData
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
            $rootScope.matrixData = matrixData
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
