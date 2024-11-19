PIZZA ORDERING SYSTEM

Assessment Project for the position of Jr. Full-Stack Developer at Evermood

This repository contains the Pizza Ordering System, a Ruby on Rails application for managing pizza orders, designed for internal use and collaborative development.
Getting Started
Prerequisites

    Ruby 3.1.2
    Rails 7.1.3
    PostgreSQL
    importmaps (default)


Initial config and data:

    db/initial_data/config.yml
    This file contains information for the initial records for the Database: Pizzas, Ingredients, Size Multipliers, Discount Codes, and Promotions
    db/initial_data/orders.json
    This file contains the "OPEN" Orders that must populate the Database.

    Both files will get parsed automatically and populate the Database with their data when running:
    rails db:seed



rails server

    rails s

Database

    All tables use UUID keys and must be set manually for new tables or new associations.


![DataBase Schema Pizza Ordering System](https://github.com/user-attachments/assets/c6501df3-38b4-4de6-877e-6d839b56d73e)


Gems

    rails, sprockets-rails, pg, puma, importmap-rails, turbo-rails, stimulus-rails, jbuilder, tzinfo-data, bootsnap, debug,
    rspec-rails, factory_bot_rails, capybara, database_cleaner-active_record, faker, shoulda-matchers, web-console, error_highlight,
    rubocop-rails, rubocop-rspec

Orders Management

    OrdersController#index: Displays open orders.
    OrdersController#update: Handles state updates (e.g., marking orders as "CLOSED"). It uses Turbo Stream to make the changes without reloading          the page

Items & Customizations
    
    Models: 
      - Order: The pizza order may have many OrderItems, PromotionCodes, and one DiscountCode. It has a total_price that is calculated through a               callback before_save, meaning before creation and update, to maintain the reliability of the price when changes are made to the Order.
      - SizeMultiplier: It has predefined multipliers for each size of pizza.
      - Pizza: It has a name and a price.
      - Ingredient: It has a name and a price for calculating the addition of extra ingredients to an OrderItem.
      - OrderItemIngredientModification: The Connection Model between Ingredient and OrderItem that specifies if it "add" or "remove" an ingredient            from the OrderItem
      - OrderItem: It contains the order items. For an ItemOrder to be valid, it needs a Pizza and a SizeMultiplier, while the addition or removal of          ingredients is optional. , OrderPromotionCodes.
      - PromotionCode: An Order may have many PromotionCodes that lower the quantity of Pizzas to pay (3 for 1 for example). It's applied to the Order         before the DiscountCode is applied if there're any.
      - DiscountCode: An Order may have a DiscountCode to lower the amount to pay of the Order's final price.

Testing

    RSpec for unit and feature tests.
    FactoryBot for generating test data.
    Capybara for integration tests (browser-based).

Important Files

    app/controllers/orders_controller.rb
    app/models/order.rb

Development Guidelines

    Code Style
        Follow Rubocop for Ruby code linting.

Common Issues

    The callback method for calculating the Order total_price may misbehave if not careful
    Capybara tests may behave strangely with DataCleaner and RSpec

    Check if the database seeds have been run


Future Improvements

    Write more rigorous tests.
    Set Capybara to work correctly with DataCleaner.
    Enhance test coverage for edge cases.
    Refactor OrderController private methods and Order private methods
    

Contacts

For any questions or feedback, contact:

    Rodrigo Hoffmann, rhoffmannp@gmail.com
