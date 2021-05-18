Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66891387033
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhERDUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 23:20:48 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:18400 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbhERDUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 23:20:47 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee960a33235e2b-83e46; Tue, 18 May 2021 11:19:17 +0800 (CST)
X-RM-TRANSID: 2ee960a33235e2b-83e46
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee360a3322856b-9c9e4;
        Tue, 18 May 2021 11:19:17 +0800 (CST)
X-RM-TRANSID: 2ee360a3322856b-9c9e4
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Fix unnecessary check
 andassignment in ad7746_probe()
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lucas.p.stankus@gmail.com
References: <20210517150006.8436-1-tangbin@cmss.chinamobile.com>
 <YKLqtc8cowOxUTid@smtp.gmail.com>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <5dc07171-f2ce-0a73-205f-603a520306f1@cmss.chinamobile.com>
Date:   Tue, 18 May 2021 11:19:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YKLqtc8cowOxUTid@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Marcelo:

On 2021/5/18 6:14, Marcelo Schmitt wrote:
> Hi Tang,
>
> The patch looks overall good, though I think it could be split into two
> pieces: one for simplifying ret declaration and another for removing the
> check after device register.
> Despite that, I guess Lucas might already be working on similar changes.
> https://lore.kernel.org/linux-iio/cover.1620766020.git.lucas.p.stankus@gmail.com/

Thanks for your reply, I really don't know someone has send the similar one.

I forget this patch.


> As general advice, I would recommend avoiding using generic words such
> as fix in the subject line. It's often better to say something about the
> nature of what is being done.

OK, got it!

Thanks

Tang Bin

>
> Cc: lucas.p.stankus@gmail.com
>
>
> Best regards,
>
> Marcelo
>
> On 05/17, Tang Bin wrote:
>> In the function ad7746_probe(), the return value of
>> devm_iio_device_register() can be zero or ret, thus it is
>> unnecessary to repeated check here. And delete unused
>> initialized value of 'ret', because it will be assigned by
>> the function i2c_smbus_write_byte_data().
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>   drivers/staging/iio/cdc/ad7746.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
>> index dfd71e99e..d3b6e68df 100644
>> --- a/drivers/staging/iio/cdc/ad7746.c
>> +++ b/drivers/staging/iio/cdc/ad7746.c
>> @@ -680,7 +680,7 @@ static int ad7746_probe(struct i2c_client *client,
>>   	struct ad7746_chip_info *chip;
>>   	struct iio_dev *indio_dev;
>>   	unsigned char regval = 0;
>> -	int ret = 0;
>> +	int ret;
>>   
>>   	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>>   	if (!indio_dev)
>> @@ -730,11 +730,7 @@ static int ad7746_probe(struct i2c_client *client,
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return 0;
>> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>>   }
>>   
>>   static const struct i2c_device_id ad7746_id[] = {
>> -- 
>> 2.20.1.windows.1
>>
>>
>>


