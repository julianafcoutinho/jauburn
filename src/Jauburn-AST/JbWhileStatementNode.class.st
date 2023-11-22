Class {
	#name : #JbWhileStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileStatementNode >> body [

	^ body
]

{ #category : #accessing }
JbWhileStatementNode >> body: anObject [

	body := anObject
]

{ #category : #accessing }
JbWhileStatementNode >> condition [

	^ condition
]

{ #category : #accessing }
JbWhileStatementNode >> condition: anObject [

	condition := anObject
]

{ #category : #'as yet unclassified' }
JbWhileStatementNode >> executeIn: anEnvironment [

	(condition evaluateIn: anEnvironment) ifTrue: [body do: [:each | each executeIn: anEnvironment]]
]
