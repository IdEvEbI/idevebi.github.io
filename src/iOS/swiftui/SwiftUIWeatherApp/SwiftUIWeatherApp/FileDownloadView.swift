//
//  FileDownloadView.swift
//  SwiftUIWeatherApp
//
//  Created by 黑马程序员 on 2024/7/10.
//

import SwiftUI
import Alamofire

/// ### 4.2 文件下载
struct FileDownloadView: View {
    @State private var downloadProgress: Double = 0.0
    @State private var downloadResult: String = "等待下载..."
    
    var body: some View {
        VStack {
            Button("下载文件") {
                downloadFile()
            }
            .padding()
            ProgressView(value: downloadProgress)
                .padding()
            Text(downloadResult)
                .padding()
        }
    }
    
    /// 下载文件
    func downloadFile() {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("example.mp4")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download("http://localhost:3000/api/download/example.mp4", 
                    to: destination)
            .downloadProgress { progress in
                DispatchQueue.main.async {
                    downloadProgress = progress.fractionCompleted
                }
            }
            .response { response in
                switch response.result {
                case .success:
                    downloadResult = "下载成功！"
                    if let filePath = response.fileURL?.path {
                        print("文件下载到: \(filePath)")
                        // 在沙盒中检查文件是否存在
                        if FileManager.default.fileExists(atPath: filePath) {
                            print("文件存在")
                        } else {
                            print("文件不存在")
                        }
                    }
                case .failure(let error):
                    downloadResult = "下载失败：\(error.localizedDescription)"
                }
            }
    }
}

#Preview {
    FileDownloadView()
}
