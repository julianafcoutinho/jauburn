Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> assignAndPrint [

	"self run: self assignAndPrint"

	^ '
var x = 19;
var y = 32 * ( x + 5 ) * x;
print x;
print y;
print 5*y;'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> computeGCD [

	"Run with JbSamplePrograms computeGCD."
	|firstNum secondNum options|
	options := (OrderedCollection new addAll: #('This is the way.' 'Worst. Divisor. Ever' 'Yabba-Dabba Do!' 'Frankly, my dear, I don`t give a divisor' 'May the Divisor be with you' 'You can`t handle the divisor!' 'I see dead divisors.' 'It`s the Great Divisor, Charlie Brown!' 'Cant find a better divisor' 'Eternal Sunshine of the Spotless Divisor' 'No Dark Divisor in the Classroom' 'We`ve been dancing with Mr Divisor' 'It`s-a me, Divisor!'); yourself) asArray.
	
	firstNum := (UIManager default request: 'Enter the first number' initialAnswer: '0' title: 'Greatest Common Divisor' ).
	secondNum := (UIManager default request: 'Enter another number.').
	
	^ UIManager default confirm: ((JbInterpreter newWithStandardLibrary  run: 'var a = gcd(', firstNum, ',', secondNum, '); print a;') environment at: 'a') asStringWithCommas label: ('The GCD for ', firstNum, ' and ', secondNum, ' is:') trueChoice: options atRandom falseChoice: nil cancelChoice: nil default: nil 
]

{ #category : #'sample programs' }
JbSamplePrograms class >> computeSqrt [

	"self run: self assignAndPrint"

	^ UIManager default confirm: (((JbInterpreter newWithStandardLibrary  run: 'var a = sqrt(', (UIManager default request: 'Enter a number.'), '); print a;') environment at: 'a') printShowingDecimalPlaces: 2) label: ('The square root is:') trueChoice: 'I guess you`re right.' falseChoice: nil cancelChoice: nil default: nil 

]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [

	"self run: self noFunctions"

	^ 'var x = 4;
var y = 10 * x + 2;
print y;
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: aString [

	"Look at sample programs for examples of using this method."

	^ JbInterpreter newWithStandardLibrary  run: aString
]
