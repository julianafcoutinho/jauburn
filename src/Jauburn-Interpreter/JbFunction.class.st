Class {
	#name : #JbFunction,
	#superclass : #Object,
	#instVars : [
		'body',
		'parameters',
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbFunction >> body [
	^ body
]

{ #category : #accessing }
JbFunction >> body: anObject [
	body := anObject
]

{ #category : #api }
JbFunction >> call: arguments in: callEnvironment [
	
	| localEnvironment |
	localEnvironment := JbEnvironment new outerEnvironment: callEnvironment.
	arguments with: parameters do: [:arg :par | localEnvironment at: par identifier put: arg value].
	^[[body do: [:each | each executeIn: localEnvironment].]
	on: ReturnStatementReached do: [ :ex | ^ ex returnValue  ]]
	ensure:
	[localEnvironment variableNames do: [:local | (callEnvironment includesKey: local) 	ifTrue: 	[callEnvironment at: local put: (localEnvironment at: local)]]]
	
	
	
]

{ #category : #accessing }
JbFunction >> environment [
	^ environment
]

{ #category : #accessing }
JbFunction >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
JbFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunction >> parameters: anObject [
	parameters := anObject
]
