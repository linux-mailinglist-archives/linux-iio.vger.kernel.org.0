Return-Path: <linux-iio+bounces-429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC817FA529
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05B3B21235
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4534579;
	Mon, 27 Nov 2023 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYE0RvR9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A592;
	Mon, 27 Nov 2023 07:49:20 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb55001124so3702454b3a.0;
        Mon, 27 Nov 2023 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701100160; x=1701704960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVraQ5x1AlroeiisGiemyiPSQyAwtn5m3q3wzSpg2DA=;
        b=hYE0RvR9M1O82YDxQUrfGMqLaAl44FlCTejkMOhcQ5xZCYNKL81tcqQn31BQN3HjrZ
         6tTqdbnfePQ5ufVeo8nRAKD8Hm1Zf2TDAE4mVjUxcFIEaGXE4WDMQqMhASL3kllz7Vdj
         +uIuL7RK6FT4U7F3fiyIQ4f8zgc2rfOZ6VgnOBcR1zdjLFBbwpCnfY5GE22cfgMsHobs
         /n8bUiEsM3jQAe2NTg7R2TcSgqymkvLf0q8ZyqM1UNYSbzZ7qdIeD+oCeuO4QjS1rGkK
         dCTy+i9Y7ut2+yv3u1BDXDiKjkT3SoUf9GZwibvAAYCcXRywsMS2gYtpHyOvqtrSRsei
         HbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100160; x=1701704960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVraQ5x1AlroeiisGiemyiPSQyAwtn5m3q3wzSpg2DA=;
        b=LGTnAlSARJacmpTKo/f86PEHAgBJx8NSOKcA5ei42AtNSMPI/01MgDxjFExGQMShRY
         jJToZeRt3mXvZLfiC80sDbtZ/cGHWkF39WOpJ8tYL6HEkpjHLGlYhac46ZzUbcbGmRs2
         qIo5UdQktFTYJqgfnMxpu6F+2seXHmSfPrfuB1RZFxTdmtm2JJcsmcyzhbx2q+Bsk9v6
         VJWlqYeH8LfDU6z1TmQdHT6827Rrlu3hM7M+26PSM6Qqhq2ciyT4OxROuB6BMXXkfpit
         uRxWkLNXGGqMgPkU2UbDfDcrj74aUmAX8hF3qGXjXaVUajOaj+P+gWcfLebeiWq8cUJO
         l6kQ==
X-Gm-Message-State: AOJu0YyTrGsC5l7hOEUsdHEs21RVonCalpMjR5inKuxlJgQeP6QUgIxL
	CFmxZiqDgY8KOKQgM+eaVig=
X-Google-Smtp-Source: AGHT+IHguMuvdY34htuBcWtvgmLZwEU9YNFuDK7y1xqDQnfw31S+qDKdA5lEKhUJyHKcjkTZiIyc6A==
X-Received: by 2002:a05:6a20:5482:b0:18c:21aa:6a3f with SMTP id i2-20020a056a20548200b0018c21aa6a3fmr13984345pzk.8.1701100159790;
        Mon, 27 Nov 2023 07:49:19 -0800 (PST)
Received: from ?IPV6:2401:4900:2353:8963:b940:1ac0:2fbc:6b6? ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id s15-20020a63524f000000b0059cc2f1b7basm7745403pgl.11.2023.11.27.07.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:49:19 -0800 (PST)
Message-ID: <f6ced6e9-65d2-4bbc-9792-473465bad547@gmail.com>
Date: Mon, 27 Nov 2023 21:17:25 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: driver for Lite-On ltr390
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231117074554.700970-1-anshulusr@gmail.com>
 <20231117074554.700970-2-anshulusr@gmail.com>
 <20231125140641.08284929@jic23-huawei>
From: Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <20231125140641.08284929@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/23 19:36, Jonathan Cameron wrote:
> On Fri, 17 Nov 2023 13:15:53 +0530
> Anshul Dalal <anshulusr@gmail.com> wrote:
> 
>> Implements driver for the Ambient/UV Light sensor LTR390.
>> The driver exposes two ways of getting sensor readings:
>>   1. Raw UV Counts directly from the sensor
>>   2. The computed UV Index value with a percision of 2 decimal places
>>
>> NOTE: Ambient light sensing has not been implemented yet.
>>
>> Datasheet:
>>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> Make this a formal Datasheet tag, just before the Signed-off-by below

Thanks for pointing it out, I was unaware of the standard formal tags.
Is there any resource that lists out the formal tags that I can refer to.

>>
>> Driver tested on RPi Zero 2W
>>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> Hi Anshul,
> 
> Some comments on this one inline.  Some of these overlap with comments on the
> other drivers you've submitted. Normally I'd moan about sending too many drivers
> at a time, but fair enough given you sent them out over a couple of weeks and just
> happened to hit time when I was travelling.
> 
> My main question in here is why have the two channels - conversion looks linear
> so you should be fine exposing IIO_CHAN_INFO_RAW + IIO_CHAN_INFO_SCALE on a
> single channel and leaving userspace to do the maths.
> 
> Jonathan

This driver was my first time working with the IIO subsystem and wasn't
sure about the correct way to use the channels. This should be fixed in
the next revision with the UV index being reported in the following channel:

static const struct iio_chan_spec ltr390_channel = {
	.type = IIO_UVINDEX,
	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
};

With data being reported as:

case IIO_CHAN_INFO_RAW:
	ret = ltr390_register_read(data, LTR390_UVS_DATA);
	if (ret < 0)
		return ret;
	*val = ret;
	return IIO_VAL_INT;
case IIO_CHAN_INFO_SCALE:
	*val = LTR390_WINDOW_FACTOR;
	*val2 = LTR390_COUNTS_PER_UVI;
	return IIO_VAL_FRACTIONAL;

>> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
>> new file mode 100644
>> index 000000000000..67ca028ce828
>> --- /dev/null
>> +++ b/drivers/iio/light/ltr390.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * IIO driver for Lite-On LTR390 ALS and UV sensor
>> + * (7-bit I2C slave address 0x53)
>> + *
>> + * Based on the work of:
>> + *   Shreeya Patel and Shi Zhigang (LTRF216 Driver)
>> + *
>> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
>> + *
>> + * Datasheet:
>> + *   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
>> + *
>> + * TODO:
>> + *   - Support for configurable gain and resolution
> 
> Not using PROCESSED will help with this, so I'd drop that even in this initial
> driver.
>>> + *   - Sensor suspend/resume support
>> + *   - Add support for reading the ALS
>> + *   - Interrupt support
> 
>> + */
>> +
>> +#include <asm/unaligned.h>
> 
> Put this in a block of includes after the linux ones.
> 
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/math.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/regmap.h>
>> +
>> +#define LTR390_DEVICE_NAME	    "ltr390"
>> +
>> +#define LTR390_MAIN_CTRL	    0x00
>> +#define LTR390_PART_ID		    0x06
>> +#define LTR390_UVS_DATA		    0x10
>> +
>> +#define LTR390_SW_RESET		    BIT(4)
>> +#define LTR390_UVS_MODE		    BIT(3)
>> +#define LTR390_SENSOR_ENABLE	    BIT(1)
>> +
>> +#define LTR390_PART_NUMBER_ID	    0xb
>> +#define LTR390_FRACTIONAL_PERCISION 100
>> +
>> +/*
>> + * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
>> + * the sensor are equal to 1 UV Index [Datasheet Page#8].
>> + *
>> + * For the default resolution of 18-bit (integration time: 100ms) and default
>> + * gain of 3x, the counts/uvi are calculated as follows:
>> + * 2300 / ((3/18) * (100/400)) = 95.83
>> + */
>> +#define LTR390_COUNTS_PER_UVI 96
>> +
>> +/*
>> + * Window Factor is needed when the device is under Window glass with coated
>> + * tinted ink. This is to compensate for the light loss due to the lower
>> + * transmission rate of the window glass and helps * in calculating lux.
>> + */
>> +#define LTR390_WINDOW_FACTOR 1
>> +
>> +struct ltr390_data {
>> +	struct regmap *regmap;
>> +	struct i2c_client *client;
>> +	struct mutex lock;
> 
> All locks need a comment explaining the scope of data they protect.
> Note that regmap and the i2c bus will have their own locks by default
> so I'm not sure you need one here at all as I'm not seeing read modify write
> cycles or anything like that (I might be missing one though!)

My goal with the mutex was to protect the sysfs though that might be
unnecessary.

>> +};
>> +
>> +static const struct regmap_config ltr390_regmap_config = {
>> +	.name = LTR390_DEVICE_NAME,
>> +	.reg_bits = 8,
>> +	.reg_stride = 1,
>> +	.val_bits = 8,
>> +};
>> +
>> +static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>> +{
>> +	struct device *dev = &data->client->dev;
>> +	int ret;
>> +	u8 recieve_buffer[3];
>> +
>> +	mutex_lock(&data->lock);
> 
> guard(mutex)(&data->lock); 
> here then you can just return directly without worrying about manual
> unlocking of the mutex.  This stuff is fairly new in the kernel but very
> useful for cases like this!  I have a set of driver cleanup that I'll send
> out that does this in a few IIO drivers, once I've caught up with reviews etc.
> 
> This isn't a critical path where we have to care that we will then unlock
> after the maths to extract value in the final line of the function.
> 
>> +
>> +	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
>> +			       sizeof(recieve_buffer));
>> +	if (ret) {
>> +		dev_err(dev, "failed to read measurement data: %d\n", ret);
>> +		mutex_unlock(&data->lock);
>> +		return ret;
>> +	}
>> +
>> +	mutex_unlock(&data->lock);
>> +	return get_unaligned_le24(recieve_buffer);
>> +}
>> +
>> +static int ltr390_get_uv_index(struct ltr390_data *data)
>> +{
>> +	int ret;
>> +	int uv_index;
>> +
>> +	ret = ltr390_register_read(data, LTR390_UVS_DATA);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	uv_index = DIV_ROUND_CLOSEST(ret * LTR390_FRACTIONAL_PERCISION *
>> +					     LTR390_WINDOW_FACTOR,
>> +				     LTR390_COUNTS_PER_UVI);
> 
> This looks like a linear conversion.  Perhaps make it a userspace problem
> as division much easier in userspace where floating point is available.
> 
>> +
>> +	return uv_index;
>> +}
>> +
> 
>> +
>> +static const struct iio_chan_spec ltr390_channels[] = {
>> +	{
>> +		.type = IIO_UVINDEX,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
>> +	},
>> +	{
>> +		.type = IIO_INTENSITY,
>> +		.channel2 = IIO_MOD_LIGHT_UV,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
>> +	},
>> +};
>> +
>> +static int ltr390_probe(struct i2c_client *client)
>> +{
>> +	struct ltr390_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret, part_number;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> There are quite a few &client->dev in here. I'd introduce
> struct device *dev = &client->dev;
> as a local variable then use that to shorten all those lines a little.
> 
>> +				     "regmap initialization failed\n");
>> +
>> +	data->client = client;
>> +	i2c_set_clientdata(client, indio_dev);
> 
> Why set this? I don' think you are using it.
> 

It seems to be necessary for regmap to work properly, I tested without
it and I get an EREMOTEIO(121) when reading the part id.

>> [..]

Thanks for the review,
Best regards,
Anshul

