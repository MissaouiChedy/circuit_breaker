defmodule CircuitBreaker do
  
  def main do
    ## start the behavior
    CircuitBreaker.ApiGatewayCircuitBreaker.start_link
    
    ## make succesive queries
    Enum.each(0..1000, fn _ -> 
      CircuitBreaker.ApiGatewayCircuitBreaker.get_pages
      |> IO.inspect
      Process.sleep(800)
    end)
  end
end
