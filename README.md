# rales_engine

Type and enter: Run rspec
This runs tests that confirm the valid operation of the tools in this application. F's denote a failing test while a "." denotes a passing test.  

Type "rails server" (or rails s) into your terminal and hit enter. On your browser of choice navigate via the url bar to localhost:3000  See below as to the suffix options you can append to your url so as to view various metrics associated with this application.

Merchants - Record End Points

  /api/v1/merchants
  /api/v1/merchants/:id
  /api/v1/merchants/random

Customers - Record End Points

  /api/v1/customers
  /api/v1/customers/:id
  /api/v1/customers/random

Items - Record End Points

  /api/v1/items
  /api/v1/items/:id
  /api/v1/items/random

Invoices - Record End Points

  /api/v1/invoices
  /api/v1/invoices/:id
  /api/v1/invoices/random

Invoice_Items - Record End Points

  /api/v1/invoice_items
  /api/v1/invoice_items/:id
  /api/v1/invoice_items/random

Transactions - Record End Points

  /api/v1/transactions
  /api/v1/transactions/:id
  /api/v1/transactions/random

--------------------------------------------------------------------------

Merchants - Relationship End Points

  /api/v1/merchants/:id/items all items a merchant carries
  /api/v1/merchants/:id/invoices all invoices for said merchant

Invoices - Relationship End Points
