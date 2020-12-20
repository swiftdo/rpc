
import ArgumentParser


struct RPC: ParsableCommand {

    static var configuration = CommandConfiguration(commandName: "RPC",
                                                    abstract: "RPC CLI",
                                                    version: "1.0.0",
                                                    subcommands: [Client.self, Server.self],
                                                    defaultSubcommand: Client.self)

}

extension RPC {


    struct Client: ParsableCommand {
        static var configuration: CommandConfiguration = CommandConfiguration(abstract: "开启客户端")

        @Argument(help: "传递名称")
        var name: String


        func run() throws {
            let client = RpcClient(host: "localhost", port: 8033)

            do {
                try client.start(name: name)
            } catch {
                print("error: \(error)")
                client.stop()
            }
        }
    }
}


extension RPC {
    struct Server: ParsableCommand {
        static var configuration: CommandConfiguration = CommandConfiguration(abstract:"开启服务端")

        func run() throws {
            let server = RpcServer(host: "localhost", port: 8033)

            do {
                try server.start()
            } catch  {
                print("Error: \(error)")
                server.stop()
            }
        }
    }
}

RPC.main()
