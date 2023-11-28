Class {
	#name : #ReturnStatementReached,
	#superclass : #Exception,
	#instVars : [
		'returnValue'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #initialization }
ReturnStatementReached >> initialize [ 

	super initialize.
]

{ #category : #accessing }
ReturnStatementReached >> returnValue [

	^ returnValue
]

{ #category : #accessing }
ReturnStatementReached >> returnValue: anObject [

	returnValue := anObject
]
