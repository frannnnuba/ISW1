!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 5/29/2025 18:36:58'!
test01X
            |portfolio|
            portfolio := Portfolio createNewPortfolio.
            "portfolio addAnAccount: ReceptiveAccount new."
             self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 5/29/2025 16:35:44'!
test02X
            |portfolio account|
            portfolio := Portfolio createNewPortfolio.
            account := ReceptiveAccount new.  
            Deposit register: 100 on: account.
            portfolio addAnAccount: account.
            self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 14:07:55'!
test03X
            |portfolio portfolio2 account|
            portfolio := Portfolio createNewPortfolio.
            portfolio2 := Portfolio createNewPortfolio.
            account:= ReceptiveAccount new.  
            Deposit register: 100 on: account.
            portfolio2 addAnAccount: account.
            portfolio addAPortfolio: portfolio2. 
            self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 15:10:17'!
test04Y
              self deny: (Portfolio createNewPortfolio hasRegistered: (Deposit for: 100)).! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 14:56:53'!
test05Y
              |portfolio account deposit|
               portfolio := Portfolio createNewPortfolio.
               account := ReceptiveAccount new.  
               deposit := Deposit register: 100 on: account.
               portfolio addAnAccount: account.
              self assert: (portfolio hasRegistered: deposit ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 15:16:56'!
test06Y
              |portfolio portfolio2 account deposit|
               portfolio := Portfolio createNewPortfolio.
               portfolio2 := Portfolio createNewPortfolio.
               account := ReceptiveAccount new.  
               deposit := Deposit register: 100 on: account.
               portfolio2 addAnAccount: account.
               portfolio addAPortfolio: portfolio2.
              self assert: (portfolio hasRegistered: deposit ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 15:33:14'!
test07Z
              self assert: (Portfolio createNewPortfolio transactions isEmpty).! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 15:39:30'!
test08Z
             |portfolio account deposit|
             portfolio := Portfolio createNewPortfolio.
             account := ReceptiveAccount new.  
             deposit := Deposit register: 100 on: account.
             portfolio addAnAccount: account.
             self assert: (Set with: deposit) equals: portfolio transactions ! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 15:48:27'!
test09Z
             |portfolio portfolio2 account deposit|
             portfolio := Portfolio createNewPortfolio.
            portfolio2 := Portfolio createNewPortfolio.
             account := ReceptiveAccount new.  
             deposit := Deposit register: 100 on: account.
             portfolio2 addAnAccount: account.
             portfolio addAPortfolio: portfolio2.
             self assert: (Set with: deposit) equals: portfolio transactions. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'suarez 6/3/2025 14:01:25'!
test0NadelantadoX
           "chequear que sea arbol"
            |portfolio portfolio2 |
            portfolio := Portfolio createNewPortfolio.
            portfolio2 := Portfolio createNewPortfolio.
            portfolio2 addAPortfolio: portfolio.
           portfolio addAPortfolio: portfolio2.
            self deny: portfolio isATree.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:07:53'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:07:57'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:08:01'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:08:26'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:08:12'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'suarez 5/27/2025 21:56:53'!
valueForBalance: colab1

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'suarez 5/27/2025 22:05:26'!
valueForBalance: colab1
                ^  colab1 +  value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'suarez 5/27/2025 21:57:51'!
valueForBalance: colab1
                ^colab1 - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'portfolios accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'suarez 6/3/2025 14:03:27'!
includesAnotherPortfolio: aPortfolio 
	^portfolios includes: aPortfolio. ! !

!Portfolio methodsFor: 'assertions' stamp: 'suarez 6/3/2025 14:04:29'!
isATree
	^(portfolios select: [:otherPortfolio| otherPortfolio includesAnotherPortfolio: self]) isEmpty and: (accounts select: [:otherPortfolio| otherPortfolio includesAnotherPortfolio: self]) .! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'suarez 6/3/2025 14:02:39'!
addAPortfolio: aRename1 
	portfolios add: aRename1 .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'suarez 6/3/2025 14:02:32'!
addAnAccount: aRenameMe1 
	accounts add: aRenameMe1 ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'suarez 6/3/2025 14:06:34'!
balance
	|counter flattenedPortfolio|
	counter := 0.
	"flattenedPortfolio := self flattenPortfolio .
	flattenedPortfolio" portfolios do: [:anAccountOrPortfolio| counter := counter + anAccountOrPortfolio balance].
	 accounts do: [:anAccountOrPortfolio| counter := counter + anAccountOrPortfolio balance].  
	 ^counter.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'suarez 5/29/2025 18:10:27'!
flattenPortfolio
	|flattenedPortfolio|
	 flattenedPortfolio := Set new.
	 partsOfThePortfolio do: [:aPortfolioOrAccount |
		flattenedPortfolio := flattenedPortfolio union: aPortfolioOrAccount flattenPortfolio].
	^flattenedPortfolio ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'suarez 6/3/2025 15:23:12'!
hasRegistered: aTransaction
             |aBooleanFlag|
              aBooleanFlag := false.
              accounts do: [:anAccount| aBooleanFlag := aBooleanFlag or: (anAccount hasRegistered: aTransaction)].
              portfolios do: [:aPortfolio| aBooleanFlag := aBooleanFlag or: (aPortfolio hasRegistered: aTransaction)].
               ^aBooleanFlag 
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'suarez 6/3/2025 16:00:19'!
transactions
         |theTransactions|
         theTransactions := Set new.
	  accounts do: [:anAccount| theTransactions := theTransactions union: anAccount transactions asSet].
	   portfolios do: [:aPortfolio| theTransactions := theTransactions union: aPortfolio transactions asSet].
	  ^theTransactions! !


!Portfolio methodsFor: 'initialization' stamp: 'suarez 6/3/2025 14:03:10'!
initializeCreateNewPortfolio
	portfolios := Set new.
	accounts := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'suarez 5/29/2025 15:49:43'!
createNewPortfolio
	^self new initializeCreateNewPortfolio! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'suarez 5/27/2025 22:07:04'!
balance
           |counter|
            counter := 0.
           (transactions isEmpty) ifTrue: [^counter].
          transactions do: [:aTransaction| counter := aTransaction valueForBalance: counter].
         ^counter
      
	"^transactions sum: [ :aTransaction | (aTransaction isKindOf: Withdraw) ifTrue: [aTransaction value negated] ifFalse: [aTransaction value]] ifEmpty: [ 0 ]"! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'convertions' stamp: 'suarez 5/29/2025 18:03:12'!
flattenPortfolio
	^Set with: self.! !
