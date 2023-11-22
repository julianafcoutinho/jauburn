Class {
	#name : #JbArithmeticExpressionParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'arithmeticExpression',
		'numberExpression',
		'identifierExpression',
		'identifier',
		'arithmeticTerm',
		'arithmeticFactor'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #accessing }
JbArithmeticExpressionParser class >> dependencies [

	^ { JbNumberParser }
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticExpression [

	^ arithmeticTerm , ($+ asParser trim /$- asParser trim), arithmeticExpression
	  ==> [ :arr | 
		(arr second = $+) ifTrue: [ JbAdditionNode   new
			  lhs: arr first;
				rhs: arr third;
			  yourself]
		ifFalse: [(arr second = $-) ifTrue: [ JbSubtractionNode new
		  lhs: arr third;
		  rhs: arr first;
		   yourself ]]] / arithmeticTerm 
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticFactor [

	^ '(' asParser trim , arithmeticExpression , ')' asParser trim
	  ==> [ :arr | arr second ] / numberExpression
	   / identifierExpression
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticTerm [

	^ arithmeticFactor , ($* asParser trim / $/ asParser trim / $% asParser trim), arithmeticTerm ==> [ :arr | 
		(arr second = $*)  ifTrue: [ JbMultiplicationNode new
		  lhs: arr first;
		  rhs: arr third;
		  yourself  ] ifFalse: [ 
	(arr second = $/) ifTrue: [ JbDivisionNode new
		  lhs: arr first;
		  rhs: arr third;
		  yourself  ] ifFalse: [ 
	(arr second = $%) ifTrue: [ JbModulusNode  new
		  lhs: arr first;
		  rhs: arr third;
		  yourself  ]]].] / arithmeticFactor
	

]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> identifier [

	^ (#letter asParser
	   , (#letter asParser / #digit asParser / $_ asParser) star) flatten
		  trim
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> identifierExpression [

	^ identifier ==> [ :arr | 
	  JbIdentifierExpressionNode new
		  identifier: arr;
		  yourself ]
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> numberExpression [

	^ (self dependencyAt: JbNumberParser) integer ==> [ :n | 
	  JbConstantExpressionNode new
		  value: n;
		  yourself ]
]

{ #category : #accessing }
JbArithmeticExpressionParser >> start [ 

	^arithmeticExpression 
]
