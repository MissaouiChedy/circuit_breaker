defmodule CircuitBreaker.ApiGateway do
    
    def get_pages do
        case HTTPoison.get(url()) do
            {:ok, response} -> {:ok, get_pages_field!(response.body)}
            {:error, %HTTPoison.Error{id: _, reason: reason}} -> {:error, reason}
        end
    end
    
    defp url do
        'https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exchars=100&explaintext&titles=Earth|Mar&continue&format=json'
    end

    defp get_pages_field! raw_body do
        json_response = raw_body
            |> Poison.decode!
        json_response["query"]["pages"]
    end
end