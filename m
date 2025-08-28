Return-Path: <linux-iio+bounces-23348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8794DB3AE7D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 01:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379D2981DC7
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43F2D29DF;
	Thu, 28 Aug 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hw0h8BGf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B63FC7
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424462; cv=none; b=leY4f54K+Nj1dxbIvQsBjMyKKjEvupCj0HJJ7qCDvegDo/0pJxsvE0OWob8I8F36rvGGZXL0dekh6NeOtsRQnz6a1xEZXehXoiYnGCZVZBTjtQqxYBFAbsV1FK7EYJ4OcWbuloyyCkBPt0Iy7XD3AojhqUVh8jyM5Pe7NKlt18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424462; c=relaxed/simple;
	bh=xUgVj+tuzHLMEmq4Jh2B7hWy0r8iT7NR2jslR1LoF8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXFTLq7tPFD2+u/zDOfb93IQ+itOjUrxzP8r/weWD6SkVSJQp0eUxt0fJ1+Qwarks1elyOrzONPvCNVtw/40TibiZkddX3fkn+RlpsLUNX69xG5b0JFM4IEFrcsJE92o66vvLkcqFqeLhEnf5VWoFpHPguXZgrSVes86+y3pkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hw0h8BGf; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30ccec50c0aso1262661fac.3
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756424458; x=1757029258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW2RCpN9dhtbevSJQxlQRasQnPcW8K++QQV1TbGRUHI=;
        b=hw0h8BGfSUn7VGpVA+uCuol1zc2umKkfOAX0YLgUmBZLu6Doc4SA/BioC7E1fZMnCI
         cfQ0u0ppXqzR42Ri+Q4LVBIXW3BhdUn+3VqfFhFxaRde1O6ta8rar8fIUIyQhj24IbBz
         2AFb3C4PRl66YHijtBU/acEsUPBrMKMyYenrqQDyj3JKMrGCX2V892qGIhPFuu2sKXIP
         GIvU+N/u/3GDqEgR7HZRg5O0HqNx6JWIntCCIW4ZQ6EFhTAriSVWUnsnkxgEx+dyNCTP
         sI6IGcTBrpIyojBbARYueAEtLHMinup9vEbnjiQ3TRfWlDJ7PZURs4s0KZ/GZkkZvfhv
         Z7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756424458; x=1757029258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW2RCpN9dhtbevSJQxlQRasQnPcW8K++QQV1TbGRUHI=;
        b=ZQqIR4kr5/xZSmcce0R75GQnx9MUHtrprkrocAofR/hVnq566YU7uV52sh4DuuuM+1
         rZ8nAZ7Jm9GGlEiAAY9FGwBFvNeqULIOL+FSTwGCoGNG6W1D/TK/n7OTQb79SOpz4tY4
         JAAA+jkR5PD1l8NocByyMUCjPYqoIsNXnWlPEY+prWircGOJnQNE9qiiXuC4TccMZyCS
         rc8uKrK7TL5Vw3wGjJ4oc2kCDZ1Hl7nWaXXZ+W890OZ0SIQOayty+k59QKPZfKKL4afU
         2TUcuf+eQscMEjQuEhOqh9e+IoGzfzYJFIagySe4A4EI/0flLwbXnXs+WC09/CSUlbBO
         OQuw==
X-Forwarded-Encrypted: i=1; AJvYcCUDLqhvl/RfLXeJwzpqpIRgIghx+qrfFH4ym8S+gx5p4mPfZHHQbF+X3as8cAzRn6ucvwNz+e/MOQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKgN/xrQviTd9lQChuOmGgB6nCUzpybaOMEqrHiD6Fqkaf5fg
	nXK9hr6vSsD5Pj8ABzXfT+RCZ3dZqC6GKrSuea1tgyA1WQq9YYAfmlEBgXVVwdNVj5eHp2cigj+
	MdqxS
