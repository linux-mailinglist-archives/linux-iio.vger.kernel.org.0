Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF03F9C95
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhH0Qf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Aug 2021 12:35:28 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:34957 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229675AbhH0Qf1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Aug 2021 12:35:27 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d74 with ME
        id mgaY2500Q3riaq203gaZQx; Fri, 27 Aug 2021 18:34:37 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 27 Aug 2021 18:34:37 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH v2] iio: adc128s052: Simplify 'adc128_probe()'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jic23@kernel.org, lars@metafoo.de, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <d769321da74eea17a1260b48d4ab16f416b37c74.1630002390.git.christophe.jaillet@wanadoo.fr>
 <20210827073536.GD1931@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <9bd1b2a1-1d86-3907-e62b-f1ecc2dc9995@wanadoo.fr>
Date:   Fri, 27 Aug 2021 18:34:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827073536.GD1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 27/08/2021 à 09:35, Dan Carpenter a écrit :
> On Thu, Aug 26, 2021 at 08:28:08PM +0200, Christophe JAILLET wrote:
>> @@ -172,13 +167,23 @@ static int adc128_probe(struct spi_device *spi)
>>   	ret = regulator_enable(adc->reg);
>>   	if (ret < 0)
>>   		return ret;
>> -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
>> -	if (ret)
>> -		return ret;
>>   
>>   	mutex_init(&adc->lock);
>>   
>> -	return devm_iio_device_register(&spi->dev, indio_dev);
>> +	ret = iio_device_register(indio_dev);
>> +
>> +	return ret;
> 
> Since you're resending anyway then please do:
> 
> 	return iio_device_register(indio_dev);
> 
> regards,
> dan carpenter
> 
> 

Hi Dan,
This v2 should not be taken into account.
I've sent a v3 just after which already implements what you propose.

Other comments on this v3 are welcome.

CJ
