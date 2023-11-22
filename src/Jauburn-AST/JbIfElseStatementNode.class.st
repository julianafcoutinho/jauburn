Class {
	#name : #JbIfElseStatementNode,
	#superclass : #JbIfStatementNode,
	#instVars : [
		'else'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfElseStatementNode >> else [

	^ else
]

{ #category : #accessing }
JbIfElseStatementNode >> else: anObject [

	else := anObject
]

{ #category : #'as yet unclassified' }
JbIfElseStatementNode >> executeIn: anEnvironment [

	(condition evaluateIn: anEnvironment) ifTrue: [body do: [:each | each executeIn: anEnvironment]] ifFalse: [else do: [:each | each executeIn: anEnvironment]] 
	
]
