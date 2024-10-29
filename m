Return-Path: <linux-iio+bounces-11553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1249B43D1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 09:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3E8283903
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AC20370C;
	Tue, 29 Oct 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2HPFWmk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79E2036F8
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189358; cv=none; b=GYxs8+u62qg/8EMYeD6+d9Pqi168YgXctSdIT6SyJfkMAH1O2R/jn2gI+1eXRgD8FvAh6FAULjgR/uQ2HTGWz+Evoq6W/AhtPgvsrafQpOgWwIzNIIfQfiSKHbvyUYD/Hwm3fv6UA+CQEJvZNvr7PoyNJuxVfMvUkdPvW17/onE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189358; c=relaxed/simple;
	bh=1yYFZUgzwZJX8c97cDYGNMLz5Det8+K3peNnR8iF278=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AlsWU4FuACSKedkS6tdMthAvXf+/8As6NmT6zjZVayGzmYb/KPZUQ8lq6/VRML+c+FwE+M1XWAIz0/QccRqKL0cwOT1v2ANmN3ttMbqLoDzhjco3CkQe1e3Fb8WmHjEQFlhTKhN4WRQVFtSHsn2Hqr6gHJz/hql7X4KCpEc34oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d2HPFWmk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso47462275e9.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189354; x=1730794154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZARtYlmzZ5XHKlzg/NydBknT2s1reu45newK8+BNnU=;
        b=d2HPFWmkTUB5YPPcId9x4ql22n19kFo5RD4KhqawjHNtq1F0B0mojSumHSJl4J/rKD
         xy+4EgcHIJej93fCMAgSI40qGxF/GM/NMBiJEzFG+DQbMQuPUyW2Hecx7Gw11taOhxVl
         NoJX957Ygo6U6YCl/xNHB1zCnzdXiv6rZUoI3odvIyr0TbkNM3ahJ3+/fV2yy8oGRlVA
         cEvjt/DLTR2H9jRJR6gzW9l4pEVU8nfAN9/Pv1jWi2jG7K8rOtzIjogvmoLlVybdjZb5
         ThJ1cf0KUyulh0sNEipPEHomq+lzdP4hBrIgnRxjDf1PvkJo4GZM3D9EVGHYCyKUmwf6
         rAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189354; x=1730794154;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZARtYlmzZ5XHKlzg/NydBknT2s1reu45newK8+BNnU=;
        b=OlyEv+Xv6BMblycB+9z94/QbskueftpQYNP1KfegMKxze3BXfem+aG3YuRsKbjJTPC
         zvnd1qgoRIyBqzxEUQLa4ciyl6TF2pl7+IpGr0mDQArKLw7cTeadysh4rAGzQPVHgYiI
         Qyw6ihRReKvV/fqVp4sYhgOxH5P3Z9wcRq1uW3xNsHdbKsmSELESmOiQAWXENezIGJTN
         GBxsgSyNL/uOHoUkIKOu2oFP4QXTfeg8t9lHKQM2/GKhmtj+N93rGDe4zMxs8k3EqrBn
         2Zb7PyAO39YUojkhFo/6qubRV5uonm9kf0wSheOalzMGIhs5J1k9aF1+cyj7Kzqbbfs0
         npdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZifv/rHkJV1dgQN1eQtVB9Joe/wKBpYYEev7VY19EGhPMxsoBdQZYFmSYPd90lm7tDq3sOdYrXro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllCNEx/FhOyZKZ9gVtVKz1tyb4Qwh5dOce/ge42dSHl7heb8Q
	Xd+wW7jaU7IZkKMXW2GLMR1sOWIHWMxK78rcPJ6/B2TqEute0HWEvCMembN+/ZE=
