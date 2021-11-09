Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220FD44B0A4
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 16:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhKIPuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 10:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbhKIPuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 10:50:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62578C061764;
        Tue,  9 Nov 2021 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mSVVJsEPHfSX6uPc9s53Oo/i0doUlHhdoN2OWqWwSK0=; b=JgwTX63ZqgXw6GuYY967TBSZ9z
        cDRqSZQWrf1zi86tdd+G+5tfJner6dwxITwfHdp154USoM2VVC//P+ese5y0gV4LIsjjtW823f6uZ
        2TCUkaVZzfF+fuPlNWkZLbN7bNnhnCmhlEGSOQUQHMO6hMHVEgduhGaTzgcbAuAUsC2m0AMH7LwaG
        3iRUgPLPkut6Op2Qnb8rM7ncxPHqzz5eWQ03c2vAb+NCQMU0O6dCMpQhwvYep0jMLM7EWKGDP3nD8
        ijOzZvbVQWi/NaOVT6vSiEQ1PnPJR/M4Od/pTDeua0NLzQIAhwsozEeDtY7xzSvrWFsyhd8H5jbgi
        lEOS28OQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkTLk-008nwL-E2; Tue, 09 Nov 2021 15:47:52 +0000
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
To:     andrea.merello@gmail.com, "joe@perches.com" <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
 <20211028101840.24632-11-andrea.merello@gmail.com>
 <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
 <CAN8YU5NiKz2JiNr-47OC4==N8L67HDshuH45BifnHBae+GUU-g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <021c6fe0-8131-a4f9-9cb0-2f4771d35da1@infradead.org>
Date:   Tue, 9 Nov 2021 07:47:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAN8YU5NiKz2JiNr-47OC4==N8L67HDshuH45BifnHBae+GUU-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/9/21 3:56 AM, Andrea Merello wrote:
> Il giorno ven 29 ott 2021 alle ore 00:04 Randy Dunlap
> <rdunlap@infradead.org> ha scritto:
>>
>> On 10/28/21 3:18 AM, Andrea Merello wrote:
>>> This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
>>> and it enables the BNO055 core driver to work in this scenario.
>>>
>>> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
>>> ---
>>>    drivers/iio/imu/bno055/Kconfig      |  6 ++++
>>>    drivers/iio/imu/bno055/Makefile     |  1 +
>>>    drivers/iio/imu/bno055/bno055_i2c.c | 54 +++++++++++++++++++++++++++++
>>>    3 files changed, 61 insertions(+)
>>>    create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
>>>
>>> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
>>> index 941e43f0368d..87200787d548 100644
>>> --- a/drivers/iio/imu/bno055/Kconfig
>>> +++ b/drivers/iio/imu/bno055/Kconfig
>>> @@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
>>>        tristate "Bosh BNO055 attached via serial bus"
>>>        depends on SERIAL_DEV_BUS
>>>        select BOSH_BNO055_IIO
>>> +
>>> +config BOSH_BNO055_I2C
>>> +     tristate "Bosh BNO055 attached via I2C bus"
>>> +     depends on I2C
>>> +     select REGMAP_I2C
>>> +     select BOSH_BNO055_IIO
>>
>> Hi,
>>
>> The config entries that have user prompt strings should also
>> have help text.  scripts/checkpatch.pl should have told you
>> about that...
> 
> I'll add it, thanks. But FYI checkpatch doesn't complain about that here.

Hm, thanks for adding it and telling me about that.

checkpatch.pl does have some code for checking that but I confirmed
that it does not catch this simple case.

Joe, can you identify why checkpatch does not detect missing Kconfig
help text is this simple case?

Thanks.
-- 
~Randy
