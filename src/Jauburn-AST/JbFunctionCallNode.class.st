Class {
	#name : #JbFunctionCallNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'identifier',
		'arguments'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionCallNode >> arguments [
	^ arguments
]

{ #category : #accessing }
JbFunctionCallNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> evaluateIn: environment [
	| functionCalled |
	functionCalled  := environment at: identifier.		
	
	^[functionCalled call: arguments in: environment]
	on: ReturnStatementReached do: [  ]
	
	
	
	
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> executeIn: environment [
	| functionCalled |
	functionCalled  := environment at: identifier.		
	
	^[functionCalled call: arguments in: environment]
	on: ReturnStatementReached do: [ :ex | ^ ex returnValue ]
	
	
	
]

{ #category : #accessing }
JbFunctionCallNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbFunctionCallNode >> identifier: anObject [
	identifier := anObject
]
