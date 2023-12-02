Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'uiManager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #'as yet unclassified' }
JbInterpreter class >> newWithStandardLibrary [
	|interpreter|
	interpreter := self new.
	^interpreter interpret: self standardLibrary .

]

{ #category : #'as yet unclassified' }
JbInterpreter class >> standardLibrary [
	"I was not sure how to address negative roots, so I'm returning 0"
	
	^ '
	var not = 
		function(b) {
			if(b) {return false;} 
			else {return true;}
		};

	var and = 
		function(a, b) {
			if(b) { if (a) {return true;} }
			else {return false;} 
		};

	var or = 
		function(a, b) {
			if(b) 	{return true;}
			else { 
				if(a) {return true;} 
				else { return false; }
			}
		};

	var abs = 
		function(f) { 
			if(f<0) { return -1*f;} 
			else {return f;}
		};

	var sqrt = 
		function(x) { 
			if (x > 0) { 
				var n = x; 
				var root = 0;
				var diff = 1;
	 				while(diff > 0.00001){
	 					root = 0.5 * (n + x/n); 
						diff = abs(root-n);
						n = root;
					}
				return root;}
			else {
				return x;}
		};

	var gcd = 
		function(a, b) { 
			if (a == 0) { return abs(b); }
	 		if (b == 0) { return abs(a); }
		return gcd(b%a, a);
		};'
]

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
