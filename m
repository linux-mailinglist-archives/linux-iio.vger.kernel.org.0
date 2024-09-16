Return-Path: <linux-iio+bounces-9601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B7979B13
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 08:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E1281C27
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82EB3CF73;
	Mon, 16 Sep 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJzlFqPU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DD1F5F6;
	Mon, 16 Sep 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467569; cv=none; b=iWwBE7ARRQHRIn2Ze+SZ7NL/A07xg97gLYWPxr/LgJ+7OXOa4j+tsSpfjpbEsiXgD0unbhkoBumzjKNK8Zifc0uymH8tmENntKGiPb0GVNXhz9bmAuOwTyLzcHFHmxR+mFzv48ofoMFsqiX0GEwpuzil41OB8oSg8n1PnhjVpDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467569; c=relaxed/simple;
	bh=pP48Vv721DQSlgKYtMiIq70OYZvh5Dgy/Y36z5kxpa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkJNlYPBOMYV6c5QRhTn99Ix2sejnI1+wxECnPR0JGVtChq/rZe43xvZKpa68XFEbrsqKo8kAyI/HqOw57fvlxmfuwcNkg2Puk5suUG/mov7NJ9qkksHUCszvCWj8pkH8nXRpEcm0H8y5pSKugcSQ0MjqmUSw6tkwE2JYmoZS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJzlFqPU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso736074366b.1;
        Sun, 15 Sep 2024 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726467566; x=1727072366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vD0nTmWMdSzwNQvkoTUB1WjrHQU7c/gU3YlpKeXgZJE=;
        b=IJzlFqPUm+vIqv7fVdDElxr/AUpp9Ubz3lOVvD1nuPFbf8ltWgiy1AtQh0k6oCzjuK
         rXVe/O4aSMN+/Y3e5VGkwjp4BXPdpu4dYZ20M0RdED+w+6maANAlmsz91pXC2U4aG416
         jr3J5tS0uAdYVhiwoXvG6bRmeD2LVBiYyx42A5KID5nsgDJM+MIoVpWWvPyZaazTJFxY
         w04nTeqpCqn8YhqR7vROgLzBLshi6QboZG4XmwsGR3TWMQAjWO+YpHIDVnJdQFl+SSAL
         kZGlFQ45es/0rNFJK1T0LtCcL9A6DhezFaX49e5kf0B/IGjmD6/335QZEWTdp0sV9Qmk
         Tf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726467566; x=1727072366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD0nTmWMdSzwNQvkoTUB1WjrHQU7c/gU3YlpKeXgZJE=;
        b=rbDaZfuQZsgZP8BFw7yuOn1I9+YZARRAIw1xiiwky0R9hj016W828a9NiUjw9FiAYU
         NsPds/LNRkzl5lyNN3liEPNQkVXvJVjJXAkUFOxKBcGdK5b1W+TkBjBAytpseo7nL3Wp
         aMyq271xy2WCzQfkLJ0W9rXCsEq0HnYmjC+/EGGJ/FoDyXlPhE2cZFytudnqDmGaeEIk
         jbugIQtmduWK1eUKKgvKdmzs6VkpLROJVyiQfDSi11sZ56cLW8Py9zp92DbHZDMn4nUZ
         mxgrfeLVJ0/t4LCdfBg6FhEeDCu34gL7FVzqX7C8HtdfThc24sFO+uckvIB7YroPRP4/
         PCYA==
X-Forwarded-Encrypted: i=1; AJvYcCVHziVTaMF0aZN6yPkcWI2X/9+HnWvyvrYpZZk/6owqhj/m1w3E/1Eio1wlu9f1Wh4qPNIknxVriknea9GS@vger.kernel.org, AJvYcCVa0y0uFnJdGHdF192q1DcMWc8HzDDJxOrD1kzLaXvKZVXHjEcw3fxCcwTqG5tTPvwDvVokpGPho5kp@vger.kernel.org, AJvYcCWt7amKnlZlLLRkV7g3UmVSuu0XN0lRJyAODuZseflm3dPoEyyo2u2dnTNXMVE41kVxQbLRr6vg1rYw@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2h/LCA/Rk359hKmkFmI9uVsp0/wBx+vZdOO98OH0AG3/E7Wr
	B/I+q4OoNZQgn4Zi/vES+IQ3OnAz/sB2ccoD5QcZgAWSBtt1K9hU
