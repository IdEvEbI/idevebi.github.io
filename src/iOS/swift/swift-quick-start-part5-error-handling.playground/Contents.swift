import Foundation

// 定义错误类型
enum FileError: Error {
    case fileNotFound
    case unreadable
    case encodingFailed
}

// 定义文件读取函数
func readFile(at path: String) throws -> String {
    let fileManager = FileManager.default
    guard fileManager.fileExists(atPath: path) else {
        throw FileError.fileNotFound
    }
    
    guard let content = fileManager.contents(atPath: path),
          let contentString = String(data: content, encoding: .utf8) else {
        throw FileError.unreadable
    }
    
    return contentString
}

// 定义文件处理器类
class FileProcessor {
    func processFile(at path: String) {
        do {
            let content = try readFile(at: path)
            print("文件内容：\n\(content)")
        } catch FileError.fileNotFound {
            print("错误：文件未找到。")
        } catch FileError.unreadable {
            print("错误：文件不可读。")
        } catch FileError.encodingFailed {
            print("错误：文件编码失败。")
        } catch {
            print("未知错误：\(error)")
        }
    }
}

// 测试文件处理器
let processor = FileProcessor()
processor.processFile(at: Bundle.main.path(forResource: "Info", ofType: "plist") ?? "")
