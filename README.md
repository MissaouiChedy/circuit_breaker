# Circuit Breaker Elixir Sample

A simple sample Elixir application demonstrating the usage of the Circuit Breaker design pattern.
 
This example is discussed in [The Circuit Breaker Pattern Part 3 - Elixir implementation](http://blog.techdominator.com/article/circuit-breaker-pattern-part-3-elixir-implementation)

## Principle

A Circuit Breaker is an object that wraps an integration point to an external system that is usually remote, prone to failure and can sometimes respond with high latency (3rd party service, database, queue).

This wrapper tracks the availability of the external system and can implement behaviors that stabilizes the system when the external system is down. To learn more please checkout:

- [The Circuit Breaker Design Pattern - Basic Principle](http://blog.techdominator.com/article/circuit-breaker-pattern-part-1-basic-principle.html)
- [Circuit Breaker](https://martinfowler.com/bliki/CircuitBreaker.html)

## Building and running the example

In order to run the example you will need an elixir development environment, [please checkout this guide for platform specific installation](https://elixir-lang.org/install.html).

After cloning the repository, to run the example execute the following:

```
cd circuit_breaker
mix deps.get
iex -S mix
```

Once in the elixir shell session you can run the `main` function:
```
iex> CircuitBreaker.main
```


