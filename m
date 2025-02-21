Return-Path: <linux-iio+bounces-15916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B47A3FB8C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 17:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43E3863B7E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BDC1F8ADB;
	Fri, 21 Feb 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b0Pj91FN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4E1F12EC
	for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155438; cv=none; b=GFAxwhPYseL2xIFJRhtOKKcUxSFnWFNNxbQpaWl9G7kqVQoohOnHQpfa5UCgKSJEfcUHKvjVCrsUK5dXXBXfo+v6uFDIIK5AriRldXQ//ezGgdsLlrJxq+xt/Cc/HNt7grJcE/ZCOqMB1gedvf9B/q9QG20NR4gX9qUIys0ncvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155438; c=relaxed/simple;
	bh=+6KzKBIx6mpHhKg/4+HFnGf1d9EOfmRJxUJwL920QKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlFOWyACXkrw+vp0ph6MZhOjWnmgLwNWqF/yjexbk80imPuNqZnmTw/gZPZUgGS5UHaufatfLxLLmYi7GE2sh8VK8/7WQSRmQOyyeJlJaBtaBd1WchjkzcmvREpLIusRQFYDDPLjcrICtrxmRTSMSOAO6cP4etNfps3Y/YpcX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b0Pj91FN; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2addd5053c0so1331203fac.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740155434; x=1740760234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yraMqB3V0rz+4If7jNzjsoA2YWqNW4WDNQQZ/DTpC8Q=;
        b=b0Pj91FN7Pu1DGVS4VwzANKtTaupULKkqROXgkGPqcr4wup/+THnPLIwT19sHQgWF8
         jpaf9BdTG7mT+O6ndMZL4o7JOgm9SftSBopqd5HK56X/1Y+fQ44aw9kxAmQwHGFK8VXu
         Xy86Q6DVcFaEAiANhOI8frAqy3wm/pO98XQu+CPU+usJ1m3CMyGlLVzibLbwL2cWzgPR
         TgifDcNNsD8OJ+7oaPZigeo2b7LhiYRKgW3nEYWlxqzpVDed8JJ+tEUpb9nwU1BbgC2a
         7sei+/P1o+yTCkRMXnj/imG3+TVauaqz7B2Lnu1nRVvqYoysFzEGebMvMme86+FKDJaU
         XAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155434; x=1740760234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yraMqB3V0rz+4If7jNzjsoA2YWqNW4WDNQQZ/DTpC8Q=;
        b=s9VicJk910Omuk2ITe6ITjVPhBjHzTtmlM7zG18Q5/5ApoWVwXvx7yH7jsbcPjcWca
         tYINr/yEmD3G/bNfZd3TMGrI3SKql/TUZTza90o77+RLbkqWWYlO1er9DMvHnPXQZNQY
         0vtPPukAnUyUeGRnaY1w36ieESzZAMiivlI4GiqNxr/wvv806yAMkB9ZHlm3m8D1TYw0
         sHvyhXyIAkufThFDbIUVLYlRMocqlXUafCGk42X98nw6jHq2O/CcKIUCvzyNHtFl7GYx
         I+8MGtLa20uc7q9QFnXfb/sHJxj/aCKO/Rn5zd164x5pGPcSJK57MFSOBD9l6Oiios1f
         NnBg==
X-Forwarded-Encrypted: i=1; AJvYcCX9MB+/lD+tvMyTiq6DAnZAHhfPGgmo1i8UwU+ktubS/ClnQQtyfMzZ/aa1M9plk7cIf8aJsfMFZrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCd2YHtMCgXBLbtuX6HvRdgT/OA6sFIWTjOqIPptaV/Ioz3wZb
	StPqJoQrdksWlMZXz4ZRyZsCcV3npVJwUTYjoAXIR4ld/9jXKLuv9D7MT9+oJ6A=
X-Gm-Gg: ASbGncv4SnPOJan7v2CKorWEeKWlDw2LPrsbOnh3coWWTanCEvxtLNB32fAJB5cG384
	nzBBLTe75zFkCVAd/rAtVx0FPLpfp51ZjK/jRmp6xorrUCTBSk0Ja5VQ9lMkfstwLtv3OQS88cw
	wUqPiJvrbte6ykG823xXZFaMKHZJjLtHVNbEyYTCzW44bf+f79qrBKBmz3mh6N9Jllw2/KuOo+U
	UZFHzNGGBJCruE0wcjqrvWnuxe2Om3nyGbaO1rTd+GKVWh1ag3pXQ0DKOWDKotwWxUp2PIXqPPe
	21MYmK5MaGrs7jzaMq0YFX8N0Iu6w127BeyrHOvTyPrtvRRzKy6YIZDcb/h7d3U=
X-Google-Smtp-Source: AGHT+IF5/l844C8i/roqudIe6U4obFMxplsc/QWd3Tj6rY2veQmSYaFOHBJtViXOAZab5e5Vr5lyfw==
X-Received: by 2002:a05:6871:a910:b0:2bc:8c4a:aac2 with SMTP id 586e51a60fabf-2bd50f30260mr2983960fac.27.1740155434450;
        Fri, 21 Feb 2025 08:30:34 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72737f96190sm1526218a34.11.2025.02.21.08.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 08:30:33 -0800 (PST)
