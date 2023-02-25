# Laser Morse

Use Atom Editor


https://tinyfpga.com/bx/guide.html
https://tinyfpga.com/bx/guide.html

ice40lp8k-cm81

Core Voltage 1.14
IO Banks 2.5



# Linter

```
https://github.com/manucorporat/linter-verilog
```

then

```
brew install icarus-verilog
```




## I2C Version Proposal

We could make an I2C Core and expose our inputs as a set of messages

- Set mode
    - Send a message
    - Set Clock Speed
    - get clock speed
    - reset to default message
    - read message out
    - read more out
        - value (dot, dash, no value)
        - enableLaser (if dot or dash)
    
    