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
	| functionCalled evaluatedArguments |
	functionCalled  := environment at: identifier.		
	evaluatedArguments := OrderedCollection new.
	
	arguments do: [ :each | evaluatedArguments add: (each evaluateIn: environment)].	
	
	^[functionCalled call: evaluatedArguments in: environment]
	on: ReturnStatementReached do: [  ]
	
	
	
	
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> executeIn: environment [
	| functionCalled evaluatedArguments |
	functionCalled  := environment at: identifier.	
	evaluatedArguments := OrderedCollection new.	
	
	arguments do: [ :each | (environment includesKey: each) ifTrue: [evaluatedArguments add: (environment at: each)] ifFalse: [evaluatedArguments add: each]].
	
	^[functionCalled call: evaluatedArguments in: environment]
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
