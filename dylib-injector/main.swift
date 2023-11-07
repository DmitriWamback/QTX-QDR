import Foundation
import Cocoa

class Injector {

    var pipe:                   Pipe!
    var applicationPath:        String!
    var dylibBuildName: String = "__injectsrc"

    init(applicationPath: String) {
        self.applicationPath = applicationPath
    }

    func createProcess(command: [String]) -> Process {
        pipe = Pipe()

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.standardOutput = pipe
        task.standardError  = pipe
        task.standardInput  = nil
        task.arguments = command
        return task
    }

    func runTask(process: Process) -> String {

        var output = ""
        do {
            try process.run()
            output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)!
        }
        catch { return error.localizedDescription }

        return output
    }

    func startWithInjection(source: String) -> String {
        
        buildDynamicLibraryFromRawCSource(source: source)
        unrestrictTargetApplication()
        let basicCommand = ["-c", "DYLD_INSERT_LIBRARIES=\(dylibBuildName).dylib "+self.applicationPath]

        return runTask(process: createProcess(command: basicCommand))
    }

    func start() -> String {
        let command = ["-c", "./a.out"]
        return runTask(process: createProcess(command: command))
    }
}
extension Injector {

    func unrestrictTargetApplication() {

    }

    func buildDynamicLibraryFromRawCSource(source: String) {

        let file = URL(fileURLWithPath: dylibBuildName+".c")
        do {
            try source.write(to: file, atomically: true, encoding: .utf8)
        }
        catch { print(error) }

        let commands = [
            "-c", "gcc -dynamiclib \(dylibBuildName).c -o \(dylibBuildName).dylib"
        ]
        let buildDylibProcess = createProcess(command: commands)
        print(runTask(process: buildDylibProcess))
    }
}


let main = Injector(applicationPath: "testapp/a.out")
print(main.startWithInjection(source: """

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int system(const char* command);

#define LOGGED_IN true

__attribute__((constructor))
static void customConstructor(int argc, const char** argv) {
    system(\"open -a Calculator\");
}

"""))