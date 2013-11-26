describe 'ngMatrix', ->

    beforeEach module('ngMatrix')

    basicMatrixData =
        a1:
            z1: 20
            z2: 30
            z3: 40
        a2:
            z1: 10
            z2: 0
            z3: 22

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
                z1:
                    title: 'Workgroup 1'
                z3:
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
        a1:
            b11:
                z1: 20
                z2: 30
                z3: 40
            b12:
                z1: 10
                z2: 0
                z3: 22
        a2:
            b21:
                z1: 17
                z2: 12
                z3: 0
            b22:
                z1: 1
                z2: 27
                z3: 33
            b23:
                z1: 11
                z2: 2
                z3: 3

    describe 'sub-domain matrix data', ->
        beforeEach inject ($compile, $rootScope) ->
            $rootScope.matrixData = subDomainMatrixData
            $rootScope.matrixCols =
                z1:
                    title: 'Zebra 1'
                z2:
                    title: 'Zebra 2'
                z3:
                    title: 'Zebra 3'

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
                g1:
                    title: 'Group 1'
                    children:
                        z1:
                            title: 'Z1'
                        z2:
                            title: 'Z2'
                g2:
                    title: 'Group 2'
                    children:
                        z3:
                            title: 'Z3'

            @matrixElem = $compile('<matrix row-data="matrixData" col-defs="matrixCols"></matrix>')($rootScope)

        it 'should create matrix with sub-range', ->
            expect(@matrixElem.find('th.range').length).to.equal(2)
            expect(@matrixElem.find('th.subrange').length).to.equal(3)
            expect(@matrixElem.find('th').length).to.equal(9)
