Extension { #name : #JbFunctionDefinitionNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionDefinitionNode >> evaluateIn: environment [

	^JbFunction new 
	body: body;
	parameters: parameters.

]