X-Google-Smtp-Source: AGHT+IGxFQXHuW0OzAuWHrz5fijZ/uyGD0EUznIY4hDu5MFz+6O/zXl2JbKHyMQdxvX3Ic/B6Av8Hw==
X-Received: by 2002:a05:600c:1c1a:b0:431:55af:a22f with SMTP id 5b1f17b1804b1-4319aca400bmr96009235e9.13.1730189353939;
        Tue, 29 Oct 2024 01:09:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ca93:e94:9ce5:a5e0? ([2a01:e0a:982:cbb0:ca93:e94:9ce5:a5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431b437d362sm18228645e9.0.2024.10.29.01.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 01:09:13 -0700 (PDT)
Message-ID: <9f8b6789-ca87-425c-9645-c4b97dcb2424@linaro.org>
Date: Tue, 29 Oct 2024 09:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org>
 <20241021-topic-input-upstream-als31300-v2-3-36a4278a528e@linaro.org>
 <Zx1chYp4FRyG8fKM@surfacebook.localdomain>
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
In-Reply-To: <Zx1chYp4FRyG8fKM@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26/10/2024 23:17, Andy Shevchenko wrote:
> Mon, Oct 21, 2024 at 02:38:55PM +0200, Neil Armstrong kirjoitti:
>> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
>> mainly used for 3D head-on motion sensing applications.
>>
>> The device is configured over I2C, and as part of the Sensor data the
>> temperature core is also provided.
>>
>> While the device provides an IRQ gpio, it depends on a configuration
>> programmed into the internal EEPROM, thus only the default mode is
>> supported and buffered input via trigger is also supported to allow
>> streaming values with the same sensing timestamp.
>>
>> The device can be configured with different sensitivities in factory,
>> but the sensitivity value used to calculate value into the Gauss
>> unit is not available from registers, thus the sensitivity is provided
>> by the compatible/device-id string which is based on the part number
>> as described in the datasheet page 2.
> 
> ...
> 
> Some headers are missing...
> 
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
> 
> + pm.h
> 
>> +#include <linux/pm_runtime.h>
> 
>> +#include <linux/regulator/consumer.h>
> 
> + types.h

Ack

> 
> ...
> 
>> +#define ALS31300_DATA_X_GET(b)		\
>> +		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_X_AXIS, b[0]) << 4 | \
>> +			      FIELD_GET(ALS31300_VOL_LSB_X_AXIS, b[1]), 11)
>> +#define ALS31300_DATA_Y_GET(b)		\
>> +		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Y_AXIS, b[0]) << 4 | \
>> +			      FIELD_GET(ALS31300_VOL_LSB_Y_AXIS, b[1]), 11)
>> +#define ALS31300_DATA_Z_GET(b)		\
>> +		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Z_AXIS, b[0]) << 4 | \
>> +			      FIELD_GET(ALS31300_VOL_LSB_Z_AXIS, b[1]), 11)
>> +#define ALS31300_TEMPERATURE_GET(b)	\
>> +		(FIELD_GET(ALS31300_VOL_MSB_TEMPERATURE, b[0]) << 6 | \
>> +		 FIELD_GET(ALS31300_VOL_LSB_TEMPERATURE, b[1]))
> 
> These and in the code seems like you make a home grown endianes conversion.
> I suppose all of them have to be __beXX with the respective masks that cover
> all the bits.

This has nothing do to with endianess conversion, the bits of the 4 channels
are split on 2 registers, look at the defines.

