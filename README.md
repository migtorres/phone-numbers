# Area Coder

Area coder is a ruby app that reads phone numbers from a TXT file and counts the number of records according to their area codes.

## Install

You should have installed Ruby (if possible using RVM) and if you do not have bundler install you should install it globally typing:


```
gem install bundler
```

Having bundler install you will just need to install the gems:

```
bundle install
```

## Running

To run the software you will need a file with phone numbers. As an example you can check [example.txt](example.txt).

The command to use is the following (you can replace the example file with any other):

```
./area_coder example.txt
```

This will use as a matcher [area_codes.txt](area_codes.txt). If you have a new area_codes list you can replace it.

## Code

The main engine of this app is the [prefix_counter.rb](PrefixCounter) module. It is a ruby module that reads data from two arrays:

* Phone Numbers Array
* Prefixes Array

It validades and then summarizes the phone numbers according to their area codes.

## Tests

We are using rspec for testing. The tests are in the [spec/](spec directory).

To run the tests you should:
```
rspec spec
```
