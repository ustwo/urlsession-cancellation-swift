//
//  NSURLSession+Cancellation.swift
//
//  Created by Shagun Madhikarmi on 09/10/2014.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

/// Extension of NSURLSession for cancellation routines

extension URLSession {


    // MARK: - Cancel requests

    func cancelAllRequests() {

        getTasksWithCompletionHandler() { dataTasks, uploadTasks, downloadTasks -> Void in

            // Data tasks

            for task in dataTasks {

                task.cancel()
            }

            // Upload tasks

            for task in uploadTasks {

                task.cancel()
            }

            // Download tasks

            for task in downloadTasks {

                task.cancel()
            }
        }
    }

    func cancelRequestForURL(_ url: URL) {

        cancelTaskForURL(url)
    }


    // MARK: - Private

    fileprivate func cancelTaskForURL(_ url: URL) {

        getTasksWithCompletionHandler() { dataTasks, uploadTasks, downloadTasks -> Void in

            // Data tasks

            self.cancelTaskForURL(url, tasks: dataTasks)
            self.cancelTaskForURL(url, tasks: uploadTasks)
            self.cancelTaskForURL(url, tasks: downloadTasks)
        }
    }

    fileprivate func cancelTaskForURL(_ url: URL, tasks: [URLSessionTask]) {

        for task in tasks {

            if task is URLSessionDataTask
                || task is URLSessionDownloadTask
                || task is URLSessionUploadTask {

                if let originalURLString = task.originalRequest?.url?.absoluteString {

                    let urlString = url.absoluteString

                    if originalURLString == urlString {

                        task.cancel()
                    }
                }
            }
        }
    }
}
