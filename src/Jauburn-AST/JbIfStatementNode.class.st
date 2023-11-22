Class {
	#name : #JbIfStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfStatementNode >> body [

	^ body
]

{ #category : #accessing }
JbIfStatementNode >> body: anObject [

	body := anObject
]

{ #category : #accessing }
JbIfStatementNode >> condition [

	^ condition
]

{ #category : #accessing }
JbIfStatementNode >> condition: anObject [

	condition := anObject
]

{ #category : #'as yet unclassified' }
JbIfStatementNode >> executeIn: anEnvironment [

	(condition evaluateIn: anEnvironment) ifTrue: [body do: [:each | each executeIn: anEnvironment]]
	
]