Message-ID: <2edc6e72-245b-4a55-bb5e-6a6ed3abcf27@baylibre.com>
Date: Fri, 21 Feb 2025 10:30:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: add support for Nuvoton NCT7201
To: Eason Yang <j2anfernee@gmail.com>, avifishman70@gmail.com,
 tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
 yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, gstols@baylibre.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, marcelo.schmitt@analog.com,
 alisadariana@gmail.com, joao.goncalves@toradex.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
 <20250221090918.1487689-3-j2anfernee@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250221090918.1487689-3-j2anfernee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 3:09 AM, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.
> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/adc/Kconfig   |  11 +
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/nct7201.c | 487 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 500 insertions(+)
>  create mode 100644 drivers/iio/adc/nct7201.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdc4aa5c7eff..389cbbdae1a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2838,6 +2838,7 @@ F:	arch/arm/mach-npcm/
>  F:	arch/arm64/boot/dts/nuvoton/
>  F:	drivers/*/*/*npcm*
>  F:	drivers/*/*npcm*
> +F:	drivers/iio/adc/nct7201.c

Same comment as DT bindings, this is ARM/NUVOTON NPCM ARCHITECTURE.
We need a new section for this chip since it is stand-alone.

>  F:	drivers/rtc/rtc-nct3018y.c
>  F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
>  F:	include/dt-bindings/clock/nuvoton,npcm845-clk.h

...

> diff --git a/drivers/iio/adc/nct7201.c b/drivers/iio/adc/nct7201.c
> new file mode 100644
> index 000000000000..c5d1540bcc00
> --- /dev/null
> +++ b/drivers/iio/adc/nct7201.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Nuvoton nct7201 and nct7202 power monitor chips.
> + *
> + * Copyright (c) 2024-2025 Nuvoton Technology corporation.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>

Are we really using something from the init header?

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +

...

> +static int nct7201_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	u16 volt;
> +	unsigned int value;
> +	int err;
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&chip->access_lock);

The regmap should already have an intneral lock, so this mutex seems
reduandnt in it's current usage.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN(chan->address), &value);
> +		if (err < 0)
> +			return err;
> +		volt = value;
> +		*val = FIELD_GET(NCT7201_REG_VIN_MASK, volt);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* From the datasheet, we have to multiply by 0.0004995 */
> +		*val = 0;
> +		*val2 = 499500;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int nct7201_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	u16 volt;
> +	unsigned int value;
> +	int err;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	if (dir == IIO_EV_DIR_FALLING) {
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +				  &value);
> +		if (err < 0)
> +			return err;
> +		volt = value;

Assigning to volt seems reduant. We can just pass value to
FIELD_GET() below.

> +	} else {
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +				  &value);
> +		if (err < 0)
> +			return err;
> +		volt = value;
> +	}
> +
> +	*val = FIELD_GET(NCT7201_REG_VIN_MASK, volt);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EOPNOTSUPP;
> +
> +	if (dir == IIO_EV_DIR_FALLING)
> +		regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +			     FIELD_PREP(NCT7201_REG_VIN_MASK, val));

No error checking? Could just return here directly.

> +	else
> +		regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +			     FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +
> +	return 0;
> +}
> +

...

> +static int nct7201_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	unsigned int mask;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	mask = BIT(chan->address);
> +
> +	if (!state && (chip->vin_mask & mask))
> +		chip->vin_mask &= ~mask;
> +	else if (state && !(chip->vin_mask & mask))
> +		chip->vin_mask |= mask;

This would be easier to read as:

	if (state)
		chip->vin_mask |= mask;
	else
		chip->vin_mask &= ~mask;

> +
> +	if (chip->num_vin_channels <= 8)
> +		regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, chip->vin_mask);

No error checking?

> +	else
> +		regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +				  &chip->vin_mask, sizeof(chip->vin_mask));
> +
> +	return 0;
> +}
> +

...

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	u8 data[2];
> +	unsigned int value;
> +	int err;
> +
> +	regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +		     NCT7201_BIT_CONFIGURATION_RESET);

Check error return?

> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then
> +	 * the Power Up bit will be set to 1. If not, wait for it.
> +	 */
> +	mdelay(25);
> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err < 0)
> +		return err;
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(&chip->client->dev, -EIO,
> +				     "Failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8) {
> +		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, data[0]);
> +		if (err < 0)
> +			return dev_err_probe(&chip->client->dev, -EIO,
> +					     "Failed to write NCT7201_REG_CHANNEL_ENABLE_1\n");
> +	} else {
> +		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> +		data[1] = NCT7201_REG_CHANNEL_ENABLE_2_MASK;
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					data, ARRAY_SIZE(data));
> +		if (err < 0)
> +			return dev_err_probe(&chip->client->dev, -EIO,
> +					    "Failed to write NCT7201_REG_CHANNEL_ENABLE_1 and NCT7201_REG_CHANNEL_ENABLE_2\n");
> +	}
> +
> +	value = get_unaligned_le16(data);

Does it matter that data[1] may be uninitialized and contain random value here?

> +	chip->vin_mask = value;

Don't really need the intermediate value assignment here.

> +
> +	/* Start monitoring if needed */
> +	err = regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &value);
> +	if (err < 0)
> +		return dev_err_probe(&chip->client->dev, -EIO,
> +				     "Failed to read NCT7201_REG_CONFIGURATION\n");
> +
> +	regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION, NCT7201_BIT_CONFIGURATION_START);
> +
> +	return 0;
> +}
> +


