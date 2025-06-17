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

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:57:24'!
test01CheckingOutAnEmptyCartFails
                  |aCart  salesBook|
                   salesBook := OrderedCollection new. 
                  aCart:= Cart newCartWithCatalogue: {'book1'}.            
                  self should:[Cashier checkout: aCart andCharge: TestObjectsFactory validCreditCard todaysDateIs: Date today monthAndYear registerSaleIn: salesBook ] 
                 raise: Error- MessageNotUnderstood 
                 withExceptionDo: [:anError| 
	               self assert: anError messageText = Cashier invalidCart .
	               self assert:  salesBook isEmpty.
	          ].
                  ! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:56:29'!
test02CheckingOutACartWithABook
                  |salesBook aSale|            
                   salesBook := OrderedCollection new.                    
                   aSale := Cashier checkout: TestObjectsFactory newCart andCharge: TestObjectsFactory validCreditCard todaysDateIs: Date today monthAndYear registerSaleIn: salesBook. 
                  self assert: (20) equals: aSale totalToPay.
                   self assert:( OrderedCollection with: aSale) equals: aSale salesBook. ! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:56:53'!
test03CheckingOutACartWithManyBooks
                  |salesBook aSale|            
                   salesBook := OrderedCollection new.    
                   aSale := Cashier checkout: TestObjectsFactory newCartWithManyBooks andCharge: TestObjectsFactory validCreditCard todaysDateIs: Date today monthAndYear registerSaleIn: salesBook. 
                  self assert: (50) equals: aSale totalToPay.
                  self assert:( OrderedCollection with: aSale) equals: aSale salesBook. ! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:58:19'!
test04CheckingOutACartWithExpiredCardFails
                  | salesBook |            
                   salesBook := OrderedCollection new.    
                  self should: [Cashier checkout: TestObjectsFactory newCartWithManyBooks andCharge: TestObjectsFactory invalidCreditCard todaysDateIs: Date today monthAndYear registerSaleIn: salesBook.]
                  raise: Error-MessageNotUnderstood
                  withExceptionDo: [:anError| 
	           self assert: anError messageText = Cashier expiredCard .
	            self assert: salesBook isEmpty.
	].
                ! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/15/2025 22:34:27'!
test05CheckingOutCartAndRecievingConfirmationByInterface
                   |salesBook aSale anInterface|            
                   salesBook := OrderedCollection new.    
                   aSale := Cashier checkout: TestObjectsFactory newCartWithManyBooks andCharge: TestObjectsFactory validCreditCard todaysDateIs: Date today monthAndYear registerSaleIn: salesBook. 
                 anInterface := InterfaceBetweenMPAndCashier newInterfaceAskedBy: aSale chargeACard: TestObjectsFactory belonginTo: 'NN' .
                 self assert: '0|Successful purchase' equals:anInterface receiveACorrectTransaction.
                 self assert: (OrderedCollection with: 'sales_id_01') equals: aSale salesBook.! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/15/2025 22:42:02'!
test06CheckingOutCartAndRecievingStolenCardException
                   |salesBook aSale anInterface|            
                   salesBook := OrderedCollection new.    
                   aSale := Cashier checkout: TestObjectsFactory newCartWithManyBooks andCharge: TestObjectsFactory validCreditCard todaysDateIs: Date today monthAndYear registerSaleIn: salesBook. 
                 anInterface := InterfaceBetweenMPAndCashier newInterfaceAskedBy: aSale chargeACard: TestObjectsFactory belonginTo: 'NN' .
                 self should: [anInterface receiveAStolenCardTransaction] raise: Error-MessageNotUnderstood withExceptionDo: [:anError| 
	     self assert: anError messageText equals: '1|This card is stolen'.
	      self assert: (OrderedCollection new) equals: aSale salesBook. 
	].
                 ! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'fs 6/15/2025 22:57:25'!
