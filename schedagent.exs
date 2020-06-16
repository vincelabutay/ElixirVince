#schedagent ###
#date started: June 9, 2020



defmodule Schedagent do
    
    
    def main do
        IO.puts("Getting Directives...")
            serv = File.read!("config/SQAConfig_Server.txt")
            [_ | tail] = String.split(serv, "\n", trim: true)
            sqaconf = for item <- tail, into: %{} do
                [key, value] = String.split(item, ": ")
                {key, to_charlist(value)}
        end

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

###FTP CONNECT###

  #####      :inets.start
        {:ok, pid} = :inets.start(:ftpc, host: 'host')
        :ftp.user(pid, 'sqa-cpe-r03', 'Ry6bd5!3')
        :ftp.pwd(pid)
        :ftp.cd(pid, 'r03/sqa/directives')
        :ftp.lpwd(pid)
        :ftp.lcd(pid, '/Vince/Desktop/Directives')
        :ftp.recv(pid, 'sqaID ++ '.txt')
        :inets.stop(:ftpc, pid)
        end   #####

########CONFIGPARSER##########

    #updated: June 15, 2020
    #create: test codes for configparse for schedagent

    def configparser.file do
        use Mix.Config


        :configparsepath = '/root/sqa/SQAConfig_Server.txt'
        {:ok, parse_result} = config_file_path("configparsepath")
        :get(parse_result, SQA_Server, directory)
        :get(parse_result, SQA_Server, username)
        :get(parse_result, SQA_Server, password)
        :get(parse_result, SQA_Server, host)
        sections(parser_result)



    end
end



###
       def internetison() do
        :inets.start
        status = :httpc.request('http://www.google.com') |> elem(1) |> elem(0)
        if status == {'HTTP/1.1', 200, 'OK'} do

            Data = ["SCHEDULE:0730H", "SCHEDULE:1700H", "SCHEDULE:2000H". "ST: 1169", FA],
            Print = string:join(Data, "\n"),
            file:write_file("C:/Vince/Desktop/elixirtest.txt",  [Print]).

###