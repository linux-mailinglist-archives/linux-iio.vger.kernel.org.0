Return-Path: <linux-iio+bounces-27344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE877CDA49E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 19:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7BB302C8C0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48503376AC;
	Tue, 23 Dec 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BQfYetwI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215E338595
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766515141; cv=none; b=duDZHd+F+mhYj2sxaq7S+ls+WUOMjH7bOlpU5s+iPcmTj62JLjMkfNTMpXpFMAwTX5A+mBwvfrCoAfygQzFhMzcKJ6LWQZT7rC31APWV/fkM/WG1S/nr11lG9UoIYg71SR4jKf0jhRQXt2lTX1cgFc/OpjZcc2UeahoG9BpFm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766515141; c=relaxed/simple;
	bh=Dg30BWoao0K62TGW2mJ1fTNWLuURqW6Q2wqseeg4LmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipur0wnDgnboa0wsDi2pEVmguo2hCCDY9ciH0Vy+qvPv1RFhspuM8LS0wynkMuFzxkvBAoXB48xSqQAO5q+3bIXRoIeEwtVrHKHJlsiAnObHBb7hEZmTlUQBZ/HH2glS+rsji7LRAlBDthdHq9lwSWzHmTajJZ4iYtZ8q6h/YX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BQfYetwI; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-455749af2e1so3832317b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 10:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766515138; x=1767119938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hURpEioUMYzBg0kpxK3F2rxqTzLXWyyg9wiThi3lkXI=;
        b=BQfYetwIQxkjrjuEm+pnbXgLuu2WZP8zFpYaatszid1oAz9hIkNXDYly3EiC7LYzrJ
         1dFZb11qP5Iw2Qyjo8dVM5zVmOxt2zrO3dAsCnIC9YJW8OljWNEyTfxz/1hiby6Lu4tc
         pUhsFNNqwj9p4dV3MmaWn2WNiA6ZvOl1CVzWVCiqxcBFInGPowvSMDzSccvMEtV9TvXy
         HfmG3pB3V+P4rbP4ig0WNNhysZvc53YUzLx1G0XaGXDadZKkGhehBA7oDNyMs5CQ+j7N
         q2QkqP1hOkyvw2q0RpfOO+a+pszg8AywvGM5QEP5JSRwb1G3jKXFJ/OFXR9OTwjuZCHD
         b0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766515138; x=1767119938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hURpEioUMYzBg0kpxK3F2rxqTzLXWyyg9wiThi3lkXI=;
        b=BIDzM+SqdgvXWut7dEVRvN+DBFMFP+PBNP8VYLu3+ARcUrbUBOdhyUXvO3GzV7cc8X
         94AveXAw00lEEbD0wyUMMLqMzhWAIzUO9SuJF2nrJBFRMNxm5mPrhGwR6500hUUQY/Cs
         owR624xQXf9RQ9KI8sL+wiTDiNV1OrUA8JZv1+kmKncfmtbXuSEIvJZyICChRCByMQZ8
         Tdu2JkkFrVYlYlo1hH6O1Io7TtziHsUF9bHdKrZVl8fl4Xk+xVN0iUyQcMDldWlk3Pdc
         2Iib4LvaqDD2dv6hkP9cA0iQ67DFA0EWr04m4nRvw1iKwb1aQ6qIOVf9/lws2gA47Wgr
         57/g==
X-Gm-Message-State: AOJu0Yx8mrnlSmBGXcBXZgF9j2hT/2tI4qLCGduRq7SmMA/tVUWsevOP
	vEElQX3/efW9dKx4S942XWDINvcdQEHvqWkBC3+C1rLvSQqJ9Qky1tGfVMCkju+fsik=
X-Gm-Gg: AY/fxX5/Gy+sQjDZL1sM7U4oMjhNvJZa3sfJGvbrlFeMt0eaUTs/byJBz1IBJDpf35Q
	jTGe17d2UPj2zon8zTYJ3LiAv+Q69RCGSn4GC6x4+mTkBio56wGt1+bWjJ1BtmIsW1qdfX2MwM4
	N9p67Dkvhbry6YvpWb1xScFCffKjKRPGnR1fs37wuuMeh2LEtNTPHUxIZ3TxE94At3tNdbuZM2w
	JIzp+LHxl/fCo1XnaItdvNU8yy7rdwqA3Fx9Tss342G8NLbRRb5Eg1jdWFhA+/SVPCPxNHW4Njz
	UH4o50q1+kh8G1t1CaaPrQJrN0+eHQ2px2PkQRxb1KpmYRuD6+V6z6LVqD8K3GPlv7XwmF+15z1
	EQfvQPCwp1qZ8CyGf5zsNkc07jTdlPeiki9KoKOVt/6V5y3y4piRKgpaNBtDpATHoY/d/tzF3SZ
	xO9/WFkKsrWUhmak+2uinTQ3zustaY8Ji9z5cjBqjWmxhLblL+pIHOIrWo1FDg
