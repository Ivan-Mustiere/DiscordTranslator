using System;
using System.Net.Http;
using System.Threading.Tasks;

class Program
{
    static async Task Main(string[] args)
    {
        string apiUrl = "https://api.monsite.com/users"; // ton endpoint API

        using (HttpClient client = new HttpClient())
        {
            try
            {
                // Appel GET
                HttpResponseMessage response = await client.GetAsync(apiUrl);
                response.EnsureSuccessStatusCode();

                // Lire la réponse
                string responseBody = await response.Content.ReadAsStringAsync();
                Console.WriteLine("Réponse de l'API :");
                Console.WriteLine(responseBody);
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine("Erreur lors de l'appel API : " + e.Message);
            }
        }

        Console.WriteLine("\nAppuyez sur une touche pour quitter...");
        Console.ReadKey();
    }
}
