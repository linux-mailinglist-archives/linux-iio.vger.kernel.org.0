Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF47B3804C6
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 10:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhENIBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 04:01:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhENIB3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 04:01:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhLV71g4Gz1BM6S;
        Fri, 14 May 2021 15:57:35 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 16:00:14 +0800
Subject: Re: [PATCH -next] iio: adc: ad7793: Add missing error code in
 ad7793_setup()
To:     Lars-Peter Clausen <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <gregkh@suse.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210514065431.4328-1-yuehaibing@huawei.com>
 <fb7f5595-5e70-98a1-220a-935f899773c6@metafoo.de>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <8c670bdb-2ee9-a5c3-972e-e488d12d7980@huawei.com>
Date:   Fri, 14 May 2021 16:00:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fb7f5595-5e70-98a1-220a-935f899773c6@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/5/14 15:36, Lars-Peter Clausen wrote:
> On 5/14/21 8:54 AM, YueHaibing wrote:
>> Set error code while device ID query failed.
>>
>> Fixes: 88bc30548aae ("IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Hi,
> 
> Thanks for finding and fixing this. One small comment.
> 
> 
>> ---
>>   drivers/iio/adc/ad7793.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
>> index 5e980a06258e..b4f9ac3838e1 100644
>> --- a/drivers/iio/adc/ad7793.c
>> +++ b/drivers/iio/adc/ad7793.c
>> @@ -279,6 +279,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>>       id &= AD7793_ID_MASK;
>>         if (id != st->chip_info->id) {
>> +        ret = -EINVAL;
> Usually we use ENODEV as the error code when the device ID does not match.

Thanks, will send v2.

>>           dev_err(&st->sd.spi->dev, "device ID query failed\n");
>>           goto out;
>>       }
> 
> 
> .