X-Google-Smtp-Source: AGHT+IG+QT8uIhzhuCO3YEMK3eLJ5rcDiZajqBx6b9CdF4mhoK8ZQHzV2rslL61NEPR94xrxFwXHbQ==
X-Received: by 2002:a05:6808:c22b:b0:450:3379:3c5c with SMTP id 5614622812f47-457a286f229mr9498605b6e.3.1766515138053;
        Tue, 23 Dec 2025 10:38:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fe29:88f1:f763:378b? ([2600:8803:e7e4:500:fe29:88f1:f763:378b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaa931b0esm9150718fac.8.2025.12.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 10:38:56 -0800 (PST)
Message-ID: <1a257edd-2179-4653-be22-10e44681bb60@baylibre.com>
Date: Tue, 23 Dec 2025 12:38:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ltc2309: add support for ltc2305
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
 <20251223-add_ltc2305_driver-v1-2-dfa0827fd620@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251223-add_ltc2305_driver-v1-2-dfa0827fd620@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 3:12 AM, Kyle Hsieh wrote:
> Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
> The LTC2305 and LTC2309 share similar features: both are 12-bit,
> low-noise, low-power SAR ADCs with an I2C interface.
> The main difference is the number of channels: LTC2305 has 2 channels,
> while LTC2309 has 8 channels.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  drivers/iio/adc/ltc2309.c | 50 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> index 5f0d947d0615..7a611ddd00d2 100644
> --- a/drivers/iio/adc/ltc2309.c
> +++ b/drivers/iio/adc/ltc2309.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> + * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.

Would be more conventional to list things in low to high order like in the
dt-bindings. (same applies throughout this patch)

>   *
>   * Datasheet:
>   * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
>   *
>   * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
>   */
> @@ -60,6 +62,13 @@ enum ltc2309_channels {
>  	LTC2309_CH7,
>  };
>  
> +enum ltc2305_channels {
> +	LTC2305_CH0_CH1 = 0,

Initializer is not strictly needed. I guess it is consistent with the
existing code though, so OK.

> +	LTC2305_CH1_CH0,
> +	LTC2305_CH0,
> +	LTC2305_CH1,
> +};
> +
>  #define LTC2309_CHAN(_chan, _addr) {				\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
> @@ -99,6 +108,31 @@ static const struct iio_chan_spec ltc2309_channels[] = {
>  	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
>  };
>  
> +static const struct iio_chan_spec ltc2305_channels[] = {
> +	LTC2309_CHAN(0, LTC2305_CH0),
> +	LTC2309_CHAN(1, LTC2305_CH1),
> +	LTC2309_DIFF_CHAN(0, 1, LTC2305_CH0_CH1),
> +	LTC2309_DIFF_CHAN(1, 0, LTC2305_CH1_CH0),
> +};
> +
> +struct ltc230x_chip_info {

We avoid putting "x" in names like this because the pattern breaks too often.
Just use the main driver prefix of ltc2309.

> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +};
> +
> +static const struct ltc230x_chip_info ltc2309_chip_info = {
> +	.name = "ltc2309",
> +	.channels = ltc2309_channels,
> +	.num_channels = ARRAY_SIZE(ltc2309_channels),
> +};
> +
> +static const struct ltc230x_chip_info ltc2305_chip_info = {
> +	.name = "ltc2305",
> +	.channels = ltc2305_channels,
> +	.num_channels = ARRAY_SIZE(ltc2305_channels),
> +};
> +
>  static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
>  				    unsigned long address, int *val)
>  {
> @@ -158,6 +192,8 @@ static const struct iio_info ltc2309_info = {
>  
>  static int ltc2309_probe(struct i2c_client *client)
>  {
> +	const struct of_device_id *match;

Unused?

> +	const struct ltc230x_chip_info *chip_info;
>  	struct iio_dev *indio_dev;
>  	struct ltc2309 *ltc2309;
>  	int ret;
> @@ -167,13 +203,17 @@ static int ltc2309_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	ltc2309 = iio_priv(indio_dev);
> +	chip_info = device_get_match_data(&client->dev);

Why not i2c_get_match_data()?

> +	if (!chip_info)
> +		return -EINVAL;
> +
>  	ltc2309->dev = &indio_dev->dev;
>  	ltc2309->client = client;
>  
> -	indio_dev->name = "ltc2309";
> +	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ltc2309_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
> +	indio_dev->channels = chip_info->channels;
> +	indio_dev->num_channels = chip_info->num_channels;
>  	indio_dev->info = &ltc2309_info;
>  
>  	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
> @@ -189,13 +229,15 @@ static int ltc2309_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id ltc2309_of_match[] = {
> -	{ .compatible = "lltc,ltc2309" },
> +	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
> +	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ltc2309_of_match);
>  
>  static const struct i2c_device_id ltc2309_id[] = {
>  	{ "ltc2309" },
> +	{ "ltc2305" },

Also need to add chip_infos here.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2309_id);
> 


