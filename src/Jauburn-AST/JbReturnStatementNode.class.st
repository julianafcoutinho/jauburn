Class {
	#name : #JbReturnStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbReturnStatementNode >> executeIn: anEnvironment [
	|newException|
	
	newException := ReturnStatementReached new returnValue: (expression evaluateIn: anEnvironment) .
	newException signal

]

{ #category : #accessing }
JbReturnStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbReturnStatementNode >> expression: anObject [
	expression := anObject
]
