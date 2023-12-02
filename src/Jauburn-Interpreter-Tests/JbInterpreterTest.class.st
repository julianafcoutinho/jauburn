Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	^ interpreter interpret: aString
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter newWithStandardLibrary 
]

{ #category : #running }
JbInterpreterTest >> testAssignmentChangesVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8; x = 99;'.
	self assert: (interpreter environment at: 'x') equals: 99.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.

	self interpret: 'var x = 3 + 2 + 5 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 11.
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testFunctionCallStatementExecutesCorrectly [ 

	self interpret: 'var x = 1; var fun = function(a, b, monkey){x = b+monkey;}; fun(1, 2, 3);'.
	self assert: (interpreter environment at: 'x') equals: 5.
	
	self interpret: 'var y = 1; var fun = function(a, b, monkey) {y = 2; var z = 1; return a+b;}; var x = fun(1, 2, 3);'.
	self assert: (interpreter environment at: 'y') equals: 2.
	
	self interpret: 'var y = 1; var fun = function(a, b, monkey) {y = 2; var z = 1; return a+b; y=3;}; var x = fun(1, 2, 3);'.
	self assert: (interpreter environment at: 'y') equals: 2.
	
	self interpret: 'var y = 1; var fun = function(a, b, monkey) {y = 2; var z = 1; return a+b; y=3;}; var x = fun(-99, -99, 3);'.
	self assert: (interpreter environment at: 'x') equals: -198.
	
	self interpret: 'var y = 1; var fun = function(a, b, monkey) {return a>b; y=3;}; var x = fun(1, 2, 3);'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testIfElseStatementExecutesCorrectly [ 

	self interpret: 'var x = 0;if(1>0){var x=1;}else{var x = 2;};'.
	self assert: (interpreter environment at: 'x') equals: 1.

	self interpret: 'var x = 0;if(1>2){var x=1;}else{var x = 2;};'.
	self assert: (interpreter environment at: 'x') equals: 2.
		
	self interpret: 'var x = 0;if(1>0){}else{};'.
	self assert: (interpreter environment at: 'x') equals: 0.

	self interpret: 'var x = 3 + 2 + 5 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 11.
	
]

{ #category : #running }
JbInterpreterTest >> testIfStatementExecutesCorrectly [ 

	self interpret: 'var x = 0;if(1>0){var x=1;};'.
	self assert: (interpreter environment at: 'x') equals: 1.

	self interpret: 'var x = 0;if(1>2){var x=1;};'.
	self assert: (interpreter environment at: 'x') equals: 0.
		
	self interpret: 'var x = 0;if(1>0){x = x + 2; x = x * 2;};'.
	self assert: (interpreter environment at: 'x') equals: 4.

	self interpret: 'var x = 3 + 2 + 5 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 11.
	
]

{ #category : #running }
JbInterpreterTest >> testInputStatementExecutesCorrectlyWithInputs1and10 [
	interpreter uiManager: 2.
	self interpret: 'inputnum a;'.
	self assert: (interpreter environment at: 'a') equals: 2.
	
	interpreter uiManager: 1.23.
	self interpret: 'inputnum pearl;'.
	self assert: (interpreter environment at: 'pearl') equals: 1.23.
	
	interpreter uiManager: 45.
	self interpret: 'inputnum pearl;'.
	self assert: (interpreter environment at: 'pearl') equals: 45.
]

{ #category : #running }
JbInterpreterTest >> testOperatioOrderWorks [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2+ 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 14.

	self interpret: 'var x = 3 + 2 + 5 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 11.
	
	self interpret: 'var x = 3 + 2 - 5 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 3 - 5 +2 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 3 - 5 * 2 + 1;'.
	self assert: (interpreter environment at: 'x') equals: -6.
	
	self interpret: 'var x = 3 - 5 + 2 * 1;'.
	self assert: (interpreter environment at: 'x') equals: 0.
]

{ #category : #running }
JbInterpreterTest >> testStandardLibrary [
	
	self interpret: 'var y = sqrt(4);'.
	self assert: (interpreter environment at: 'y') closeTo: 2.
	
	self interpret: 'var x = true; var y = not(x);'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var x = true; var z = false; var y = or(x, z);'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = false; var z = false; var y = or(x, z);'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var x = true; var z = not(x); var y = not(z);'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = true; var z = false; var y = and(x, z);'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var x = abs(-2);'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = abs(2.2);'.
	self assert: (interpreter environment at: 'x') equals: 2.2.
	"if sqrt is passed a negative value x, it returns x"
	self interpret: 'var x = sqrt(-2);'.
	self assert: (interpreter environment at: 'x') equals: -2.
	
	self interpret: 'var x = sqrt(1);'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = gcd(125,-275);'.
	self assert: (interpreter environment at: 'x') equals: 25.
	
	self interpret: 'var x = gcd(0,-275);'.
	self assert: (interpreter environment at: 'x') equals: 275.
]

{ #category : #running }
JbInterpreterTest >> testWhileStatementExecutesCorrectly [ 

	self interpret: 'var x = 0;while(x>0){var x=1;x=x+1;};'.
	self assert: (interpreter environment at: 'x') equals: 0.

	self interpret: 'var x = 0;while(x<5){x=x+1;};'.
	self assert: (interpreter environment at: 'x') equals: 5.
		
	self interpret: 'var x = 0;while(x>5){};'.
	self assert: (interpreter environment at: 'x') equals: 0.

	self interpret: 'var x = 3 + 2 + 5 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 11.
	
]
