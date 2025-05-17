!classDefinition: #MarsRoverTests category: #'as yet unclassified'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 20:57:15'!
test01nullMovementDoesntAffectRover          
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'North'.
           self assert: (unRover itsPosition) equals: (0@0).
           self assert: (unRover itsFacing) equals: 'North'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:00:33'!
test02MoveUpFacingNorth         
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'North'.
           unRover forward.
           self assert: (unRover itsPosition) equals: (0@1).
           self assert: (unRover itsFacing) equals: 'North'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:12:52'!
test03MoveDownFacingNorth         
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'North'.
           unRover backward.
           self assert: (unRover itsPosition) equals: (0@-1).
           self assert: (unRover itsFacing) equals: 'North'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:36:10'!
test04MoveLeftFacingEast         
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'East'.
           unRover backward.
           self assert: (unRover itsPosition) equals: (-1@0).
           self assert: (unRover itsFacing) equals: 'East'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:32:55'!
test05MoveRightFacingEast         
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'East'.
           unRover forward.
           self assert: (unRover itsPosition) equals: (1@0).
           self assert: (unRover itsFacing) equals: 'East'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:24:37'!
test06MoveRightFacingNorthDoesntChangePosition         
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'North'.
           unRover right.
           self assert: (unRover itsPosition) equals: (0@0).
           self assert: (unRover itsFacing) equals: 'East'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:24:29'!
test07MoveLeftFacingNorthDoesntChangePosition         
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'North'.
           unRover left.
           self assert: (unRover itsPosition) equals: (0@0).
           self assert: (unRover itsFacing) equals: 'West'. ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'fs 5/16/2025 21:24:22'!
test08MovesDownFacingNorthThenTurningRight    
           |unRover|
           unRover := MarsRover withInitialCoordinates: (0@0) facing: 'North'.
           unRover backward.
           unRover left.
           self assert: (unRover itsPosition) equals: (0@-1).
           self assert: (unRover itsFacing) equals: 'West'. ! !


!classDefinition: #MarsRover category: #'as yet unclassified'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 21:35:40'!
backward
	(self itsFacing = 'North') ifTrue: [coordinate := coordinate + (0@-1).]. 
	(self itsFacing = 'East') ifTrue: [coordinate := coordinate + (-1@0).].
	(self itsFacing = 'West') ifTrue: [coordinate := coordinate + (1@0).].
	 (self itsFacing = 'South') ifTrue: [coordinate := coordinate + (0@1).].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 21:32:27'!
forward
	(self itsFacing = 'North') ifTrue: [coordinate := coordinate + (0@1).]. 
	(self itsFacing = 'East') ifTrue: [coordinate := coordinate + (1@0).].
	(self itsFacing = 'West') ifTrue: [coordinate := coordinate + (-1@0).].
	 (self itsFacing = 'South') ifTrue: [coordinate := coordinate + (0@-1).].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 20:51:34'!
initializeWithCoordinates: aCoordinate andFacing: aCardinal
                        coordinate:= aCoordinate.
                        direction:= aCardinal .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 20:54:01'!
itsFacing
                ^direction ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 20:41:19'!
itsPosition 
              ^coordinate! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 21:20:51'!
left
	direction := 'West'.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 21:07:11'!
right
		direction := 'East'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'as yet unclassified'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'fs 5/16/2025 20:50:48'!
withInitialCoordinates: aCoordinate facing: aCardinal
                           ^self new initializeWithCoordinates: aCoordinate andFacing: aCardinal.! !