> 
>> +static int als31300_get_measure(struct als31300_data *data,
>> +				u16 *t, s16 *x, s16 *y, s16 *z)
>> +{
>> +	unsigned int count = 0;
>> +	u32 buf[2];
> 
> Shouldn't this be __be64 buf?

No this is 2 separate registers with different fields, not a single 64bit big-endian register

> 
>> +	int ret;
>> +
>> +	guard(mutex)(&data->mutex);
>> +
>> +	ret = pm_runtime_resume_and_get(data->dev);
>> +	if (ret)
>> +		return ret;
> 
>> +	/* Max update rate is 2KHz, wait up to 1ms */
>> +	while (count < 50) {
>> +		/* Read Data */
>> +		ret = regmap_bulk_read(data->map, ALS31300_VOL_MSB, buf, 2);
> 
> At bare minimum ARRAY_SIZE(), but see above, I think it should use the respective type.

I'll use ARRAY_SIZE

> 
>> +		if (ret) {
>> +			dev_err(data->dev, "read data failed, error %d\n", ret);
>> +			goto out;
>> +		}
>> +
>> +		/* Check if data is valid, happens right after getting out of sleep mode */
>> +		if (FIELD_GET(ALS31300_VOL_MSB_NEW_DATA, buf[0]))
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
> 
> This one of the longest variant of implementing
> 
> 	do {
> 		...
> 	} while (!FIELD_GET(...) && --count)
> 
> But you also may consider something from iopoll.h (I don't remember if we have
> regmap_read_poll_timeout() for bulk transfers.

There's no poll for bulk read, I'll try using an IOPOLL function

> 
>> +	*t = ALS31300_TEMPERATURE_GET(buf);
>> +	*x = ALS31300_DATA_X_GET(buf);
>> +	*y = ALS31300_DATA_Y_GET(buf);
>> +	*z = ALS31300_DATA_Z_GET(buf);
>> +
>> +out:
>> +	pm_runtime_mark_last_busy(data->dev);
>> +	pm_runtime_put_autosuspend(data->dev);
> 
> Last discussion with Rafael on the topic of the above puts a question mark to
> all these cases when runtime PM idle callback has not been implemented.
> 
> Shouldn't this be simply
> 
> 	pm_runtime_put(data->dev);
> 
> ?

Probably, I just used the same schema as other similar IIO drivers

> 
>> +	return ret;
>> +}
> 
> ...
> 
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			/*
>> +			 * Fractional part of:
>> +			 *         1000 * 302 * (value - 1708)
>> +			 * temp = ----------------------------
>> +			 *             4096
>> +			 * to convert temperature in millicelcius
>> +			 */
>> +			*val = 1000 * 302;
> 
> MILLI from units.h ?

Well, sure, but it's still 1000, should I also define ONE to 1 and so on ?

> 
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
>> +			*val2 = data->variant_info->sensitivity;
>> +			return IIO_VAL_FRACTIONAL;
>> +		default:
>> +			return -EINVAL;
>> +		}
> 
> ...
> 
>> +	struct {
>> +		u16 temperature;
>> +		s16 channels[3];
>> +		aligned_s64 timestamp;
>> +	} __packed scan;
> 
> Why __packed?

Probably unneeded, will drop

> 
> ...
> 
>> +static int als31300_set_operating_mode(struct als31300_data *data,
>> +				       unsigned int val)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(data->map, ALS31300_VOL_MODE,
>> +				 ALS31300_VOL_MODE_SLEEP, val);
>> +	if (ret) {
>> +		dev_err(data->dev, "failed to set operating mode (%pe)\n", ERR_PTR(ret));
>> +		return ret;
>> +	}
>> +
>> +	/* The time it takes to exit sleep mode is equivalent to Power-On Delay Time */
>> +	if (val == ALS31300_VOL_MODE_ACTIVE_MODE)
>> +		usleep_range(600, 650);
>> +
>> +	return ret;
> 
> 	return 0;

It's the same but ok

> 
>> +}
> 
> ...
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
> 
>> +	mutex_init(&data->mutex);
> 
> Why not devm_mutex_init()? How does this being cleaned up?

Indeed, good catch

> 
>> +	data->variant_info = i2c_get_match_data(i2c);
>> +	if (!data->variant_info)
>> +		return -EINVAL;
>> +
>> +	data->map = devm_regmap_init_i2c(i2c, &als31300_regmap_config);
>> +	if (IS_ERR(data->map))
>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>> +				     "failed to allocate register map\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vcc");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
>> +
>> +	ret = als31300_set_operating_mode(data, ALS31300_VOL_MODE_ACTIVE_MODE);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to power on device\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, als31300_power_down, data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
>> +
>> +	indio_dev->info = &als31300_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->name = i2c->name;
>> +	indio_dev->channels = als31300_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(als31300_channels);
>> +	indio_dev->available_scan_masks = als31300_scan_masks;
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> +					      iio_pollfunc_store_time,
>> +					      als31300_trigger_handler,
>> +					      &als31300_setup_ops);
>> +	if (ret < 0) {
>> +		dev_err(dev, "iio triggered buffer setup failed\n");
>> +		return ret;
> 
> Why not return dev_err_probe(...);

Sure

> 
>> +	}
>> +
>> +	ret = pm_runtime_set_active(dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_get_noresume(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, 200);
>> +	pm_runtime_use_autosuspend(dev);
>> +
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "device register failed\n");
>> +
>> +	return 0;
>> +}
> 

Thanks,
Neil

