Return-Path: <linux-iio+bounces-10713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56F9A3BC0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2290EB22193
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E820124A;
	Fri, 18 Oct 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M69HAZkc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDF201112
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248027; cv=none; b=cK6W3qGRSkvgiBikS3USBcF33aNVDURTtN9pp1RuuoHDJZAo8/LNwQkENEwZM/q2A8BKi3YLQsfuLgdR5zaLKU9mjBWIzW34fM12Uy1h6vRPRketr5bGnNkyOl3BjeCMKEBLzQGlM0AG6wYC7EC09qh9HuZIEtYtkFtItUFoJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248027; c=relaxed/simple;
	bh=ZiDcJ9wnDCXHrrn7DaeAQRnjkMiZNOYN4z89khQzNgM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vF9BeCz6do8kKqVPIxOcc0en19u/gjpdJ8DIyZI1EOGCzzy6OW3TFawt8bD3etTnWeOoWUqo8EhXTGdmfmI0P6CauTq7bpBf/iibxYqyqfwm2eiuNmeMDiVUUXlF99NiiKgHZw5U+FRVrD28N5X9lBll4ebm74GGV/WFSuC/VJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M69HAZkc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43163667f0eso3133495e9.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729248023; x=1729852823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OgxwchXgTmvNx1TGKHgI4BeWcd/Kc61iRc8bYZ9ZQg=;
        b=M69HAZkcUwzk36u3q2/fEDfJJDUUA5k8uutnmPR8ABL27UJYghQq0UnBn7OZBb39s7
         +Yuz8k7Gsqum0b0ueFdODgQN6r8G9OXEgZYIfjeZtmgIl0Smnd6d3Dw51U9Y80PATmq9
         HhVLECzRDQsEFhbnaAkavB48BY7aLVS5nNNCtICvjj3UVOu4e5TYyNZT1/e9U2MKsXAC
         u9HMuneB/u1NyAF1m8/o0og1tMmqvz0CbRQhoT+8Ih2dpTR5Q/43oFwQgrR71ryn3pLH
         5UnZhNqWaUBLs7HQXyjoh6tXWhvv9ZQ9QFMiLiz8PvxnmPT4+qwLOfGDuKWzo0Bk80gx
         t3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248023; x=1729852823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OgxwchXgTmvNx1TGKHgI4BeWcd/Kc61iRc8bYZ9ZQg=;
        b=A7E50h035Fybg0W9ddvUS+BnxpKK1d2MA6Swt6GSIsi79rIWiWEk6WwSrsjg06L8Ug
         cYRw/g0SevNwf3vbA4i9I6sJRYnjTiv9laUnsdO9qFDhK07yhupxuC4r2fOBjDoC6Mwp
         RXanxePDZatnaTCTdAHndBfu4OOLKuxRrpaLrtvtFlROXk56ri9lLtssCqEcY1TKH/X4
         uLqyAHVJzTrznODxwM/Uzz0BCEdz+KD8cKXsq9RkdWZLrAhHIwXjJhO0YHam8YMfe1Ct
         W66ZckXEX8CijADQvKm0cLeMkCo0SpC0R00Z1k2Ly8A3fb9YquXu3LverRYRsz2ZQn4B
         +Ilg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+vW3aFYdsV/+Jxro6NnNnNLLA+ZRff6x1pFLNJNeXAWaR1YcaPOqB56kny0PflHZcPGudPCR+yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEX6uKMmU/XT3gBAyzY4dtuLSbLtJja9Hs9QJszjUbebK4pn3j
	LLHs/kFTsngig6UiWe6wK8GADx4A7GdU7d5gHRyf8+aibaHmOiUjNutS+LqjQQ8=