X-Google-Smtp-Source: AGHT+IH5amVQOMkTRcUhvA2UFfwyNwOd/8AegF0E9EPf1h2wwCiTqx6WSQK6OCz22/U+sQamRX31Dw==
X-Received: by 2002:a17:907:3f26:b0:a87:370:8dfc with SMTP id a640c23a62f3a-a902a47871dmr1474225966b.14.1726467565427;
        Sun, 15 Sep 2024 23:19:25 -0700 (PDT)
Received: from [10.134.2.234] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43f4sm269198566b.80.2024.09.15.23.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 23:19:24 -0700 (PDT)
Message-ID: <e3414f78-417c-4983-a91d-0c58e1639de8@gmail.com>
Date: Mon, 16 Sep 2024 08:19:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iio: light: veml6030: add support for veml6035
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
 <20240913-veml6035-v1-7-0b09c0c90418@gmail.com>
 <20240914170347.54959319@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240914170347.54959319@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/09/2024 18:03, Jonathan Cameron wrote:
> On Fri, 13 Sep 2024 15:19:02 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The veml6035 is an ALS that shares most of its functionality with the
>> veml6030, which allows for some code recycling.
>>
>> Some chip-specific properties differ and dedicated functions to get and
>> set the sensor gain as well as its initialization are required.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Mostly a request to first switch to using read_avail() and the relevant
> bit masks instead of custom attributes.  That will require converting the
> driver to that approach first, but looks straight forward.
> 
>> ---
>>  drivers/iio/light/veml6030.c | 300 +++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 273 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
>> index 2945cc1db599..105f310c4954 100644
>> --- a/drivers/iio/light/veml6030.c
>> +++ b/drivers/iio/light/veml6030.c
>> @@ -1,13 +1,19 @@
>>  // SPDX-License-Identifier: GPL-2.0+
>>  /*
>> - * VEML6030 Ambient Light Sensor
>> + * VEML6030 and VMEL6035 Ambient Light Sensors
>>   *
>>   * Copyright (c) 2019, Rishi Gupta <gupt21@gmail.com>
>>   *
>> + * VEML6030:
>>   * Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf
>>   * Appnote-84367: https://www.vishay.com/docs/84367/designingveml6030.pdf
>> + *
>> + * VEML6035:
>> + * Datasheet: https://www.vishay.com/docs/84889/veml6035.pdf
>> + * Appnote-84944: https://www.vishay.com/docs/84944/designingveml6035.pdf
>>   */
>>  
>> +#include <linux/bitfield.h>
>>  #include <linux/module.h>
>>  #include <linux/i2c.h>
>>  #include <linux/err.h>
>> @@ -38,16 +44,33 @@
>>  #define VEML6030_ALS_INT_EN   BIT(1)
>>  #define VEML6030_ALS_SD       BIT(0)
>>  
>> +#define VEML6035_GAIN_M       GENMASK(12, 10)
>> +#define VEML6035_GAIN         BIT(10)
>> +#define VEML6035_DG           BIT(11)
>> +#define VEML6035_SENS         BIT(12)
>> +#define VEML6035_INT_CHAN     BIT(3)
>> +#define VEML6035_CHAN_EN      BIT(2)
>> +
>> +struct veml603x_chip {
>> +	const char *name;
>> +	const struct iio_info *info;
>> +	const struct iio_info *info_no_irq;
>> +	const char * const in_illuminance_scale_avail;
> 
> For this, better with read_avail() provided and a pointer to an array of
> values + a size element in here.  That way we can get rid of the
> custom attribute handling.  Might end up as similar amount of code, but
> will be simpler to read.
> 
>> +	int (*hw_init)(struct iio_dev *indio_dev);
>> +	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
>> +	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
>> +};
> 
>>  
>>  /* Integration time available in seconds */
>> @@ -63,14 +87,25 @@ static IIO_CONST_ATTR(in_illuminance_integration_time_available,
>>  
>>  /*
>>   * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
>> - * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
>> + * ALS gain x (1/4), 0.5 is ALS gain x (1/2), 1.0 is ALS gain x 1,
>> + * 2.0 is ALS gain x2, and 4.0 is ALS gain x 4.
>>   */
>> -static IIO_CONST_ATTR(in_illuminance_scale_available,
>> +static IIO_CONST_ATTR_NAMED(veml6030_in_illuminance_scale_available,
>> +			    in_illuminance_scale_available,
>>  				"0.125 0.25 1.0 2.0");
>> +static IIO_CONST_ATTR_NAMED(veml6035_in_illuminance_scale_available,
>> +			    in_illuminance_scale_available,
>> +				"0.125 0.25 0.5 1.0 2.0 4.0");
>>  
>>  static struct attribute *veml6030_attributes[] = {
>>  	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
>> -	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
>> +	&iio_const_attr_veml6030_in_illuminance_scale_available.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute *veml6035_attributes[] = {
>> +	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
>> +	&iio_const_attr_veml6035_in_illuminance_scale_available.dev_attr.attr,
> 
> Using get_avail() etc would let you handle these as arrays of numbers rather than
> strings + get rid of the need for any custom attributes. This should be
> a very simple conversion so perhaps worth doing before adding the
> new support.  Then you will have pointers to the value arrays + sizes
> in your chip specific structures that just get looked up directly
> by read_avail()
> 
> 

Hi Jonathan, thanks for your review.

I will update the update the driver to work that way.

>>  	NULL
>>  };
> 
> 
>>  
>> +/*
>> + * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
>> + * channel enabled, ALS channel interrupt, PSM enabled,
>> + * PSM_WAIT = 0.8 s, persistence to 1 x integration time and the
>> + * threshold interrupt disabled by default. First shutdown the sensor,
>> + * update registers and then power on the sensor.
>> + */
>> +static int veml6035_hw_init(struct iio_dev *indio_dev)
>> +{
>> +	int ret, val;
>> +	struct veml6030_data *data = iio_priv(indio_dev);
>> +	struct i2c_client *client = data->client;
>> +
>> +	ret = veml6030_als_shut_down(data);
>> +	if (ret) {
>> +		dev_err(&client->dev, "can't shutdown als %d\n", ret);
>> +		return ret;
> 
> If this is only ever called from probe() (I think that's true?)
> can use return dev_err_probe() for all these error cases.
> Main advantage here being shorter simpler code.
> 

I know, I procrastinated a little bit and I left the dev_err() calls as
they are. But that's easy to update, so I will add a patch for it in v2.
>> +	}
>> +
>> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
>> +			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
>> +	if (ret) {
>> +		dev_err(&client->dev, "can't setup als configs %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
>> +				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
>> +	if (ret) {
>> +		dev_err(&client->dev, "can't setup default PSM %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
>> +	if (ret) {
>> +		dev_err(&client->dev, "can't setup high threshold %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
>> +	if (ret) {
>> +		dev_err(&client->dev, "can't setup low threshold %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = veml6030_als_pwr_on(data);
>> +	if (ret) {
>> +		dev_err(&client->dev, "can't poweron als %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Clear stale interrupt status bits if any during start */
>> +	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev,
>> +			"can't clear als interrupt status %d\n", ret);
>> +		return ret;
> 
> It's true of existing code, but I noticed it here.
> Should we be powering down in this error path?
> 

We could, because this is the only error path where the device is
powered on before the power off action gets registered. On the other
hand, could we not move the call to devm_add_action_or_reset() a few
lines up, so the action gets registered before calling hw_init()?

Powering off the device is just writing a bit, so it would not hurt in
the error paths where the device is already powered off. Then we would
not need an explicit call to power off the device in this error path.

>> +	}
>> +
>> +	/* Cache currently active measurement parameters */
>> +	data->cur_gain = 5;
>> +	data->cur_resolution = 1024;
>> +	data->cur_integration_time = 3;
>> +
>> +	return 0;
>> +}
> 


Best regards,
Javier Carrasco

