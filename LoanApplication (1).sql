Create Database LoanApplicationDB


CREATE TABLE LoanApplicationDetail
(
	Application_ID INT PRIMARY KEY NOT NULL,
	LoanOfficerID INT FOREIGN KEY REFERENCES LoanOfficerInfo(LoanOfficerID) NOT NULL,
	Loan_Type_ID TINYINT FOREIGN KEY REFERENCES LoanType(Loan_Type_ID) NOT NULL,
	Purchase_Pice Money NOT NULL,
	DownPaymentAmount Money NOT NULL,
	LoanAmount Money NOT NULL,
	Application_Status_ID Tinyint FOREIGN KEY REFERENCES ApplicationStatus(Application_Status_ID),
	ApplicationDate Date check (ApplicationDate<=getdate()),
	Borrower_ID INT FOREIGN KEY REFERENCES Borrower_Personal_Info(Borrower_ID) NOT NULL
	)


CREATE TABLE Auto_Loan
(
	AutoApplicationID int PRIMARY KEY NOT NULL,
	Vehicle_Type VARCHAR(20) NULL,
	Make VARCHAR(20) NOT NULL,
	Model VARCHAR(20) NOT NULL,
	ModelYear VARCHAR(5),
	Milage INT NOT NULL,
	Application_ID INT FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL,
)

CREATE TABLE PersonalLoan
(
	PersonalApplicationID INT PRIMARY KEY NOT NULL,
	Loan_Type_ID TINYINT FOREIGN KEY REFERENCES LoanType(Loan_Type_ID) NOT NULL,
	ReasonForLoan VARCHAR(100) NOT NULL,
	Application_ID INT FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL 
)

CREATE TABLE MortgageLoan
(
	MortgageApplicationID INT PRIMARY KEY NOT NULL,
	PropertyType VARCHAR(20) NOT NULL,
	PropertyAddress VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	PropertyZip VARCHAR(11) NOT NULL check(PropertyZip like ('[][][][][]') OR PropertyZip like ('[][][][][][][][][]')),
	PropertyStatusID TINYINT NOT NULL,
	Application_ID int FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL
)

CREATE TABLE LoanContract
(
	LoanID INT PRIMARY KEY NOT NULL,
	Application_ID INT FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL,
	BranchID SMALLINT FOREIGN KEY REFERENCES Branch(BranchID) NOT NULL,
	LoanStatusID TINYINT FOREIGN KEY REFERENCES LoanStatus(LoanStatusID) NOT NULL,
	DateContractStarts DATE NOT NULL check (DateContractStarts<=getdate()),
	DateContractEnd	DATE NOT NULL check (DateContractEnd>=getdate()),
	InterstRate DECIMAL NOT NULL,
	ScheduledPaytAmount MONEY NOT NULL,
	SchechuledNumOfPayt SMALLINT NOT NULL,
	ActualNumOfPayment INT NOT NULL,
	LoanAmountLeft MONEY NOT NULL
)

CREATE TABLE LoanPayment
(
	PaymentId INT PRIMARY KEY NOT NULL,
	LoanId INT FOREIGN KEY REFERENCES LoanContract(LoanId) NOT NULL,
	LoanPaymentAmount MONEY NOT NULL,
	LoanPaymentDueDate DATE NOT NULL check (LoanPaymentDueDate>getdate())
)

