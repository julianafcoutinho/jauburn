Class {
	#name : #JbArithmeticParserTest,
	#superclass : #JbAbstractParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbArithmeticParserTest >> parserClass [

	^JbArithmeticExpressionParser 
]

{ #category : #tests }
JbArithmeticParserTest >> testArithmeticExpression [

	| expression |
	expression := self parse: '32' rule: #arithmeticExpression.
	self assertNode: expression value isConstant: 32.
	expression := self parse: '3+4' rule: #arithmeticExpression.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isConstant: 4.
	self assertNode: expression isOperator: $+.
		expression := self parse: '3*4' rule: #arithmeticExpression.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isConstant: 4.
	self assertNode: expression isOperator: $*.
	expression := self parse: 'monkey*13' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'monkey'.
	self assertNode: expression rhs isConstant: 13.
	self assertNode: expression isOperator: $*.
	expression := self parse: 'falafel' rule: #arithmeticExpression.
	self assertNode: expression isIdentifier: 'falafel'.
	expression := self parse: 'a * b * c' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'a'.
	self assertNode: expression isOperator: $*.

]

{ #category : #tests }
JbArithmeticParserTest >> testArithmeticExpressionAssociativity [

	| expression |
	expression := self parse: '3+2+8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $+.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8
]

{ #category : #tests }
JbArithmeticParserTest >> testArithmeticExpressionPrecedence [

	| expression |
	expression := self parse: '3+2*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $*.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $*.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3+2/8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $/.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)/8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $/.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3+2%8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $%.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)%8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $%.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3/2*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $/.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $*.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $*.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
		
]

{ #category : #tests }
JbArithmeticParserTest >> testArithmeticExpressionSubDivMod [

	| expression |
	expression := self parse: '3-4' rule: #arithmeticExpression.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isConstant: 4.
	self assertNode: expression isOperator: $-.
	expression := self parse: '3*4' rule: #arithmeticExpression.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isConstant: 4.
	self assertNode: expression isOperator: $*.
	expression := self parse: '3/4' rule: #arithmeticExpression.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isConstant: 4.
	self assertNode: expression isOperator: $/.
	expression := self parse: 'monkey/13' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'monkey'.
	self assertNode: expression rhs isConstant: 13.
	self assertNode: expression isOperator: $/.
	expression := self parse: 'falafel' rule: #arithmeticExpression.
	self assertNode: expression isIdentifier: 'falafel'.
	expression := self parse: 'a % b / c' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'a'.
	self assertNode: expression isOperator: $%.

]

{ #category : #tests }
JbArithmeticParserTest >> testArithmeticExpressionWithThreeEqualPrecedenceOperations [

	| expression |
	expression := self parse: '3+2-5+1' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression rhs isConstant: 1.
	self assertNode: expression lhs isOperator: $-.
	self assertNode: expression rhs rhs isConstant: 2.
	self assertNode: expression rhs lhs isOperator: $+.
	self assertNode: expression rhs lhs lhs isConstant: 5.
	self assertNode: expression rhs lhs rhs isConstant: 1.
	
	expression := self parse: '(3+2)*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $*.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3+2/8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $/.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)/8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $/.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3+2%8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $%.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)%8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $%.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3/2*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $/.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $*.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $*.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
		
]

{ #category : #tests }
JbArithmeticParserTest >> testCHANGEArithmeticExpressionPrecedence [

	| expression |
	expression := self parse: '3+2*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression rhs isConstant: 3.
	self assertNode: expression lhs isOperator: $*.
	self assertNode: expression lhs lhs isConstant: 2.
	self assertNode: expression lhs rhs isConstant: 8.
	expression := self parse: '(3+2)*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $*.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 2.
	self assertNode: expression lhs rhs isConstant: 3.
	expression := self parse: '3+2/8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression rhs isConstant: 3.
	self assertNode: expression lhs isOperator: $/.
	self assertNode: expression lhs lhs isConstant: 2.
	self assertNode: expression lhs rhs isConstant: 8.
	expression := self parse: '(3+2)/8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $/.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 2.
	self assertNode: expression lhs rhs isConstant: 3.
	expression := self parse: '3+2%8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $+.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $%.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)%8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $%.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
	expression := self parse: '3/2*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $/.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isOperator: $*.
	self assertNode: expression rhs lhs isConstant: 2.
	self assertNode: expression rhs rhs isConstant: 8.
	expression := self parse: '(3+2)*8' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $*.
	self assertNode: expression lhs isOperator: $+.
	self assertNode: expression rhs isConstant: 8.
	self assertNode: expression lhs lhs isConstant: 3.
	self assertNode: expression lhs rhs isConstant: 2.
		
]

{ #category : #tests }
JbArithmeticParserTest >> testNumberExpression [

	"Numbers are tested in JbNumberParserTest.  Here we just make sure that the full parser can parse a number."

	self
		assertNode: (self parse: '15' rule: #numberExpression) 
		isConstant: 15.
	self fail: 'abc' rule: #numberExpression
]
