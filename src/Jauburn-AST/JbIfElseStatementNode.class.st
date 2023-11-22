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
