Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21AE9B6D8
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfHWTNl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 15:13:41 -0400
Received: from www381.your-server.de ([78.46.137.84]:46350 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfHWTNl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Aug 2019 15:13:41 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1i1F0F-00054f-BB; Fri, 23 Aug 2019 21:13:39 +0200
Received: from [93.104.105.227] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1i1F0F-000FBY-4y; Fri, 23 Aug 2019 21:13:39 +0200
Subject: Re: buffer read
To:     "Grim, Dennis" <Dennis.Grim@teejet.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <DM5PR19MB1657B9E3EE28C387B09DB1889EA40@DM5PR19MB1657.namprd19.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2cf1675b-4a70-7296-d3dc-3ea99254f6e4@metafoo.de>
Date:   Fri, 23 Aug 2019 21:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DM5PR19MB1657B9E3EE28C387B09DB1889EA40@DM5PR19MB1657.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25550/Fri Aug 23 10:25:33 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/23/19 8:43 PM, Grim, Dennis wrote:
> On Linux 2.6.0, the read() in the following code does not block when the buffer is empty.
> 
> char data[1026];
> int fd = open("/dev/iio:device0", O_RDONLY);
> size_t count = read(fd, data, 1026);
> 
> count is 0.
> 
> Data pushed to the buffer with iio_push_to_buffers() does read correctly (after a trigger).
> 
> What might I be missing?


Hi,

Are you sure about the version number?

Anyway, in earlier versions of Linux IIO was always non-blocking. You
can use the poll() or select() API to wait for data to arrive before
issuing the read() command.

Also make sure that the buffer is enabled in userspace if it is disabled
data sent by iio_push_to_buffers() will be discarded.

Support for blocking IO was added for v3.14 in 2013.

- Lars
