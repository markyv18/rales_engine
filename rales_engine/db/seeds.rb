# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'date'

class Intake

  def initialize(file_name)
    @filetype = file_name
    @file = "db/csv/#{file_name}.csv"
    @object = file_objects[file_name]
  end

  def file_objects
    {
      customers: Customer,
      invoices: Invoice,
      invoice_items: InvoiceItem,
      items: Item,
      merchants: Merchant,
      transactions: Transaction
    }
  end

  def csv
    CSV.read(@file, :headers => true)
  end

  def upload_csv
    upload_csv = csv
    upload_csv.delete("id")
    upload_csv
  end

  def table_count
    @object.count.to_s.rjust(5)
  end

  def csv_count
    csv.count.to_s.rjust(5)
  end

  def upload
    case @filetype
    when :customers
      upload_customer
    when :invoices
      upload_invoice
    when :invoice_items
      upload_invoice_item
    when :items
      upload_invoice_item
    when :merchants
      upload_merchant
    when :transactions
      upload_transaction
    end
    upload_completed
  end

  def upload_completed
    puts "#{name} -- #{table_count == csv_count ? "SUCCESS" : "FAILURE"} -- #{table_count} #{csv_count}"
  end

  def name
    @type.to_s.rjust(14)
  end

  def upload_customer
    upload_csv.each do |row|
      Customer.create(row.to_h)
    end
  end

  def upload_invoice
    upload_csv.each do |row|
      merchant = Merchant.find(row["merchant_id"])
      row.delete("merchant_id")
      merchant.invoices.create(row.to_h)
    end
  end

  def upload_invoice_item
    upload_csv.each do |row|
      invoice = Invoice.find(row["invoice_id"])
      row.delete("invoice_id")
      row["unit_price"] = convert_to_currency(row["unit_price"])
      invoice.invoice_items.create(row.to_h)
    end
  end

  def upload_item
    upload_csv.each do |row|
      merchant = Merchant.find(row["merchant_id"])
      row.delete("merchant_id")
      row["unit_price"] = convert_to_currency(row["unit_price"])
      merchant.items.create(row.to_h)
    end
  end

  def upload_merchant
    upload_csv.each do |row|
      Merchant.create(row.to_h)
    end
  end

  def upload_transaction
    upload_csv.each do |row|
      invoice = Invoice.find(row["invoice_id"])
      row.delete("invoice_id")
      row["credit_card_expiration_date"] = Date.new(2018,3)
      invoice.transactions.create(row.to_h)
    end
  end
end

files = [:customers, :merchants, :invoices, :items, :transactions, :invoice_items]

files.each do |file_name|
  file = Intake.new(file_name)
  file.upload
end
