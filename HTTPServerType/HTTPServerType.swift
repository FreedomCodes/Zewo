// HTTPServerType.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Otherside
import Curvature

public protocol HTTPServerType {
    var server: TCPServerType { get }
    var parser: HTTPRequestParserType { get }
    var responder: HTTPResponderType { get }
    var serializer: HTTPResponseSerializerType  { get }
}

extension HTTPServerType {
    public func start(failure failure: ErrorType -> Void = Self.defaultFailureHandler) {
        server.acceptClient { client, error in
            if let error = error {
                failure(error)
            } else if let client = client {
                self.parser.parseRequest(client) { request, error in
                    if let error = error {
                        failure(error)
                        client.close()
                    } else if let request = request {
                        let response = self.responder.respond(request)
                        self.serializer.serializeResponse(client, response: response) { error in
                            if let error = error {
                                failure(error)
                                client.close()
                            } else {
                                if !request.keepAlive {
                                    client.close()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public func stop() {
        server.stop()
    }

    private static func defaultFailureHandler(error: ErrorType) -> Void {
        print("Error: \(error)")
    }
}