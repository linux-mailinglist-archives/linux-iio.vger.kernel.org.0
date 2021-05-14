Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4B38038C
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhENGOW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 02:14:22 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:52738 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhENGOV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 02:14:21 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4609e14d7a18-42687; Fri, 14 May 2021 14:12:42 +0800 (CST)
X-RM-TRANSID: 2ee4609e14d7a18-42687
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6609e14cfa0a-0acc3;
        Fri, 14 May 2021 14:12:41 +0800 (CST)
X-RM-TRANSID: 2ee6609e14cfa0a-0acc3
Subject: Re: [PATCH] iio:adc:ad7766: Fix unnecessary check in ad7766_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210511134739.948-1-tangbin@cmss.chinamobile.com>
 <20210513170334.479953d3@jic23-huawei>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <05486432-25ab-0e48-c31b-148049a80732@cmss.chinamobile.com>
Date:   Fri, 14 May 2021 14:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210513170334.479953d3@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan:

On 2021/5/14 0:03, Jonathan Cameron wrote:
> On Tue, 11 May 2021 21:47:39 +0800
> Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
>> In the function ad7766_probe(), the return value of
>> devm_iio_device_register() can be zero or ret, Thus it
>> is unnecessary to repeated check here.
>>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Hi Tang Bin,
>
> A quick query on this sign off sequence as I'd like to check what the
> intended meaning is.
>
> If you both developed this patch, please use the Co-developed-by: tag
> to indicate that.   If Zhang Shengju wrote the patch then you sent it
> upstream, please fix the 'from' field on the email to reflect that.
>
> Patch itself is good.

Thanks for your reply, it's my mistake, this place should use:

     Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Thanks

Tang Bin


> Thanks,
>
> Jonathan
>
>> ---
>>   drivers/iio/adc/ad7766.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
>> index b6b6765be..acf56e987 100644
>> --- a/drivers/iio/adc/ad7766.c
>> +++ b/drivers/iio/adc/ad7766.c
>> @@ -291,10 +291,7 @@ static int ad7766_probe(struct spi_device *spi)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
>> -	if (ret)
>> -		return ret;
>> -	return 0;
>> +	return devm_iio_device_register(&spi->dev, indio_dev);
>>   }
>>   
>>   static const struct spi_device_id ad7766_id[] = {


