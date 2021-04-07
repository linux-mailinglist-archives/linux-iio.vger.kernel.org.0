Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B79356C05
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhDGM0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 08:26:02 -0400
Received: from www381.your-server.de ([78.46.137.84]:41832 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352132AbhDGM0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 08:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=04ou5ROVlb0F2yFQTsIx7w86v9JjFRXS1OjW3zfK58I=; b=U7MJcYdBxPYUjl2clBGKMztWoh
        GoR3SCg6RZEkKt+NCuKK+Vq5czE+lsVVrIQBoOQR4RIo9YTd8HchlDcEqg0KLsMHX2yb+Mn1hvw8C
        pTNZQaP5pWwgPXENMSP7StGmfvhN+z4OlH6rBLTRXp/CWr9oon62E7i+gxW1SbSM4JSu6GLF9j5dM
        T1eKOKVUpFjEc4tD2udFgUAkqBK8TOZiut1Y2HmMAGziJJwfL4/PNysHT07iDHjkX9/1QwUG1xOUN
        rrtJDYLdsPWhmfeWthDELwLGW+RHK1tw0wg8Xkf8Scx0KSRSRRGEgiBE37j0j3HQwdblJWju7RXGP
        /8YmgUFg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lU7Fl-0004IR-HW; Wed, 07 Apr 2021 14:25:49 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lU7Fl-000WVG-Ct; Wed, 07 Apr 2021 14:25:49 +0200
Subject: Re: [PATCH] iio: adis16480: support burst read function
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
References: <20210406151424.110477-1-nuno.sa@analog.com>
 <b62f72d8-4d9a-dfb6-685c-3e5985aae8c6@metafoo.de>
 <CY4PR03MB3112B5C821F6CF07816A646499759@CY4PR03MB3112.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a1b6e371-dd5b-7010-911b-681f9077fda9@metafoo.de>
Date:   Wed, 7 Apr 2021 14:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR03MB3112B5C821F6CF07816A646499759@CY4PR03MB3112.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26133/Wed Apr  7 13:09:03 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/7/21 1:31 PM, Sa, Nuno wrote:
>> From: Lars-Peter Clausen <lars@metafoo.de>
>> Sent: Wednesday, April 7, 2021 10:25 AM
>> To: Sa, Nuno <Nuno.Sa@analog.com>; linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron <jic23@kernel.org>; Hennerich, Michael
>> <Michael.Hennerich@analog.com>
>> Subject: Re: [PATCH] iio: adis16480: support burst read function
>>
>> [External]
>>
>> On 4/6/21 5:14 PM, Nuno Sa wrote:
>>> Some supported devices support burst read function. This provides a
>> method
>>> for reading a batch of data (status, temperature, gyroscopes,
>>> accelerometers, time stamp/data counter, and CRC code), which
>> does not
>>> require a stall time between each 16-bit segment and only requires
>> one
>>> command on the DIN line to initiate. Devices supporting this mode
>>> are:
>>>
>>>     * adis16495-1
>>>     * adis16495-2
>>>     * adis16495-3
>>>     * adis16497-1
>>>     * adis16497-2
>>>     * adis16497-3
>>>
>>> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>> Looks good to me, just some thoughts on CRC and endiness
>> conversion.
>>
>>> ---
>>>    drivers/iio/imu/adis16480.c | 157
>> +++++++++++++++++++++++++++++++++---
>>>    1 file changed, 144 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
>>> index f81b86690b76..341945f8339e 100644
>>> --- a/drivers/iio/imu/adis16480.c
>>> +++ b/drivers/iio/imu/adis16480.c
>>> @@ -5,6 +5,7 @@
>>>     * Copyright 2012 Analog Devices Inc.
>>>     */
>>>
>>> [...]
>>> +static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem,
>> const u32 crc)
>> const __be16 *buf
>>> +{
>>> +	u32 crc_calc;
>>> +	u16 crc_buf[15];
>>> +	int j;
>>> +
>>> +	for (j = 0; j < n_elem; j++)
>>> +		crc_buf[j] = swab16(buf[j]);
>> be16_to_cpu(buf[j])
> I don't think this would work on BE machines. AFAIU, the crc computation
> must be done in little endian ("order of bytes low-high"). In BE machines,
> crc_buf would be left in BE order which would lead to a wrong crc...
> The ' swab16()' was really intentional here (naturally can still be wrong :D)
Yea, that makes sense. crc32() processes byte wise and in the byte 
buffer we have MSB,LSB,MSB,LSB... and we want to process LSB,MSB,LSB,MSB....
