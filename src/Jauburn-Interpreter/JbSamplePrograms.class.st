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

	"Run with JbSamplePrograms computeSqrt."
	^ JbInterpreter newWithStandardLibrary  run: 'var a = gcd(', (UIManager default request: 'Enter the first number' initialAnswer: '0' title: 'Greatest Common Divisor' ), ',', (UIManager default request: 'Enter another number.'), '); print a;'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> computeSqrt [

	"self run: self assignAndPrint"
	|aValue| 
	aValue := UIManager default request: 'Enter a number.'.
	^ JbInterpreter newWithStandardLibrary  run: 'var a = sqrt(', aValue, '); print a;'

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