X-Gm-Gg: ASbGncsH7qJLiUY57D/JjOuz/t3In6zVNVwrTZFFDtsuqcLDT67BTYKWg5I2VMnah5O
	6i4yaeFrScMmAC8S3H5UsTVlAAeoTLuRTSKNvPYubYfMEF2Fvn00riJM/eF0h0jk9B9srfdqAdf
	qYVX4XjFpjV8Elv38Yk+5+d1YtNcEuz3YFmymlO7blxDlTooMVb8Y7M2DqG6iXF9DzNJ12+cuHT
	nc3quR2EE25ZBWjuhduHAuFJZYHQiScUJcFKwy1ROR4aN88On1jKzxecBFCgxH9bU8HGGFvI2jz
	yOx0BV2NKoErPRxHbYBvGuOi3PAmSsQHxdUqakN/xU8/7frVqe+Ckw8wmPBdJeSrFyWlULtxV3e
	tdWKTF/9F8y5pn7AFX5Qgz/P6kizQyJH2gke9CZqK5Ay2BD8zQ+suFNpqS3tGgNhydM99Dco4SJ
	A=
X-Google-Smtp-Source: AGHT+IFZU5JI4fH2GSVbcctdn1Pjaeksm3478WjmY5QsSCp9ibECZWySUgTigEIRzL0hkxgWaBlM8A==
X-Received: by 2002:a05:6870:b00c:b0:314:9684:fe16 with SMTP id 586e51a60fabf-314dcf35130mr12240664fac.49.1756424458460;
        Thu, 28 Aug 2025 16:40:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102? ([2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745585328bdsm179518a34.30.2025.08.28.16.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 16:40:57 -0700 (PDT)
Message-ID: <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
Date: Thu, 28 Aug 2025 18:40:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/25 5:17 PM, Duje Mihanović wrote:
> Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> monitoring various system voltages and temperatures. Add the relevant
> register definitions to the MFD header and a driver for the ADC.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
>  MAINTAINERS                     |   5 +
>  drivers/iio/adc/88pm886-gpadc.c | 352 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/Kconfig         |  10 ++
>  drivers/iio/adc/Makefile        |   1 +
>  include/linux/mfd/88pm886.h     |  30 ++++
>  5 files changed, 398 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fed6cd812d796a08cebc0c1fd540c8901d1bf448..b362d81e9c1532cc7920f9cec65b1fd1f81471c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14710,6 +14710,11 @@ F:	drivers/regulator/88pm886-regulator.c
>  F:	drivers/rtc/rtc-88pm886.c
>  F:	include/linux/mfd/88pm886.h
>  
> +MARVELL 88PM886 PMIC GPADC DRIVER
> +M:	Duje Mihanović <duje@dujemihanovic.xyz>
> +S:	Maintained
> +F:	drivers/iio/adc/88pm886-gpadc.c
> +
>  MARVELL ARMADA 3700 PHY DRIVERS
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  S:	Maintained
> diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gpadc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..129cff48641f1505175e64cf7dbdd0133f265ce8
> --- /dev/null
> +++ b/drivers/iio/adc/88pm886-gpadc.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/kernel.h>

We usually try to avoid including kernel.h because it includes too much.
There are some recent-ish messages on the iio mailing list discussing
include-what-you-use with some tips on how to pick the headers that are
actually being used for inclusion.

> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/88pm886.h>

Odd to have this one not grouped with the rest.

> +
> +static const int regs[] = {

Would be nice to have the pm886_gpadc_ prefix on all global names.

> +	PM886_REG_GPADC_VSC,
> +	PM886_REG_GPADC_VCHG_PWR,
> +	PM886_REG_GPADC_VCF_OUT,
> +	PM886_REG_GPADC_TINT,
> +
> +	PM886_REG_GPADC_GPADC0,
> +	PM886_REG_GPADC_GPADC1,
> +	PM886_REG_GPADC_GPADC2,
> +
> +	PM886_REG_GPADC_VBAT,
> +	PM886_REG_GPADC_GNDDET1,
> +	PM886_REG_GPADC_GNDDET2,
> +	PM886_REG_GPADC_VBUS,
> +	PM886_REG_GPADC_GPADC3,
> +
> +	PM886_REG_GPADC_MIC_DET,
> +	PM886_REG_GPADC_VBAT_SLP,
> +};
> +
> +enum pm886_gpadc_channel {
> +	VSC_CHAN,
> +	VCHG_PWR_CHAN,
> +	VCF_OUT_CHAN,
> +	TINT_CHAN,
> +
> +	GPADC0_CHAN,
> +	GPADC1_CHAN,
> +	GPADC2_CHAN,
> +
> +	VBAT_CHAN,
> +	GNDDET1_CHAN,
> +	GNDDET2_CHAN,
> +	VBUS_CHAN,
> +	GPADC3_CHAN,
> +
> +	MIC_DET_CHAN,
> +	VBAT_SLP_CHAN,
> +
> +	GPADC0_RES_CHAN,
> +	GPADC1_RES_CHAN,
> +	GPADC2_RES_CHAN,
> +	GPADC3_RES_CHAN,
> +};
> +
> +#define ADC_CHANNEL(index, lsb, _type, name) {	\
> +	.type = _type, \
> +	.indexed = 1, \
> +	.channel = index, \
> +	.address = lsb, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_PROCESSED), \
> +	.datasheet_name = name, \

Do you have a link for the datasheet?

> +}
> +
> +static const struct iio_chan_spec pm886_adc_channels[] = {

Would be nice to be consistent with the prefix, either pm886_gpadc_
or pm886_adc_ everywhere.

> +	ADC_CHANNEL(VSC_CHAN, 1367, IIO_VOLTAGE, "vsc"),
> +	ADC_CHANNEL(VCHG_PWR_CHAN, 1709, IIO_VOLTAGE, "vchg_pwr"),
> +	ADC_CHANNEL(VCF_OUT_CHAN, 1367, IIO_VOLTAGE, "vcf_out"),
> +	ADC_CHANNEL(TINT_CHAN, 104, IIO_TEMP, "tint"),
> +
> +	ADC_CHANNEL(GPADC0_CHAN, 342, IIO_VOLTAGE, "gpadc0"),
> +	ADC_CHANNEL(GPADC1_CHAN, 342, IIO_VOLTAGE, "gpadc1"),
> +	ADC_CHANNEL(GPADC2_CHAN, 342, IIO_VOLTAGE, "gpadc2"),
> +
> +	ADC_CHANNEL(VBAT_CHAN, 1367, IIO_VOLTAGE, "vbat"),
> +	ADC_CHANNEL(GNDDET1_CHAN, 342, IIO_VOLTAGE, "gnddet1"),
> +	ADC_CHANNEL(GNDDET2_CHAN, 342, IIO_VOLTAGE, "gnddet2"),
> +	ADC_CHANNEL(VBUS_CHAN, 1709, IIO_VOLTAGE, "vbus"),
> +	ADC_CHANNEL(GPADC3_CHAN, 342, IIO_VOLTAGE, "gpadc3"),
> +	ADC_CHANNEL(MIC_DET_CHAN, 1367, IIO_VOLTAGE, "mic_det"),
> +	ADC_CHANNEL(VBAT_SLP_CHAN, 1367, IIO_VOLTAGE, "vbat_slp"),
> +
> +	ADC_CHANNEL(GPADC0_RES_CHAN, 342, IIO_RESISTANCE, "gpadc0_res"),
> +	ADC_CHANNEL(GPADC1_RES_CHAN, 342, IIO_RESISTANCE, "gpadc1_res"),
> +	ADC_CHANNEL(GPADC2_RES_CHAN, 342, IIO_RESISTANCE, "gpadc2_res"),
> +	ADC_CHANNEL(GPADC3_RES_CHAN, 342, IIO_RESISTANCE, "gpadc3_res"),

Is it safe (or sensible) to have both voltage and resistance channels
for the same input at the same time? It seems like if a voltage
channel was connected to an active circuit, we would not want to be
supplying current to it to take a resistance reading (this doesn't
sound safe). Likewise, if a voltage input has a passive load on it,
wouldn't the voltage channel always return 0 because no current was
supplied to induce a voltate (doesn't seem sensible to have a channel
that does notthing useful).

It might make sense to have some firmware (e.g. devicetree) to describe
if the input is active or passive on the voltage inputs and set up the
channels accordingly.

I'm also wondering if the other channels like vbat and vbus are always
wired up to these things internally or if this channel usage is only for
a specific system.

> +};
> +
> +static const struct regmap_config pm886_gpadc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = PM886_REG_GPADC_VBAT_SLP + 1,
> +};
> +
> +static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel chan)
> +{
> +	struct regmap **map = iio_priv(iio);

The double-pointer is a bit unusual. Maybe consider creating a struct
for private data even if it only has one field for now.

Or write it this like:

	struct regmap *map = *iio_priv(iio);

So that we don't have to write *map everywhere else.

> +	int val, ret;
> +	u8 buf[2];
> +
> +	if (chan >= GPADC0_RES_CHAN)
> +		/* Resistor voltage drops are read from the corresponding voltage channel */
> +		chan -= GPADC0_RES_CHAN - GPADC0_CHAN;

Does this actually work for GPADC3_RES_CHAN?

GPADC3_RES_CHAN == GPADC0_RES_CHAN + 3 but GPADC3_CHAN != GPADC0_CHAN + 3

> +
> +	ret = regmap_bulk_read(*map, regs[chan], buf, 2);
> +
> +	if (ret)
> +		return ret;
> +
> +	val = ((buf[0] & 0xff) << 4) | (buf[1] & 0xf);
> +	val &= 0xfff;

This line seems reduandant as mask was already applied in previous line.

> +
> +	return val;
> +}
> +
> +static int gpadc_enable_bias(struct regmap *map, enum pm886_gpadc_channel chan)
> +{
> +	int adcnum = chan - GPADC0_RES_CHAN, bits;

Jonathan prefers to have initializers on separate line. so bits should be
moved to a new line.

> +
> +	if (adcnum < 0 || adcnum > 3)
> +		return -EINVAL;
> +
> +	bits = BIT(adcnum + 4) | BIT(adcnum);
> +
> +	return regmap_set_bits(map, PM886_REG_GPADC_CONFIG20, bits);
> +}
> +
> +static int
> +gpadc_find_bias_current(struct iio_dev *iio, struct iio_chan_spec const *chan, int *volt,
> +			int *amp)
> +{
> +	struct regmap **map = iio_priv(iio);
> +	int adcnum = chan->channel - GPADC0_RES_CHAN;
> +	int reg = PM886_REG_GPADC_CONFIG11 + adcnum;
> +	int ret;
> +
> +	for (int i = 0; i < 16; i++) {
> +		ret = regmap_update_bits(*map, reg, 0xf, i);
> +		if (ret)
> +			return ret;
> +
> +		usleep_range(5000, 10000);

fsleep()

> +
> +		*amp = 1 + i * 5;
> +		*volt = gpadc_get_raw(iio, chan->channel) * chan->address;

I know the address can be used for anything the driver wants it to be. :-)
But this reads a bit weird. It would be a bit easier to understand if we
had a separate lookup table to get this info. Or at least store it in a
local variable first so we can get a meaningful name for th value.

> +
> +		/* Measured voltage should never exceed 1.25V */
> +		if (WARN_ON(*volt > 1250000))

Units of volt is not clear. Would be better named as raw_uv or similar.
Same applies to `amp` parameter.

> +			return -EIO;
> +
> +		if (*volt < 300000) {

Writing this as `raw_uv < 300 * (MICRO / MILLI)` could make it easier to
understand that we are checking if the raw value (in microvolts) is less
than 300 millivolts. Same applies to 1250000 above.

> +			dev_dbg(&iio->dev, "bad bias for chan %d: %duA @ %duV\n", chan->channel,
> +				*amp, *volt);

Could be a bit more clear to put continue; here and drop the else.

> +		} else {
> +			dev_dbg(&iio->dev, "good bias for chan %d: %duA @ %duV\n", chan->channel,
> +				*amp, *volt);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(&iio->dev, "failed to find good bias for chan %d\n", chan->channel);
> +	return -EINVAL;
> +}
> +
> +static int
> +gpadc_get_resistor(struct iio_dev *iio, struct iio_chan_spec const *chan)

s/resistor/resistance/ and add unit suffix, e.g. _ohm

> +{
> +	struct regmap **map = iio_priv(iio);
> +	int ret, volt, amp;
> +
> +	ret = gpadc_enable_bias(*map, chan->channel);
> +	if (ret)
> +		return ret;
> +
> +	ret = gpadc_find_bias_current(iio, chan, &volt, &amp);
> +	if (ret)
> +		return ret;
> +
> +	return DIV_ROUND_CLOSEST(volt, amp);
> +}
> +
> +static int
> +pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *chan, int *val, int *val2,

Wrap to 80 characters.

> +		     long mask)
> +{
> +	struct device *dev = iio->dev.parent;
> +	int raw, ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->type == IIO_RESISTANCE) {
> +		raw = gpadc_get_resistor(iio, chan);
> +		if (raw < 0) {
> +			ret = raw;
> +			goto out;
> +		}
> +
> +		*val = raw;
> +		dev_dbg(&iio->dev, "chan: %d, %d Ohm\n", chan->channel, *val);
> +		ret = IIO_VAL_INT;
> +		goto out;
> +	}
> +
> +	raw = gpadc_get_raw(iio, chan->channel);
> +	if (raw < 0) {
> +		ret = raw;
> +		goto out;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

If there is IIO_CHAN_INFO_RAW, then we also should have IIO_CHAN_INFO_SCALE.

> +		*val = raw;
> +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED: {

Unusual to have both raw and processed. What is the motivation?

> +		*val = raw * chan->address;
> +		ret = IIO_VAL_INT;

Why not use IIO_VAL_INT_PLUS_MICRO and not lose information?

> +
> +		/*
> +		 * Voltage measurements are scaled into uV. Scale them back
> +		 * into the mV dimension.
> +		 */
> +		if (chan->type == IIO_VOLTAGE)
> +			*val = DIV_ROUND_CLOSEST(*val, 1000);
> +
> +		dev_dbg(&iio->dev, "chan: %d, raw: %d, processed: %d\n", chan->channel, raw, *val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}

Brace should be before default:.

> +	}
> +
> +out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +static int pm886_gpadc_setup(struct regmap *map, bool enable)
> +{
> +	const u8 config[] = {0xff, 0xfd, 0x1};

IIRC, IIO subsystem prefers spaces around the braces.

			{ 0xff, 0xfd, 0x1 };

Also, could use some macros to explain what these values are.


> +	int ret;
> +
> +	/* Enable/disable the ADC block */
> +	ret = regmap_assign_bits(map, PM886_REG_GPADC_CONFIG6, BIT(0), enable);
> +	if (ret || !enable)
> +		return ret;
> +
> +	/* If enabling, enable each individual ADC */
> +	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG1, config, ARRAY_SIZE(config));
> +}
> +
> +static const struct iio_info pm886_gpadc_iio_info = {
> +	.read_raw = pm886_gpadc_read_raw,
> +};
> +
> +static int pm886_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev, *parent = dev->parent;

