Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'uiManager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new
]

{ #category : #api }
JbInterpreter >> interpret: programString [

	| ast |
	ast := self parse: programString.
	self interpretAst: ast
]

{ #category : #api }
JbInterpreter >> interpretAst: ast [

	^ ast executeIn: environment
]

{ #category : #api }
JbInterpreter >> parse: programString [

	| parser |
	parser := JbParser new.
	^(parser parse: programString)
]

{ #category : #api }
JbInterpreter >> run: programString [

	"Just an alias for #interpret:"

	self interpret: programString
]

{ #category : #accessing }
JbInterpreter >> uiManager [ 

	^ uiManager


]

{ #category : #accessing }
JbInterpreter >> uiManager: aValue [
	environment fakeManager: aValue.
	"aValue ifNil: [ uiManager := (UIManager default request: 'Enter a number') ] ifNotNil: [ uiManager := aValue ]"
]
