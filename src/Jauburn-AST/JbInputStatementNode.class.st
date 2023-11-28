Class {
	#name : #JbInputStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'identifier'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbInputStatementNode >> executeIn: anEnvironment [ 
	anEnvironment at: self identifier put: ( anEnvironment fakeManager ifNil: [ (UIManager default request: 'Enter a number') ] ifNotNil: [ anEnvironment fakeManager ]) asNumber.
	"((anEnvironment uiManager) request: 'Enter a number' initialAnswer: '0') asNumber ."
	"((UIManager default request: 'Enter a number' initialAnswer: '0') asNumber)"
	

		

]

{ #category : #'as yet unclassified' }
JbInputStatementNode >> executeIn: anEnvironment interpreter: anInterpreter [
   anInterpreter uiManager ifNil: [ ((UIManager default request: 'Enter a number' initialAnswer: '0') asNumber) ] ifNotNil: 0.
	
	anEnvironment at: self identifier put: (anInterpreter uiManager) asNumber.
	"((anEnvironment uiManager) request: 'Enter a number' initialAnswer: '0') asNumber ."
	"((UIManager default request: 'Enter a number' initialAnswer: '0') asNumber)"
	

		

]

{ #category : #accessing }
JbInputStatementNode >> identifier [

	^ identifier
]

{ #category : #accessing }
JbInputStatementNode >> identifier: anObject [

	identifier := anObject
]