X-Google-Smtp-Source: AGHT+IHL37VEqqVV0qjcGmwDL1yOYIvr3egAHUHuUSiLVwOvBPbCOpqPNpLzwD7WJKWHOi7R1BmaCA==
X-Received: by 2002:adf:fb45:0:b0:37d:4ebe:1646 with SMTP id ffacd0b85a97d-37eab728744mr1332595f8f.48.1729248023062;
        Fri, 18 Oct 2024 03:40:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b623:41fc:e293:c9b1? ([2a01:e0a:982:cbb0:b623:41fc:e293:c9b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0469acsm1583462f8f.25.2024.10.18.03.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:40:22 -0700 (PDT)
Message-ID: <f19cf5b0-39d8-4297-96c5-e00c4f61c8f6@linaro.org>
Date: Fri, 18 Oct 2024 12:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] iio: magnetometer: add Allegro MicroSystems ALS31300
 3-D Linear Hall Effect driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
 <20241007-topic-input-upstream-als31300-v1-3-2c240ea5cb77@linaro.org>
 <20241012155043.48b7a4a9@jic23-huawei>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241012155043.48b7a4a9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/10/2024 16:50, Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 15:14:40 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
>> mainly used for 3D head-on motion sensing applications.
>>
>> The device is configured over I2C, and as part of the Sensor
>> data the temperature core is also provided.
>>
>> While the device provides an IRQ gpio, it depends on a configuration
>> programmed into the internal EEPROM, thus only the default mode
>> is supported and buffered input via trigger is also supported
>> to allow streaming values with the same sensing timestamp.
>>
>> The device can be configured with different sensitivities in factory,
>> but the sensitivity value used to calculate value into the Gauss
>> unit is not available from registers, thus the sensitivity is
>> provided by the compatible/device-id string which is based
>> on the part number as described in the datasheet page 2.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Hi Neil.
> 
> Pretty clean driver. Just a few minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
>> new file mode 100644
>> index 000000000000..123e6a63b516
>> --- /dev/null
>> +++ b/drivers/iio/magnetometer/als31300.c
>> @@ -0,0 +1,459 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Driver for the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
>> + *
>> + * Copyright (c) 2024 Linaro Limited
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +
>> +/*
>> + * The Allegro MicroSystems ALS31300 has an EEPROM space to configure how
>> + * the device works and how the interrupt line behaves,
> 
> behaves.
> 
>> + * we only support the default setup with external trigger
> 
> 	Only the default setup with external trigger is supported.
> etc.

Ack, I'll rephrase that part

> 
>> + *
>> + * Since by default the interrupt line is disable, we don't
>> + * support GPIO interrupt events for now.
>> + *
>> + * It should be possible to adapt the driver to the current
>> + * device setup, but we leave it as a future exercise.
>> + */
>> +
>> +#define ALS31300_EEPROM_CONFIG		0x02
>> +#define ALS31300_EEPROM_INTERRUPT	0x03
>> +#define ALS31300_EEPROM_CUSTOMER_1	0x0d
>> +#define ALS31300_EEPROM_CUSTOMER_2	0x0e
>> +#define ALS31300_EEPROM_CUSTOMER_3	0x0f
>> +#define ALS31300_VOLATILE_MODE		0x27
> 
> Is spelling out volatile needed? Maybe VOL or just V or skip
> it completely as it makes for some long lines?

Yep, there's no formal naming on the datasheet for those so I'll
reduce to _VOL

> 
>> +#define ALS31300_VOLATILE_MODE_LPDCM		GENMASK(6, 4)
>> +#define ALS31300_VOLATILE_MODE_SLEEP		GENMASK(1, 0)
>> +#define ALS31300_VOLATILE_MSB		0x28
>> +#define ALS31300_VOLATILE_MSB_TEMPERATURE	GENMASK(5, 0)
>> +#define ALS31300_VOLATILE_MSB_INTERRUPT		BIT(6)
>> +#define ALS31300_VOLATILE_MSB_NEW_DATA		BIT(7)
>> +#define ALS31300_VOLATILE_MSB_Z_AXIS		GENMASK(15, 8)
>> +#define ALS31300_VOLATILE_MSB_Y_AXIS		GENMASK(23, 16)
>> +#define ALS31300_VOLATILE_MSB_X_AXIS		GENMASK(31, 24)
>> +#define ALS31300_VOLATILE_LSB		0x29
>> +#define ALS31300_VOLATILE_LSB_TEMPERATURE	GENMASK(5, 0)
>> +#define ALS31300_VOLATILE_LSB_HALL_STATUS	GENMASK(7, 7)
>> +#define ALS31300_VOLATILE_LSB_Z_AXIS		GENMASK(11, 8)
>> +#define ALS31300_VOLATILE_LSB_Y_AXIS		GENMASK(15, 12)
>> +#define ALS31300_VOLATILE_LSB_X_AXIS		GENMASK(19, 16)
>> +#define ALS31300_VOLATILE_LSB_INTERRUPT_WRITE	BIT(20)
>> +#define ALS31300_CUSTOMER_ACCESS	0x35
>> +
>> +#define ALS31300_LPDCM_INACTIVE_0_5_MS		0
>> +#define ALS31300_LPDCM_INACTIVE_1_0_MS		1
>> +#define ALS31300_LPDCM_INACTIVE_5_0_MS		2
>> +#define ALS31300_LPDCM_INACTIVE_10_0_MS		3
>> +#define ALS31300_LPDCM_INACTIVE_50_0_MS		4
>> +#define ALS31300_LPDCM_INACTIVE_100_0_MS	5
>> +#define ALS31300_LPDCM_INACTIVE_500_0_MS	6
>> +#define ALS31300_LPDCM_INACTIVE_1000_0_MS	7
> I'd move these up to next to the field def above.
> Can play games with indent to make it clear they are the contents of
> that field.
> 
> #define ALS31300_VOLATILE_MODE_LPDCM		GENMASK(6, 4)
> #define   ALS31300_LPDCM_INACTIVE_0_5_MS	0
> etc

If it's accepted, then I'll do it!

> 
> 
>> +
>> +#define ALS31300_VOLATILE_MODE_ACTIVE_MODE	0
>> +#define ALS31300_VOLATILE_MODE_SLEEP_MODE	1
>> +#define ALS31300_VOLATILE_MODE_LPDCM_MODE	2
>> +
>> +#define ALS31300_DATA_X_GET(__buf)			\
> 
> Why __buf?  I'd just use b

Right

> 
>> +		((int)(s8)FIELD_GET(ALS31300_VOLATILE_MSB_X_AXIS, __buf[0]) << 4 | \
>> +			  FIELD_GET(ALS31300_VOLATILE_LSB_X_AXIS, __buf[1]))
>> +#define ALS31300_DATA_Y_GET(__buf)			\
>> +		((int)(s8)FIELD_GET(ALS31300_VOLATILE_MSB_Y_AXIS, __buf[0]) << 4 | \
>> +			  FIELD_GET(ALS31300_VOLATILE_LSB_Y_AXIS, __buf[1]))
>> +#define ALS31300_DATA_Z_GET(__buf)			\
>> +		((int)(s8)FIELD_GET(ALS31300_VOLATILE_MSB_Z_AXIS, __buf[0]) << 4 | \
>> +			  FIELD_GET(ALS31300_VOLATILE_LSB_Z_AXIS, __buf[1]))
> 
> Nice way to make these more readable is sign_extend32() rather than the casts.
> So
> 	sign_extend32(FIELD_GET(ALS31300_VOLATILE_MSB_X_AXIS, b[0]) << 4 |
> 		      FIELD_GET(ALS31300_VOLATILE_LSB_X_AXIS, b[1]),
> 		      11);

Thanks for the suggestion, it's indeed better

> 
> 
>> +#define ALS31300_TEMPERATURE_GET(__buf)			\
>> +		((u32)(u8)FIELD_GET(ALS31300_VOLATILE_MSB_TEMPERATURE, __buf[0]) << 6 | \
>> +			  FIELD_GET(ALS31300_VOLATILE_LSB_TEMPERATURE, __buf[1]))
> 
> What does the u8 cast change?

It was to align with the s8 defines, but it won't be needed with sign_extend32

> 
>> +
> 
>> +struct als31300_data {
>> +	struct device *dev;
>> +	/* protects power on/off the device and access HW */
>> +	struct mutex mutex;
>> +	unsigned long sensitivity;
>> +	struct regmap *map;
>> +	struct {
>> +		u16 temperature;
>> +		s16 channels[3];
>> +		s64 timestamp __aligned(8);
> aligned_s64 timestamp
> 
> 
> It's new so for now only in the togreg branch of iio.git.

Ack, I'll use it and rebase on your togreg branch

> 
>> +	} scan;
>> +};
>> +
>> +/* The whole measure is split into 2x32bit registers, we need to read them both at once */
>> +static int als31300_get_measure(struct als31300_data *data, s16 *t, s16 *x,
>> +				s16 *y, s16 *z)
>> +{
>> +	unsigned int count = 0;
>> +	u32 buf[2];
>> +	int ret;
>> +
>> +	mutex_lock(&data->mutex);
> 
> 	guard(mutex)(&data->mutex) and drop the unlock handling.
> It's a small simplification but still nice to have here.

Ok, it'll be my first time, hope I'll get it right

> 
>> +	ret = pm_runtime_resume_and_get(data->dev);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	/* Max update rate it 2KHz, wait up to 1ms */
>> +	while (count < 50) {
>> +		/* Read Data */
>> +		ret = regmap_bulk_read(data->map, ALS31300_VOLATILE_MSB, buf, 2);
>> +		if (ret) {
>> +			dev_err(data->dev, "read data failed, error %d\n", ret);
>> +			goto out;
>> +		}
>> +
>> +		/* Check if data is valid, happens right after getting out of sleep mode */
>> +		if (FIELD_GET(ALS31300_VOLATILE_MSB_NEW_DATA, buf[0]))
>> +			break;
>> +
>> +		usleep_range(10, 20);
>> +		++count;
>> +	}
>> +
>> +	if (count >= 50) {
>> +		ret = -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*t = ALS31300_TEMPERATURE_GET(buf);
>> +	*x = ALS31300_DATA_X_GET(buf);
>> +	*y = ALS31300_DATA_Y_GET(buf);
>> +	*z = ALS31300_DATA_Z_GET(buf);
>> +
>> +out:
>> +	pm_runtime_mark_last_busy(data->dev);
>> +	pm_runtime_put_autosuspend(data->dev);
>> +
>> +unlock:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static int als31300_read_raw(struct iio_dev *indio_dev,
>> +			     const struct iio_chan_spec *chan, int *val,
>> +			     int *val2, long mask)
>> +{
>> +	struct als31300_data *data = iio_priv(indio_dev);
>> +	s16 t, x, y, z;
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = als31300_get_measure(data, &t, &x, &y, &z);
>> +		if (ret)
>> +			return ret;
> 
> blank line here would perhaps make this a tiny bit easier to read.

Ack

> 
>> +		switch (chan->address) {
>> +		case TEMPERATURE:
>> +			*val = t;
>> +			return IIO_VAL_INT;
>> +		case AXIS_X:
>> +			*val = x;
>> +			return IIO_VAL_INT;
>> +		case AXIS_Y:
>> +			*val = y;
>> +			return IIO_VAL_INT;
>> +		case AXIS_Z:
>> +			*val = z;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			/*
>> +			 * Fractional part of:
>> +			 *         302(value - 1708)
>> +			 * temp = ------------------
>> +			 *             4096
>> +			 * to convert temperature in Celcius
> 
> Units in IIO ABI (because we copied hwmon) are millidegrees celcius.
> Bad decision a long time back, but we are stuck with it.
> See Documentation/ABI/testing/sysfs-bus-iio

I was wondering, now I have my answer :-)

> 
>> +			 */
>> +			*val = 302;
>> +			*val2 = 4096;
>> +			return IIO_VAL_FRACTIONAL;
>> +		case IIO_MAGN:
>> +			/*
>> +			 * Devices are configured in factory
>> +			 * with different sensitivities:
>> +			 * - 500 GAUSS <-> 4 LSB/Gauss
>> +			 * - 1000 GAUSS <-> 2 LSB/Gauss
>> +			 * - 2000 GAUSS <-> 1 LSB/Gauss
>> +			 * with translates by a division of the returned
>> +			 * value to get Gauss value.
>> +			 * The sensisitivity cannot be read at runtime
>> +			 * so the value depends on the model compatible
>> +			 * or device id.
>> +			 */
>> +			*val = 1;
>> +			*val2 = data->sensitivity;
>> +			return IIO_VAL_FRACTIONAL;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			*val = -1708;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static irqreturn_t als31300_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct als31300_data *data = iio_priv(indio_dev);
>> +	s16 x, y, z;
>> +	u16 t;
>> +	int ret;
>> +
>> +	ret = als31300_get_measure(data, &t, &x, &y, &z);
>> +	if (ret)
>> +		goto trigger_out;
>> +
>> +	data->scan.temperature = t;
>> +	data->scan.channels[0] = x;
>> +	data->scan.channels[1] = y;
>> +	data->scan.channels[2] = z;
> 
> This is pretty small. I'd just put scan on the stack in this function.

Ack

> 
>> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>> +					   iio_get_time_ns(indio_dev));
> 
> pf->timestamp given you are providing a non threaded interrupt handler
> to fill that in.

Ok

> 
>> +
>> +trigger_out:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
>> +static const struct iio_chan_spec als31300_channels[] = {
>> +	{
>> +		.type = IIO_TEMP,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_SCALE) |
>> +			BIT(IIO_CHAN_INFO_OFFSET),
>> +		.address = TEMPERATURE,
>> +		.scan_index = TEMPERATURE,
>> +		.scan_type = {
>> +			.sign = 'u',
>> +			.realbits = 16,
>> +			.storagebits = 16,
>> +			.endianness = IIO_CPU,
>> +		},
>> +	},
>> +	ALS31300_AXIS_CHANNEL(X, AXIS_X),
>> +	ALS31300_AXIS_CHANNEL(Y, AXIS_Y),
>> +	ALS31300_AXIS_CHANNEL(Z, AXIS_Z),
>> +	IIO_CHAN_SOFT_TIMESTAMP(6),
> 
> Why 6?
> 
> Technically it's not wrong ABI, just odd to leave a gap between the channels
> and the timestamp.  Probably wants to be 4

Seems it's a bad copy-paste and not knowing what 6 was meaning, thx for the clarification

> 
>> +};
> 
>> +static int als31300_probe(struct i2c_client *i2c)
>> +{
>> +	struct device *dev = &i2c->dev;
>> +	struct als31300_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->dev = dev;
>> +	i2c_set_clientdata(i2c, indio_dev);
>> +
>> +	mutex_init(&data->mutex);
>> +
>> +	data->sensitivity = (unsigned long)of_device_get_match_data(dev);
> After changing the data to pointers to structures below use
> i2c_get_match_data() That will try various types of firmware and fall
> back to the id tables if appropriate.

Yep I have a change that does that already, I figured that out after sending v1...

> 
>> +
>> +	data->map = devm_regmap_init_i2c(i2c, &als31300_regmap_config);
>> +	if (IS_ERR(data->map))
>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>> +				     "failed to allocate register map\n");
> 
> ...
> 
> 
>> +
>> +static DEFINE_RUNTIME_DEV_PM_OPS(als31300_pm_ops,
>> +				 als31300_runtime_suspend, als31300_runtime_resume,
>> +				 NULL);
>> +
>> +static const struct i2c_device_id als31300_id[] = {
>> +	{ "als31300-500" },
> 
> This needs data as well because you can probe via the sysfs interface instead
> of DT which will use these ids.
> 
>> +	{ "als31300-1000" },
>> +	{ "als31300-2000" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, als31300_id);
>> +
>> +static const struct of_device_id als31300_of_match[] = {
>> +	{ .compatible = "allegromicro,als31300-500", .data = (void *)4 },
>> +	{ .compatible = "allegromicro,als31300-1000", .data = (void *)2 },
>> +	{ .compatible = "allegromicro,als31300-2000", .data = (void *)1 },
> 
> Use pointers to structures and also use them above.  Even if those structures
> have just one value in them for now.
> 
> Just have something like
> 
> struct als31300_variant_info {
> 	u8 sensitivity;
> };
> 
> static const struct als31300_variant_info al31300_variant_500 = {
> 	.sensitivity = 4;
> };
> 
> etc.

Yep I'll switch to that

> 
> 
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, als31300_of_match);
>> +
>> +static struct i2c_driver als31300_driver = {
>> +	.driver	 = {
>> +		.name = "als31300",
>> +		.of_match_table = als31300_of_match,
>> +		.pm = pm_ptr(&als31300_pm_ops),
>> +	},
>> +	.probe = als31300_probe,
>> +	.id_table = als31300_id,
>> +};
>> +module_i2c_driver(als31300_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("ALS31300 3-D Linear Hall Effect Driver");
>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>>
> 

Thanks,
Neil

