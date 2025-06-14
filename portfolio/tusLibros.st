!classDefinition: #CartTests category: #tusLibros!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!CartTests methodsFor: 'tests' stamp: 'fs 6/13/2025 20:28:25'!
test01CreateNewShoppingCartIsEmpty
         |cart|
          cart := Cart newCartWithCatalogue: Dictionary new.
          self assert: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'fs 6/13/2025 20:29:47'!
test02BookAddedToCartSuccessfully
         |cart|
          cart := Cart newCartWithCatalogue: (Dictionary new add: 'book1' -> 20).
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


!classDefinition: #CashierTests category: #tusLibros!
TestCase subclass: #CashierTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/13/2025 20:08:50'!
test01CheckingOutAnEmptyCartFails
                  |aCart aCreditCard expDate| 
                  aCart:= Cart newCartWithCatalogue: {'book1'}. 
                  expDate := Month month: 05 year: 2026.
                  aCreditCard:= Card newCardWithNumber:0000000000000001 withExpirationDate: expDate.  
                  self should:[Cashier checkout: aCart andCharge: aCreditCard] raise: Error withMessageText: ['Please select a book before checking out'].
                  ! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/13/2025 20:52:01'!
test02CheckingOutACartWithABook
                  |aCart aCreditCard expDate a|
                   a:= Dictionary new . 
                   a add: 'book1' -> 20.
                  aCart:= Cart newCartWithCatalogue: a. 
                  aCart addToCart: 'book1'.
                  expDate := Month month: 05 year: 2026.
                  aCreditCard:= Card newCardWithNumber:0000000000000001 withExpirationDate: expDate.  
                  self assert: (aCart unitaryPriceOf:'book1' ) equals: (Cashier checkout: aCart andCharge: aCreditCard) totalToPay! !


!classDefinition: #Card category: #tusLibros!
Object subclass: #Card
	instanceVariableNames: 'cardNumber expDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!Card methodsFor: 'initialization' stamp: 'fs 6/13/2025 20:02:56'!
initializeNewCardWithNumber: aCardNumber withExpirationDate: anExpDate 
	cardNumber := aCardNumber.
	expDate := anExpDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #tusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'fs 6/13/2025 19:59:36'!
newCardWithNumber: aCardNumber withExpirationDate: expDate 
	^self new initializeNewCardWithNumber: aCardNumber withExpirationDate: expDate ! !


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


!Cart methodsFor: 'cart actions' stamp: 'fs 6/13/2025 20:42:07'!
addToCart: aBook
      |previousValue| 
      (catalogue keys includes: aBook) ifFalse: [^self bookNotInCatalogue].
	booksToBePurchased at: aBook ifAbsentPut: [0 "booksToBePurchased add: aBook ->0"].
	previousValue:= booksToBePurchased at: aBook.
	booksToBePurchased at: aBook put: previousValue+1.! !

!Cart methodsFor: 'cart actions' stamp: 'fs 6/12/2025 12:57:39'!
booksToBePurchased
	^booksToBePurchased! !

!Cart methodsFor: 'cart actions' stamp: 'fs 6/13/2025 20:37:56'!
unitaryPriceOf: aBook
	^catalogue at: aBook .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #tusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'fs 6/12/2025 12:37:49'!
newCartWithCatalogue: aCatalogue
	^self new initializeNewCartWithCatalogue: aCatalogue ! !


!classDefinition: #Cashier category: #tusLibros!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'fs 6/13/2025 20:15:01'!
initializeACheckoutFor: aCart andCharge: aCreditCard 
               (aCart isEmpty) ifTrue: [^self error: self class invalidCart]. ! !


!Cashier methodsFor: 'actions' stamp: 'fs 6/13/2025 20:55:12'!
totalToPay
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #tusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'fs 6/13/2025 20:11:45'!
checkout: aCart andCharge: aCreditCard
                 ^self new initializeACheckoutFor: aCart andCharge: aCreditCard ! !


!Cashier class methodsFor: 'error messages' stamp: 'fs 6/13/2025 20:15:39'!
invalidCart
       ^'Please select a book before checking out'! !
