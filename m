Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FD488A44
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiAIPfv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 10:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231642AbiAIPfv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 10:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641742550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OISolA07lAEXu3SciQEzFRjvL1qyK4ZBffrvsGOgRIg=;
        b=MdpIDwtvr5xxsrcDWRJ8tquJnJl2WFEibq5rIQB1UBG5zfCXX2OC/z0c20sH6U5fZUUBVG
        9wVskTO0vmbZSdA6flNQXLraEe1hd6jsnKHjyA7wFsy/kqQQsaVvvpp/SgnvwSKY1EDLsD
        14RLxbhrvtYyEuNtp4ZJj2eNWAjkCv0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-IVjVf-mXOHa_zIPcw9UanQ-1; Sun, 09 Jan 2022 10:35:49 -0500
X-MC-Unique: IVjVf-mXOHa_zIPcw9UanQ-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a056402358a00b003f88b132849so8331321edc.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Jan 2022 07:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OISolA07lAEXu3SciQEzFRjvL1qyK4ZBffrvsGOgRIg=;
        b=a8tKH4Xp8DItNX1xfz/s5w6ctYdkE8+CDLMNQ7NEzAOje9bDzSPaetj/Zo7UW8zXFj
         MNNDbdxrhzmur37/Auu/O+zwS0K/NH4gC4QPRI0h+qUvRZEox4vBAC2Y8ptbJkml8ttw
         8IbklOhhpLo9y4ro92ScI6vlFJS5n613hLEWobmHttHtRJQhmji7UoNMFkRl2yaHfKSA
         8sm9F1bc6bpXxpm/YaRisv54l/oQfiOmzhIVFKM+CwS0v/+e00GYq3qX3GAe8d3QxM/i
         yCa+lqalzQDN6Lsqjjk0OH/tuo867DhZ1TdweX+v5Fx57OeSkzLs4OA1q08C/hQ1GPm7
         SnWA==
X-Gm-Message-State: AOAM5308jQJwJEf3KQIlbqIVvGZiNhICqN3OpIROpbeIkxJCIrlGAdoC
        YgYuAi1cNla7py8zaOTsEdL5SalXymMERLmW8mSKFg58GWo8NHPZsjgxjDrwEZMJfut/l6Ody3+
        H6BC7daegXFuzZ1q5oA3J
X-Received: by 2002:a50:9e0f:: with SMTP id z15mr71006255ede.278.1641742547676;
        Sun, 09 Jan 2022 07:35:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6+Ut8MXcM0LruUmoqR94sTrSyh9cNfhPFikVL/IpCxhbteEcX5XFcoKeEVZ+Q/l5xFYhssg==
X-Received: by 2002:a50:9e0f:: with SMTP id z15mr71006246ede.278.1641742547530;
        Sun, 09 Jan 2022 07:35:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id gb17sm797986ejc.25.2022.01.09.07.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 07:35:47 -0800 (PST)
Message-ID: <25fd03a5-4b85-a112-1897-0a6d662aa88d@redhat.com>
Date:   Sun, 9 Jan 2022 16:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] iio: mma8452: Fix probe failing when an i2c_device_id is
 used
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20220106111414.66421-1-hdegoede@redhat.com>
 <20220109151043.54d92a79@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220109151043.54d92a79@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 1/9/22 16:10, Jonathan Cameron wrote:
> On Thu,  6 Jan 2022 12:14:14 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The mma8452_driver declares both of_match_table and i2c_driver.id_table
>> match-tables, but its probe() function only checked for of matches.
>>
>> Add support for i2c_device_id matches. This fixes the driver not loading
>> on some x86 tablets (e.g. the Nextbook Ares 8) where the i2c_client is
>> instantiated by platform code using an i2c_device_id.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Hi Hans,
> 
> At some point we'll want to get rid of the of_ specific stuff in here in
> favour of generic firmware properties and I suspect at that time we'll
> move the device name into the chip_info_table[] entries so that we
> can just use device_get_match_data()
> 
> In the meantime this fix looks good to me.  Is there an appropriate
> Fixes: tag?

I did a quick dive in the git history and the of_match_device() ||
return -ENODEV behavior was introduced in:

c3cdd6e48e35 ("iio: mma8452: refactor for seperating chip specific data")

Regards,

Hans




>> ---
>>  drivers/iio/accel/mma8452.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 09c7f10fefb6..c82841c0a7b3 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1523,12 +1523,7 @@ static int mma8452_probe(struct i2c_client *client,
>>  	struct iio_dev *indio_dev;
>>  	int ret;
>>  	const struct of_device_id *match;
>> -
>> -	match = of_match_device(mma8452_dt_ids, &client->dev);
>> -	if (!match) {
>> -		dev_err(&client->dev, "unknown device model\n");
>> -		return -ENODEV;
>> -	}
>> +	const char *compatible;
>>  
>>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>  	if (!indio_dev)
>> @@ -1537,7 +1532,19 @@ static int mma8452_probe(struct i2c_client *client,
>>  	data = iio_priv(indio_dev);
>>  	data->client = client;
>>  	mutex_init(&data->lock);
>> -	data->chip_info = match->data;
>> +
>> +	if (id) {
>> +		compatible = id->name;
>> +		data->chip_info = &mma_chip_info_table[id->driver_data];
>> +	} else {
>> +		match = of_match_device(mma8452_dt_ids, &client->dev);
>> +		if (!match) {
>> +			dev_err(&client->dev, "unknown device model\n");
>> +			return -ENODEV;
>> +		}
>> +		compatible = match->compatible;
>> +		data->chip_info = match->data;
>> +	}
>>  
>>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
>>  	if (IS_ERR(data->vdd_reg))
>> @@ -1581,7 +1588,7 @@ static int mma8452_probe(struct i2c_client *client,
>>  	}
>>  
>>  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
>> -		 match->compatible, data->chip_info->chip_id);
>> +		 compatible, data->chip_info->chip_id);
>>  
>>  	i2c_set_clientdata(client, indio_dev);
>>  	indio_dev->info = &mma8452_info;
> 

