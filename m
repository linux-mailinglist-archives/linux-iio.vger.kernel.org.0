Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455E33BE85A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhGGMyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 08:54:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:39826 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhGGMyC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 08:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yJeOhbOJDYkUVgdgU7Itn/JNUArEaxGirBx87wO49EE=; b=lTwgxqtUmUgvE5p5EA+OSsVv+L
        GOMEebq36D7lZw2suu76NOADegKEQ+AbBHBD7JxI7bW9ZwJO36UgqO/o4xiv4M7qaV7zfgSRBHb6d
        1FeEngILPEI4BdGEMENGHbKM8Tn1Hkw30D7CMDimd3gU3icDrx49NXug2UVsy5SUlWh6yy5EIMqb3
        CR78D7gv3aryHWox1/ESfNMV4jmhkg5XL7bTC4pGW34gfHygA6VAESA2qQeX4XPU+JQI+cco0ocYZ
        4SPkU4dNAHPCa1Hd3WRR+1w9eWfHrXg5H0I0O5PA/jqY0Lm2OJ/Wltv3AXRvnvW7uvipXUrOR9t5j
        DgAimuwA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1m16ip-000GIc-AB; Wed, 07 Jul 2021 14:32:11 +0200
Received: from [2001:a61:2b10:2e01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1m16ip-0000Mj-54; Wed, 07 Jul 2021 14:32:11 +0200
Subject: Re: [RESEND PATCH] iio: adis: set GPIO reset pin direction
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     Hannu Hartikainen <hannu@hrtk.in>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
 <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6f2a3147-11df-c85e-849e-f7a9d92a71fd@metafoo.de>
Date:   Wed, 7 Jul 2021 14:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26224/Wed Jul  7 13:08:29 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/7/21 10:36 AM, Sa, Nuno wrote:
>> From: Antti Keränen <detegr@rbx.email>
>> Sent: Tuesday, July 6, 2021 11:29 AM
>> To: linux-iio@vger.kernel.org
>> Cc: Antti Keränen <detegr@rbx.email>; Hannu Hartikainen
>> <hannu@hrtk.in>; Lars-Peter Clausen <lars@metafoo.de>; Hennerich,
>> Michael <Michael.Hennerich@analog.com>; Sa, Nuno
>> <Nuno.Sa@analog.com>; Jonathan Cameron <jic23@kernel.org>
>> Subject: [RESEND PATCH] iio: adis: set GPIO reset pin direction
>>
>> Use GPIOD_OUT_LOW instead of GPIOD_ASIS as the reset pin needs
>> to be an
>> active low output pin.
>>
>> Suggested-by: Hannu Hartikainen <hannu@hrtk.in>
>> Signed-off-by: Antti Keränen <detegr@rbx.email>
>> ---
>> The documentation of GPIO consumer interface states:
>>
>> Be aware that there is no default direction for GPIOs. Therefore,
>> **using a GPIO without setting its direction first is illegal and will
>> result in undefined behavior!**
>>
>> Therefore the direction of the reset GPIO pin should be set as output.
>>
>>   drivers/iio/imu/adis.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
>> index 319b64b2fd88..7f13b3763732 100644
>> --- a/drivers/iio/imu/adis.c
>> +++ b/drivers/iio/imu/adis.c
>> @@ -415,7 +415,7 @@ int __adis_initial_startup(struct adis *adis)
>>   	int ret;
>>
>>   	/* check if the device has rst pin low */
>> -	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset",
>> GPIOD_ASIS);
>> +	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset",
>> GPIOD_OUT_LOW);
>>   	if (IS_ERR(gpio))
>>   		return PTR_ERR(gpio);
>>
> Hi,
>
> Thanks for the patch. Forcing the device reset was intentional
> (thus the GPIO_ASIS). But what Lars is suggesting is a good idea
> and a neat improvement here.
>
GPIO_ASIS leaves the direction of the GPIO untouched. If the default is 
input, the GPIO will stay as an input, in which case triggering the 
reset does not work.


