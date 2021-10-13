Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861D142CAA8
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJMUJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 16:09:33 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:56570 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhJMUJc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 16:09:32 -0400
Received: from [192.168.1.18] ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id akX7mo550TdRTakX8mpqgx; Wed, 13 Oct 2021 22:07:26 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 13 Oct 2021 22:07:26 +0200
X-ME-IP: 92.140.161.106
Subject: Re: [PATCH v3] iio: adc128s052: Simplify 'adc128_probe()'
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, ardeleanalex@gmail.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <4fa7fcc59c40e27af0569138d656c698a53dbd44.1630002770.git.christophe.jaillet@wanadoo.fr>
 <20210829181612.0b366561@jic23-huawei>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <a9e71dfa-8ecc-aa0d-7e02-bcc6003ae896@wanadoo.fr>
Date:   Wed, 13 Oct 2021 22:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829181612.0b366561@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 29/08/2021 à 19:16, Jonathan Cameron a écrit :
> On Thu, 26 Aug 2021 20:36:22 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>> Turn 'adc128_probe()' into a full resource managed function to simplify the
>> code.
>>
>> This way, the .remove function can be removed.
>> Doing so, the only 'spi_get_drvdata()' call is removed and the
>> corresponding 'spi_set_drvdata()' can be removed as well.
>>
>> Suggested-by: Alexandru Ardelean <ardeleanalex@gmail.com>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Looks good to me, but as mentioned this will need to wait for the
> fix to go upstream.
> 
> Give me a poke if I seem to have lost it once that's true.

Hi,

looks like it's fine now. So this is a gentle reminder :)
The fix is in -next (see [1])

CJ

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/iio/adc/ti-adc128s052.c

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>> Compile tested only.
>>
>> When reviewing, pay special attention to the 'spi_set_drvdata()' call
>> removal. I recently introduced a regression with a too aggressive cleanup
>> like that.
>>
>> This patch should be applied after
>> https://lore.kernel.org/linux-iio/f33069f0-601b-4bbb-3766-026f7a161912-39ZsbGIQGT5GWvitb5QawA@public.gmane.org/T/#meb792dcd6540f87d9ae041660ca4738a776e924a
>>
>> v1 --> v2: just garbage --> ignore
>> v1 --> v3: Simplify 'adc128_disable_regulator()'
>> ---
>>   drivers/iio/adc/ti-adc128s052.c | 26 +++++++++-----------------
>>   1 file changed, 9 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>> index 3143f35a6509..ce0cfe40b219 100644
>> --- a/drivers/iio/adc/ti-adc128s052.c
>> +++ b/drivers/iio/adc/ti-adc128s052.c
>> @@ -132,6 +132,11 @@ static const struct iio_info adc128_info = {
>>   	.read_raw = adc128_read_raw,
>>   };
>>   
>> +static void adc128_disable_regulator(void *reg)
>> +{
>> +	regulator_disable(reg);
>> +}
>> +
>>   static int adc128_probe(struct spi_device *spi)
>>   {
>>   	struct iio_dev *indio_dev;
>> @@ -151,8 +156,6 @@ static int adc128_probe(struct spi_device *spi)
>>   	adc = iio_priv(indio_dev);
>>   	adc->spi = spi;
>>   
>> -	spi_set_drvdata(spi, indio_dev);
>> -
>>   	indio_dev->name = spi_get_device_id(spi)->name;
>>   	indio_dev->modes = INDIO_DIRECT_MODE;
>>   	indio_dev->info = &adc128_info;
>> @@ -167,23 +170,13 @@ static int adc128_probe(struct spi_device *spi)
>>   	ret = regulator_enable(adc->reg);
>>   	if (ret < 0)
>>   		return ret;
>> +	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
>> +	if (ret)
>> +		return ret;
>>   
>>   	mutex_init(&adc->lock);
>>   
>> -	ret = iio_device_register(indio_dev);
>> -
>> -	return ret;
>> -}
>> -
>> -static int adc128_remove(struct spi_device *spi)
>> -{
>> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> -	struct adc128 *adc = iio_priv(indio_dev);
>> -
>> -	iio_device_unregister(indio_dev);
>> -	regulator_disable(adc->reg);
>> -
>> -	return 0;
>> +	return devm_iio_device_register(&spi->dev, indio_dev);
>>   }
>>   
>>   static const struct of_device_id adc128_of_match[] = {
>> @@ -225,7 +218,6 @@ static struct spi_driver adc128_driver = {
>>   		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
>>   	},
>>   	.probe = adc128_probe,
>> -	.remove = adc128_remove,
>>   	.id_table = adc128_id,
>>   };
>>   module_spi_driver(adc128_driver);
> 
> 

