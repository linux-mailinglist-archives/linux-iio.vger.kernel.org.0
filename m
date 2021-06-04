Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596AB39AFEB
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 03:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFDBhw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 21:37:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4298 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhFDBhv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jun 2021 21:37:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fx4wk0Km5z1BHjL;
        Fri,  4 Jun 2021 09:31:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:35:54 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:35:50 +0800
Subject: Re: [PATCH -next] iio: frequency: adf4350: disable reg and clk on
 error in adf4350_probe()
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210601142605.3613605-1-yangyingliang@huawei.com>
 <20210603171822.14376c28@jic23-huawei>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <1ebd111a-a34a-5d3b-a807-db8176bd19c8@huawei.com>
Date:   Fri, 4 Jun 2021 09:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210603171822.14376c28@jic23-huawei>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 2021/6/4 0:18, Jonathan Cameron wrote:
> On Tue, 1 Jun 2021 22:26:05 +0800
> Yang Yingliang <yangyingliang@huawei.com> wrote:
>
>> Disable reg and clk when devm_gpiod_get_optional() fails in adf4350_probe().
> Hi.
>
> One small thing. It would be useful if you could check if the bug exists other
> than in next (this one has been their for some time!)  If it does, please
> don't add the -next in the patch title (as basically it makes me not worry
> about reading it for a few days :)
>
> Also, make sure to cc the author of the patch in the fixes tag
> +CC Linus
OK

Thanks,
Yang
>
> Obvious enough fix (I hope) that I've applied it to the fixes-togreg branch of
> iio.git and marked for stable.
>
> Thanks,
>
> Jonathan
>
>> Fixes:4a89d2f47ccd ("iio: adf4350: Convert to use GPIO descriptor")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/iio/frequency/adf4350.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
>> index 1462a6a5bc6d..3d9eba716b69 100644
>> --- a/drivers/iio/frequency/adf4350.c
>> +++ b/drivers/iio/frequency/adf4350.c
>> @@ -563,8 +563,10 @@ static int adf4350_probe(struct spi_device *spi)
>>   
>>   	st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
>>   							GPIOD_IN);
>> -	if (IS_ERR(st->lock_detect_gpiod))
>> -		return PTR_ERR(st->lock_detect_gpiod);
>> +	if (IS_ERR(st->lock_detect_gpiod)) {
>> +		ret = PTR_ERR(st->lock_detect_gpiod);
>> +		goto error_disable_reg;
>> +	}
>>   
>>   	if (pdata->power_up_frequency) {
>>   		ret = adf4350_set_freq(st, pdata->power_up_frequency);
> .
