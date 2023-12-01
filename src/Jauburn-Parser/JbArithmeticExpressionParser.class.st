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
JbArithmeticExpressionParser >> arithmeticDiv [
"
	^ arithmeticFactor , ($/ asParser trim , arithmeticFactor) star
	  ==> [ :arr | |current|
		current := arr first.
		arr second do: [ :pair |
		  current := JbDivisionNode new
			  lhs: current;
			  rhs: pair second
			  yourself].
		current ]"

"	^ arithmeticFactor , ($* asParser trim / $/ asParser trim / $% asParser trim), arithmeticTerm ==> [ :arr | 
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
		  yourself  ]]].] / arithmeticFactor"
	

]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticExpression [

^ ((arithmeticTerm separatedBy: '+' asParser trim/'-' asParser trim) foldLeft: [ :a :op :b | 
	op = '+' ifTrue:[
  JbAdditionNode  new
  lhs: a;
  rhs: b;
  yourself ]
	ifFalse: [JbSubtractionNode  new
  lhs: a;
  rhs: b;
  yourself] ]) / arithmeticTerm
"
	^ arithmeticTerm , ($+ asParser trim /$- asParser trim, arithmeticTerm) star
	  ==> [ :arr | 
		  | current |
		current := arr first.
		(arr second) size > 1 ifTrue: [ 
		  
		((arr second) first = $+) ifTrue:
			[arr second do: [ :pair |
			  current := JbAdditionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ]].
		(arr second includes: $-) ifTrue:
			[arr second do: [ :pair |
			  current := JbSubtractionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ]]].
			current] "
	
	
	"^ arithmeticTerm , (('+' asParser / '-' asParser) trim , arithmeticTerm) star
	  ==> [ :arr | 
		  | current |
		  current := arr first.
		  (arr second includes: $+) ifTrue: [arr second do: [ :pair | 
			  current := JbAdditionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ].
		  current ].
		  (arr second includes: $-) ifTrue: [arr second do: [ :pair | 
			  current := JbSubtractionNode  new
				             lhs: current;
				             rhs: pair second;
				             yourself ].
		  current ]]/arithmeticTerm"

			 
	
	"
	  ==> [ :arr | 
		(arr second) = '-' ifTrue: [ JbSubtractionNode  new
			  lhs: arr first;
				rhs: arr third;
			  yourself].
		(arr second) = '+' ifTrue: [ JbAdditionNode  new
		  lhs: arr first;
		  rhs: arr third;
		   yourself ]. ] / arithmeticTerm "    
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticFactor [

	^ '(' asParser trim , arithmeticExpression , ')' asParser trim
	  ==> [ :arr | arr second ] / numberExpression
	   / identifierExpression
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticSub [

	"^ arithmeticTerm , ('-' asParser trim , arithmeticTerm) star
	  ==> [ :arr | 
		  | current |
		  current := arr first.
		  arr second do: [ :pair | 
			  current := JbSubtractionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ].
		  current ]"

"	^ arithmeticFactor , ($* asParser trim / $/ asParser trim / $% asParser trim), arithmeticTerm ==> [ :arr | 
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
		  yourself  ]]].] / arithmeticFactor"
	

]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticTerm [
^ ((arithmeticFactor separatedBy: $* asParser trim / $/ asParser trim / $% asParser trim) foldLeft: [ :a :op :b | 
	op = $* ifTrue:[
  JbMultiplicationNode  new
  lhs: a;
  rhs: b;
  yourself ] ifFalse: [ 
	op = $/ ifTrue: [   JbDivisionNode  new
  lhs: a;
  rhs: b;
  yourself ] ifFalse: [ op = $% ifTrue: [   JbModulusNode  new
  lhs: a;
  rhs: b;
  yourself ]]] ]) / arithmeticFactor
	"^ arithmeticFactor , ($* asParser trim , arithmeticFactor) star
	  ==> [ :arr | 
		  | current |
		  current := arr first.
		(arr second size) > 1 ifTrue: [ 
		((arr second first) = '*') ifTrue:
		  [arr second do: [ :pair | 
			  current := JbMultiplicationNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ]].
		(arr second first = '/') ifTrue:
			[arr second do: [ :pair |
			  current := JbDivisionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ]].
		(arr second first = '/') ifTrue:
			[arr second do: [ :pair |
			  current := JbDivisionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ]]] current]"

"	^ arithmeticFactor , ($* asParser trim / $/ asParser trim / $% asParser trim), arithmeticTerm ==> [ :arr | 
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
		  yourself  ]]].] / arithmeticFactor"
	

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
