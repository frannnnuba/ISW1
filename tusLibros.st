!classDefinition: #CartTests category: #tusLibros!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!CartTests methodsFor: 'tests' stamp: 'fs 6/12/2025 12:36:47'!
test01CreateNewShoppingCartIsEmpty
         |cart|
          cart := Cart newCartWithCatalogue: OrderedCollection new.
          self assert: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'fs 6/12/2025 13:58:52'!
test02BookAddedToCartSuccessfully
         |cart|
          cart := Cart newCartWithCatalogue: (OrderedCollection with: 'book1').
          cart addToCart: 'book1'.
          self assert: (cart booksToBePurchased includesKey: 'book1').
          self assert: (cart booksToBePurchased at: 'book1') equals: 1.! !

!CartTests methodsFor: 'tests' stamp: 'fs 6/12/2025 14:00:28'!
test03BooksAddedToCartSuccessfully
         |cart|
          cart := Cart newCartWithCatalogue: (OrderedCollection with: 'book1' with: 'book2').
          cart addToCart: 'book1'.
          cart addToCart: 'book1'.
          cart addToCart: 'book2'.
          self assert: (cart booksToBePurchased includesKey: 'book1').
          self assert: (cart booksToBePurchased includesKey: 'book2').
          self assert: (cart booksToBePurchased at: 'book1') equals: 2.! !

!CartTests methodsFor: 'tests' stamp: 'fs 6/12/2025 13:37:53'!
test04AddingABookNotInTheCatalogueLaunchesException
         |cart|
         cart := Cart newCartWithCatalogue: (OrderedCollection with: 'book1' with: 'book2').
         self should: [cart addToCart: 'book3'] raise: Error  withMessageText: ['The book does not belong to the catalogue'].
         ! !


!classDefinition: #Cart category: #tusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalogue booksToBePurchased'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!Cart methodsFor: 'initalize' stamp: 'fs 6/12/2025 13:41:56'!
initializeNewCartWithCatalogue: aCatalogue 
	catalogue := aCatalogue.
	booksToBePurchased := Dictionary new.! !


!Cart methodsFor: 'error handling' stamp: 'fs 6/12/2025 13:36:32'!
bookNotInCatalogue
          ^self error: 'The book does not belong to the catalogue'.! !


!Cart methodsFor: 'assertions' stamp: 'fs 6/12/2025 13:42:56'!
isEmpty
	^booksToBePurchased isEmpty! !


!Cart methodsFor: 'cart actions' stamp: 'fs 6/12/2025 14:13:58'!
addToCart: aBook
      |previousValue| 
      (catalogue includes: aBook) ifFalse: [^self bookNotInCatalogue].
	booksToBePurchased at: aBook ifAbsentPut: [0 "booksToBePurchased add: aBook ->0"].
	previousValue:= booksToBePurchased at: aBook.
	booksToBePurchased at: aBook put: previousValue+1.! !

!Cart methodsFor: 'cart actions' stamp: 'fs 6/12/2025 12:57:39'!
booksToBePurchased
	^booksToBePurchased! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #tusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'fs 6/12/2025 12:37:49'!
newCartWithCatalogue: aCatalogue
	^self new initializeNewCartWithCatalogue: aCatalogue ! !
