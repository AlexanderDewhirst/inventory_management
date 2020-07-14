# Bops Inventory Management System

This goal of this project is to build a lightweight inventory system in a small web application. Users will have the ability to manage items with categories and other various properties. Property types should only be numeric or text, and the numeric types will need to be able to be aggregated.

## Features
As a user managing inventory, the user must have the following abilities:
 - Create, Read, Update, Delete any item in the inventory
 - Create item with the same property as another item (item duplication)
 - Create, Delete a category
 - Add, Remove items from a category
 - Filter items by category
 - Aggregate item values for a property within a category
 - Aggregate item values for a property
 - NOT be able to Update item with invalid information

## Expectations
The application should be setup to be consumed via a standard web browser using http or https. The application can use any combination of CSS, HTML, JavaScript, frameworks, but must be geared towards being well-organized, using templates, and testing. The application should also have a background image, use modern fonts, employ good color choices for contrast, and be accessible.

# Getting Started
This application uses ruby 2.6.5, rails 6.0.3, PostgreSQL 12.2. 
To get started, clone this repository:
`git clone XXX`

This application uses postgresql, ensure you have PostgreSQL installed and check the `database.yml` file. To build the database, execute:
`rake db:setup`