test07CheckingOutCartAndRecievingInvalidCardNumberException
                   |salesBook aSale anInterface|            
                   salesBook := OrderedCollection new.    
                   aSale := Cashier checkout: TestObjectsFactory newCartWithManyBooks andCharge: TestObjectsFactory invalidCreditCardNumber todaysDateIs: Date today monthAndYear registerSaleIn: salesBook. 
                 anInterface := InterfaceBetweenMPAndCashier newInterfaceAskedBy: aSale chargeACard: TestObjectsFactory belonginTo: 'NN' .
                 self should: [anInterface receiveAnInvalidCardNumerTransaction] raise: Error-MessageNotUnderstood withExceptionDo: [:anError| 
	     self assert: anError messageText equals: '1|Card number must be 16 digits'.
	      self assert: (OrderedCollection new) equals: aSale salesBook. 
	].              ! !


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


!Card methodsFor: 'assertions' stamp: 'fs 6/14/2025 18:41:51'!
isExpired: currentDate 
	^(expDate monthIndex <=  currentDate monthIndex) and: (expDate yearNumber >= currentDate yearNumber ).! !

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


!Cart methodsFor: 'cart actions' stamp: 'fs 6/14/2025 16:41:07'!
addToCart: aBook
      |previousValue| 
      (catalogue keys includes: aBook) ifFalse: [^self bookNotInCatalogue].
	booksToBePurchased at: aBook ifAbsentPut: [0].
	previousValue:= booksToBePurchased at: aBook.
	booksToBePurchased at: aBook put: previousValue+1.! !

!Cart methodsFor: 'cart actions' stamp: 'fs 6/12/2025 12:57:39'!
booksToBePurchased
	^booksToBePurchased! !

!Cart methodsFor: 'cart actions' stamp: 'fs 6/14/2025 17:51:05'!
totalPriceOfBooksToBePurchased
	|codeForBooks total|
	codeForBooks := booksToBePurchased keys.
	total := 0.
	codeForBooks do: [:aBook| total := total + ((booksToBePurchased at: aBook) * (catalogue at: aBook))]. 
	^total! !

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
	instanceVariableNames: 'salesBook cartToCheckOut'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'fs 6/14/2025 18:34:06'!
initializeACheckoutFor: aCart charge: aCreditCard currentDateIs: currentDate andRegisterSaleIn: aSalesBook  
               salesBook := aSalesBook.
               (aCreditCard isExpired: currentDate) ifTrue: [^self error: self class expiredCard].
               (aCart isEmpty) ifTrue: [^self error: self class invalidCart]. 
                cartToCheckOut:=  aCart. ! !

!Cashier methodsFor: 'initialization' stamp: 'fs 6/14/2025 17:37:25'!
salesBook
	^salesBook! !


!Cashier methodsFor: 'actions' stamp: 'fs 6/15/2025 22:27:35'!
registerATransaction
	salesBook add: 'sales_id_01'.! !

!Cashier methodsFor: 'actions' stamp: 'fs 6/14/2025 17:34:19'!
totalToPay
         salesBook add: self.
	^cartToCheckOut totalPriceOfBooksToBePurchased! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #tusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'fs 6/14/2025 18:33:11'!
checkout: aCart andCharge: aCreditCard todaysDateIs: currentDate registerSaleIn: aSalesBook 
                 ^self new initializeACheckoutFor: aCart charge: aCreditCard currentDateIs: currentDate andRegisterSaleIn: OrderedCollection new ! !


!Cashier class methodsFor: 'error messages' stamp: 'fs 6/14/2025 18:43:04'!
expiredCard
	^'Card is expired'! !

!Cashier class methodsFor: 'error messages' stamp: 'fs 6/13/2025 20:15:39'!
invalidCart
       ^'Please select a book before checking out'! !


!classDefinition: #InterfaceBetweenMPAndCashier category: #tusLibros!
Object subclass: #InterfaceBetweenMPAndCashier
	instanceVariableNames: 'cashier nameOfBuyer card'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

!InterfaceBetweenMPAndCashier methodsFor: 'initialization' stamp: 'fs 6/15/2025 22:13:49'!
initializeATransactionAskedByCashier: aCashier creditCard: aCard belonginTo: aClientName
                   cashier := aCashier.
                   card := aCard .
                   nameOfBuyer := aClientName .! !


