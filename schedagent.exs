#schedagent 
#date started: June 9, 2020



defmodule Schedagent do
    
    ###
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

        


        ###FTP CONNECT###
            :inets.start
            {:ok, pid} = :inets.start(:ftpc, host: 'host')
            :ftp.user(pid, 'username', 'password')
            :ftp.pwd(pid)
            :ftp.cd(pid, 'r03/sqa/directives')
            :ftp.lpwd(pid)
            :ftp.lcd(pid, '/Vince/Desktop/Directives')
            :ftp.recv(pid, 'sqaID ++ '.txt')
            :inets.stop(:ftpc, pid)
        end
    end
end