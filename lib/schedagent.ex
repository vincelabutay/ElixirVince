#schedagent ###
#date started: June 9, 2020



defmodule schedagent do
    
    
    def main do
        IO.puts("Getting Directives...")
            serv = File.read!("config/SQAConfig_Server.txt")
            [_ | tail] = String.split(serv, "\n", trim: true)
            sqaconf = for item <- tail, into: %{} do
                [key, value] = String.split(item, ": ")
                {key, to_charlist(value)}
    

            unit = File.read!("config/SQAConfig_Unit.txt")
            [_ | tail] = String.split(unit, "\n", trim: true)
            unitconf = for item <- tail, into: %{} do
                [key, value] = String.split(item, ": ")
                {key, to_charlist(value)}
        end


    def test_internet() do
        :inets.start
        status = :httpc.request('http://www.google.com') |> elem(1) |> elem(0)
        if status == {'HTTP/1.1', 200, 'OK'} do
            IO.puts "Connected to the Internet..."
            true
        else
            IO.puts "No Internet Connection!"
            false
        end


########CONFIGPARSER##########

    #updated: June 19, 2020 - (Ongoing)
    #create: test codes for configparse for schedagent

    def configparser.file do
        use Mix.Config


        configparsepath = '/root/sqa/SQAConfig_Server.txt'
        {:ok, parse_result} = config_file_path("configparsepath")
        get(parse_result, SQA_Server, directory)
        get(parse_result, SQA_Server, username)
        get(parse_result, SQA_Server, password)
        get(parse_result, SQA_Server, host)
        sections(parser_result)

        configparsepath2 = '/root/sqa/SQAConfig_Unit.txt'
        {:ok, parse_result} = config_file_path("configparsepath2")
        get(parse_result, ManID, directory)
        get(parse_result, SQAID, username)
        get(parse_result, AgeID, key(ManID+SQAID))
        sections(parser_result)

    end


    def create_task do
        task = ["ST", "FA", "PING", "BOOT"]

        for task <- task do   //result from the comprehension 
        "#{task}"
    end

    def contains? (Task) do
        Enum.member?(Data, Task)
        if Task == ["ST", "FA", "PING", "BOOT"] do
        return true
    end
    



    #updated: June 16, 2020 - Ongoing(June 29, 2020)
    #create directive file with internet on

    def internetison(Data) do
        
        :inets.start
        status = :httpc.request('http://www.google.com') |> elem(1) |> elem(0)
        if status == {'HTTP/1.1', 200, 'OK'} do

            Data = ["SCHEDULE:0730H", "SCHEDULE:1700H", "SCHEDULE:2000H". "ST: 1169", FA],
            Print = string:join(Data, "\n"),
            #file:write_file("C:/Vince/Desktop/elixirtest.txt",  [Print]).
            binary = :erlang.term_to_binary(Data)
            File.write(filename, binary)
        return
    end

    def load(filename) do
        {status, binary} = File.read(filename)
        :erlang.binary_to_term binary
    end

    


############################################################################
#####################TESTCODES FOR SUBPROCESS COMMANDS######################
############################################################################


def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

############################################################################
#####################TESTCODES FOR SUBPROCESS COMMANDS######################
############################################################################


end