!InterfaceBetweenMPAndCashier methodsFor: 'associating' stamp: 'fs 6/15/2025 22:26:28'!
receiveACorrectTransaction
	cashier registerATransaction.
	^'0|Successful purchase'.! !


!InterfaceBetweenMPAndCashier methodsFor: 'error message' stamp: 'fs 6/15/2025 22:41:29'!
receiveAStolenCardTransaction
	^self error: self class stolenCard ! !

!InterfaceBetweenMPAndCashier methodsFor: 'error message' stamp: 'fs 6/15/2025 22:52:49'!
receiveAnInvalidCardNumerTransaction
	^self error: self class insuficcientAmountOfDigitsOnCardNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfaceBetweenMPAndCashier class' category: #tusLibros!
InterfaceBetweenMPAndCashier class
	instanceVariableNames: ''!

!InterfaceBetweenMPAndCashier class methodsFor: 'error messages' stamp: 'fs 6/15/2025 21:44:21'!
insuficcientAmountOfDigitsOnCardNumber
                   ^'1|Card number must be 16 digits'! !

!InterfaceBetweenMPAndCashier class methodsFor: 'error messages' stamp: 'fs 6/15/2025 21:44:33'!
insuficcientBalance
                   ^'1|Insuficcient balance for this purchase'! !

!InterfaceBetweenMPAndCashier class methodsFor: 'error messages' stamp: 'fs 6/15/2025 21:44:38'!
stolenCard
                   ^'1|This card is stolen'! !


!InterfaceBetweenMPAndCashier class methodsFor: 'instance creation' stamp: 'fs 6/15/2025 22:13:12'!
newInterfaceAskedBy: aCashier chargeACard: aCard belonginTo: aClientName
                 ^self new initializeATransactionAskedByCashier: aCashier creditCard: aCard belonginTo: aClientName! !


!classDefinition: #TestObjectsFactory category: #tusLibros!
Object subclass: #TestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestObjectsFactory class' category: #tusLibros!
TestObjectsFactory class
	instanceVariableNames: ''!

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:27:30'!
cardWithExpiredDate: currentDate 
                  ^currentDate monthAndYear previous .! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:51:19'!
cardWithValidDate: currentDate 
                  ^currentDate monthAndYear next .! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/15/2025 22:54:45'!
invalidCreditCard
                 ^ Card newCardWithNumber: TestObjectsFactory invalidNumber withExpirationDate: (TestObjectsFactory cardWithExpiredDate: Date today).! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/15/2025 22:57:12'!
invalidCreditCardNumber
                 ^ Card newCardWithNumber: TestObjectsFactory invalidNumber withExpirationDate: (TestObjectsFactory cardWithValidDate: Date today )! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/15/2025 22:54:56'!
invalidNumber
                  ^1111111111111! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 17:03:11'!
newCart
       |aCart|
            aCart:=   Cart newCartWithCatalogue: TestObjectsFactory newCatalogue . 
            aCart addToCart: 'book1'.
            ^aCart.! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 17:42:53'!
newCartWithManyBooks
             |aCart|
            aCart:=  Cart newCartWithCatalogue: TestObjectsFactory newCatalogue . 
            aCart addToCart: 'book1'.
            aCart addToCart: 'book1'.
            aCart addToCart: 'book2'.
            ^aCart.! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 17:26:50'!
newCatalogue
            |newDict|
                   newDict:= Dictionary new . 
                   newDict add: 'book1' -> 20.
                   newDict add: 'book2' -> 10.
                ^newDict! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 18:55:13'!
validCreditCard
                 ^Card newCardWithNumber: TestObjectsFactory validNumber withExpirationDate: (TestObjectsFactory cardWithValidDate: Date today )! !

!TestObjectsFactory class methodsFor: 'as yet unclassified' stamp: 'fs 6/14/2025 16:05:20'!
validNumber
                  ^1111111111111111! !