Move parent to separate lne.

> +	struct pm886_chip *chip = dev_get_drvdata(parent);
> +	struct i2c_client *client = chip->client, *page;

Move page to separate line.

> +	struct regmap **map;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*map));
> +	if (!iio)
> +		return -ENOMEM;

Add blank line.

> +	map = iio_priv(iio);
> +
> +	dev_set_drvdata(dev, iio);
> +
> +	page = devm_i2c_new_dummy_device(dev, client->adapter,
> +					 client->addr + PM886_PAGE_OFFSET_GPADC);
> +	if (IS_ERR(page))
> +		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC page\n");
> +
> +	*map = devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
> +	if (IS_ERR(*map))
> +		return dev_err_probe(dev, PTR_ERR(*map),
> +				     "Failed to initialize GPADC regmap\n");
> +
> +	iio->name = "88pm886-gpadc";
> +	iio->dev.parent = dev;
> +	iio->dev.of_node = parent->of_node;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &pm886_gpadc_iio_info;
> +	iio->channels = pm886_adc_channels;
> +	iio->num_channels = ARRAY_SIZE(pm886_adc_channels);
> +
> +	devm_pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register ADC\n");
> +
> +	return 0;
> +}
> +
> +static int pm886_gpadc_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *iio = dev_get_drvdata(dev);
> +	struct regmap **map = iio_priv(iio);
> +
> +	return pm886_gpadc_setup(*map, true);
> +}
> +
> +static int pm886_gpadc_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio = dev_get_drvdata(dev);
> +	struct regmap **map = iio_priv(iio);
> +
> +	return pm886_gpadc_setup(*map, false);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(pm886_gpadc_pm_ops,
> +				 pm886_gpadc_runtime_suspend,
> +				 pm886_gpadc_runtime_resume, NULL);
> +
> +static const struct platform_device_id pm886_gpadc_id[] = {
> +	{ "88pm886-gpadc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, pm886_gpadc_id);
> +
> +static struct platform_driver pm886_gpadc_driver = {
> +	.driver = {
> +		.name = "88pm886-gpadc",
> +		.pm = pm_ptr(&pm886_gpadc_pm_ops),
> +	},
> +	.probe = pm886_gpadc_probe,
> +	.id_table = pm886_gpadc_id,
> +};
> +module_platform_driver(pm886_gpadc_driver);
> +
> +MODULE_AUTHOR("Duje Mihanović <duje@dujemihanovic.xyz>");
> +MODULE_DESCRIPTION("Marvell 88PM886 GPADC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 24f2572c487ea3db2abec3283ebd93357c08baab..708a4f9b7b70b5044d070a8526a014c4bd362a10 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -9,6 +9,16 @@ menu "Analog to digital converters"
>  config IIO_ADC_HELPER
>  	tristate
>  
> +config 88PM886_GPADC
> +	tristate "Marvell 88PM886 GPADC driver"
> +	depends on MFD_88PM886_PMIC
> +	default y
> +	help
> +	  Say Y here to enable support for the GPADC (General Purpose ADC)
> +	  found on the Marvell 88PM886 PMIC. The GPADC measures various
> +	  internal voltages and temperatures, including (but not limited to)
> +	  system, battery and USB.
> +
>  config AB8500_GPADC
>  	bool "ST-Ericsson AB8500 GPADC driver"
>  	depends on AB8500_CORE && REGULATOR_AB8500
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1c6ca5fd4b6db8c4c40a351b231ba0892e8cd70e..64854907bf3bef7da39f95247e4e502d01232af3 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_88PM886_GPADC) += 88pm886-gpadc.o
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD4000) += ad4000.o
> diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
> index 85eca44f39ab58ba4cb9ec4216118ee9604d021f..44675f762ce6865dd6053b1aed00cc5987a7d5a2 100644
> --- a/include/linux/mfd/88pm886.h
> +++ b/include/linux/mfd/88pm886.h
> @@ -10,6 +10,7 @@
>  #define PM886_IRQ_ONKEY			0
>  
>  #define PM886_PAGE_OFFSET_REGULATORS	1
> +#define PM886_PAGE_OFFSET_GPADC		2
>  
>  #define PM886_REG_ID			0x00
>  
> @@ -67,6 +68,35 @@
>  #define PM886_REG_BUCK4_VOUT		0xcf
>  #define PM886_REG_BUCK5_VOUT		0xdd
>  
> +/* GPADC enable/disable registers */
> +#define PM886_REG_GPADC_CONFIG1		0x1
> +#define PM886_REG_GPADC_CONFIG2		0x2
> +#define PM886_REG_GPADC_CONFIG3		0x3
> +#define PM886_REG_GPADC_CONFIG6		0x6

Could just write this as:

#define PM886_REG_GPADC_CONFIG(n)		(n)

> +
> +/* GPADC bias current configuration registers */
> +#define PM886_REG_GPADC_CONFIG11	0xb
> +#define PM886_REG_GPADC_CONFIG12	0xc
> +#define PM886_REG_GPADC_CONFIG13	0xd
> +#define PM886_REG_GPADC_CONFIG14	0xe
> +#define PM886_REG_GPADC_CONFIG20	0x14

which covers these too.

Most of these aren't used anyway.

Also suspicious that there are 5 registers listed here
but only 4 channels for resistance.

> +
> +/* GPADC channel registers */
> +#define PM886_REG_GPADC_VSC		0x40
> +#define PM886_REG_GPADC_VCHG_PWR	0x4c
> +#define PM886_REG_GPADC_VCF_OUT		0x4e
> +#define PM886_REG_GPADC_TINT		0x50
> +#define PM886_REG_GPADC_GPADC0		0x54
> +#define PM886_REG_GPADC_GPADC1		0x56
> +#define PM886_REG_GPADC_GPADC2		0x58
> +#define PM886_REG_GPADC_VBAT		0xa0
> +#define PM886_REG_GPADC_GNDDET1		0xa4
> +#define PM886_REG_GPADC_GNDDET2		0xa6
> +#define PM886_REG_GPADC_VBUS		0xa8
> +#define PM886_REG_GPADC_GPADC3		0xaa
> +#define PM886_REG_GPADC_MIC_DET		0xac
> +#define PM886_REG_GPADC_VBAT_SLP	0xb0
> +
>  #define PM886_LDO_VSEL_MASK		0x0f
>  #define PM886_BUCK_VSEL_MASK		0x7f
>  
> 


