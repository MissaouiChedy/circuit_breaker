defmodule CircuitBreaker.ApiGatewayCircuitBreaker do
    
    @behaviour :gen_statem
    
    @name :circuit_breaker
    @error_count_limit 6
    @to_half_open_delay 8000

    def start_link do
        :gen_statem.start_link({:local, @name}, __MODULE__, [], [])
    end

    def init([]) do 
        {:ok, :closed, %{ error_count: 0 }}
    end

    def callback_mode do 
        :state_functions
    end

    def get_pages do
        :gen_statem.call(@name, :get_pages)
    end

    def closed({:call, from}, :get_pages, data) do
        case CircuitBreaker.ApiGateway.get_pages() do
            {:ok, pages} -> 
                {:keep_state, %{error_count: 0}, {:reply, from, {:ok, pages}}}
            {:error, reason} ->
                handle_error(reason, from, %{ data | error_count: data.error_count + 1}) 
        end
    end

    """
    Transition to open
    """
    defp handle_error(reason, from, data = %{error_count: error_count}) 
        when error_count > @error_count_limit do
            open_circuit(data, reason, @to_half_open_delay)
    end

    """
    Keep closed
    """
    defp handle_error(reason, from, data) do
        {:keep_state, data, {:reply, from, {:error, reason}}}
    end

    def open({:call, from}, :get_pages, data) do
        {:keep_state, data, {:reply, from, {:error, :circuit_open}}}
    end

    def open(:info, :to_half_open, data) do
        {:next_state, :half_open, data}
    end

    def half_open({:call, from}, :get_pages, data) do
        case CircuitBreaker.ApiGateway.get_pages() do
            {:ok, pages} -> 
                {:next_state, :closed, %{count_error: 0}, {:reply, from, {:ok, pages}}}
            {:error, reason} ->
                open_circuit(data, reason, @to_half_open_delay)
        end
    end

    defp open_circuit(data, reason, delay) do
        Process.send_after(@name, :to_half_open, delay)
        {:next_state, :open, data, {:reply, from, {:error, reason}}}
    end
end