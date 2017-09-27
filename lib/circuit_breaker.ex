defmodule CircuitBreaker do
  
  def main do
    CircuitBreaker.ApiGatewayCircuitBreaker.start_link
    Enum.each(0..1000, fn _ -> 
      res = CircuitBreaker.ApiGatewayCircuitBreaker.get_pages
      IO.inspect res
      Process.sleep(800)
    end)
  end
end
