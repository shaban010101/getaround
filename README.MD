# Instructions on installing
1. The project requires ruby version 3.0.2 to be installed on your machine
2. To install the gems run `bundle install`
3. To run a level type this into the command line amending the numbers to get a different level  `ruby ./lib/level1/main.rb level1/data/input.json` , this output a JSON file here `level1/data/output.json`

## Errors
If the input has any errors the following output will be seen in the command line
```
Rental ID 1
Car can't be blank
Rental ID 2
Car can't be blank
Rental ID 3
Car can't be blank
```

## Notes
I went with an approach with the presentation outputting the JSON which then executed a Service object. I also made the Rental,Car and Options into separate model objects as they all had data which can fit in their objects. 

I added input models for Cars and Rentals to both create their objects and also validate the inputs provided just in case they had any missing or wrong data from the input.

Areas which can improve if I had would be having config files for the constants to allow changing these values a lot more easily in the future as sometimes these need to change for business reasons.
Also smaller service objects especially the CalculateCommission and CalculateCreditsAndDebits classes

#### Gems used
I used RSpec for testing and RSpec JSON expectations to check the JSON outputted as it made finding any issues with the JSON in tests easier.
For debugging I used byebug as it is quite a useful debugger for investigating the code while it is running.
Active Model was used as it provides a nice interface to have the data, validate it and provide data errors all built into the Gem.
Finaly I used rubocop to lint the code and follow the ruby best practices.
