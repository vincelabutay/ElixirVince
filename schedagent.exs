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

########
configparser = configparser.RawConfigParser()
configFilePath = r'/root/sqa/SQAConfig_Server.txt', '/root/sqa/SQAConfig_Unit.txt'
configparser.read(configFilePath)

directory = configparser.get("SQAServer", "directory")
username = configparser.get("SQAServer", "username")
password = configparser.get("SQAServer", "password")
host = configparser.get("SQAServer", "host")

interval = configparser.get("SQAUnit", "interval")
ManID = configparser.get("SQAUnit", "ManID")
AgeID = configparser.get("SQAUnit", "AgeID")
SQAID = str(ManID + AgeID)
########