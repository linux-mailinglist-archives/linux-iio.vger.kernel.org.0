Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3B2BB62B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgKTTyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 14:54:32 -0500
Received: from www381.your-server.de ([78.46.137.84]:40910 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbgKTTyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 14:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=mre8Vjs7PQttVlm9kUOKMsl/ogZ2cyWRc5/cDHZJvY8=; b=NnLs649sHcIbs82Chkmlhn+d+3
        xb8JetvjR5Jj3osXpQvy6vPLs0HoJbIlDTCXCbywppaBD0PfoQvSJS6jejaAQSKKDE0bOv89gTMLU
        FAL5ZcbHzAPA6FIvndHCa/kJzS9ql4iWPZJRztevpbtnMVzDW9kSkovKcCVf1DIZqcjeoCvy3Clut
        1vhwcQbHMmVXZxTIiMrSUX3xmliy+4QgxOgJbr9Cz2+nq0XEOwVxD0XmhLIaYz1JiSEwpCG4aRWus
        eHsQku5U/x2QBSIF2yeqjqKRsicDH/7V/r3MW4J+493UMwnJiWQS3v7fThnCOQ9KTrcWG7Qr7EvvE
        vdDnX3yw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kgCUH-0008Jz-FF; Fri, 20 Nov 2020 20:54:29 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kgCUH-0006jX-9u; Fri, 20 Nov 2020 20:54:29 +0100
Subject: Re: [PATCH] HID: mcp2221: add ADC support
To:     Matt Ranostay <matt.ranostay@konsulko.com>,
        rishi gupta <gupt21@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
References: <20201120030103.36138-1-matt.ranostay@konsulko.com>
 <CALUj-guTNWK9m-bwmkRC3st9VExhFkXPiUevXw_EA9xamR6BYA@mail.gmail.com>
 <CAJCx=gn=jAeYkVtLQ8Ou7P9xRpvSaXpuUk5XWDxMD_HPMTzH+Q@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8151a886-b2db-8d44-eee6-46e8eb300ffb@metafoo.de>
Date:   Fri, 20 Nov 2020 20:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJCx=gn=jAeYkVtLQ8Ou7P9xRpvSaXpuUk5XWDxMD_HPMTzH+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25994/Fri Nov 20 14:09:26 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/20/20 8:17 PM, Matt Ranostay wrote:
> On Fri, Nov 20, 2020 at 5:15 AM rishi gupta <gupt21@gmail.com> wrote:
>> On Fri, Nov 20, 2020 at 8:31 AM Matt Ranostay
>> <matt.ranostay@konsulko.com> wrote:
>>> Add support for the three 10-bit ADC channels registered via
>>> the IIO subsystem.
>>>
>>> Cc: linux-input@vger.kernel.org
>>> Cc: linux-iio@vger.kernel.org
>>> CC: Rishi Gupta <gupt21@gmail.com>
>>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>>> ---
>>>   drivers/hid/Kconfig       |  1 +
>>>   drivers/hid/hid-mcp2221.c | 65 ++++++++++++++++++++++++++++++++++++++-
>>>   2 files changed, 65 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>>> index 05315b434276..4795744d9979 100644
>>> --- a/drivers/hid/Kconfig
>>> +++ b/drivers/hid/Kconfig
>>> @@ -1157,6 +1157,7 @@ config HID_MCP2221
>>>          tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
>>>          depends on USB_HID && I2C
>>>          depends on GPIOLIB
>>> +       depends on IIO
>> I am wondering what will happen on systems which do not enable IIO.
>> This driver can not be used there.
>> Is my understanding correct?
> Actually yeah this should be "select IIO" to avoid that issue.

No, we should not have a individual driver select a framework. This will 
cause all kinds of issues with reverse dependencies.

It might be worth splitting this driver into a MFD driver, then the MFD 
cells could have their own module that depend on the subsystem and if 
not enabled the functionality will not be provided.

- Lars

