Return-Path: <linux-iio+bounces-18873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D485AA1B3F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6011BC2DF4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335525E459;
	Tue, 29 Apr 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RAqhcm37"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3BD22F3B0
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954161; cv=none; b=OWFoeufclpiD89VasgUfd5X7uDpbRwx9jBE6LP3fr5nxvG/Rc8XtGh1biGdY95oqGTz+0RQ6jOqUJTZt4rbgN92sLD06EGeUW+OxSN6ho3xNMLKffWkaD6khP2X47GjOoHNvQYvQ+nVQQ1Z/8a40q6mMKG583oUAnvwPl90rZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954161; c=relaxed/simple;
	bh=bMZOleK80Yvw/vJXeWTT91vA++6Iw6ZoCDHLPzkZDFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OikgSZw8y7SCpKdI36owTGxfm1MyNFqE7PiucYF3PyztlOprKOuqUDk399DiSsgkOghEawyl5DR+IZe6li4WvTMCaZ53loXxXoliPSR8/Syq4pTpV4J68YG7rFwFfRXZ20P2v4DO4Tx99UxSL3OHl6F5V3n1sMigYghlt9OS5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RAqhcm37; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72ecb4d9a10so3817077a34.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745954157; x=1746558957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztvL+716FaAHmBwWQZbrSXde86/hu3vO5ILRMzMnPzo=;
        b=RAqhcm37b0sTqrTUsmNrm3fynIE7RDwquvGsw+FmGCD8fjlbJeJXqdSzgYIa0JdVmL
         f+7CglXACRwOPYMoCah4/TqsyTCe1aIFbMCEZ95J8ADWMZnUfNpuMhZVcekd5ZRqWx01
         0FqWYD8tfTrj2IovuMWAJG+mqKoyRBk7/nRiMyzKfg4mlPELPRIQSJIFFHGqR21bDdqS
         C3juVcyc9gDnf4VP9dNs7YLiHTmNFUQhl7VRnPGPpMgOeLi8mPImNVNKqX6JysoS/DUK
         hdXJYmMGwPiyOmNMmOIB/Sch2H8KaFewg9b8nITAm0kv/9E5uMx1XOWxNnDgbUmTv4NF
         sSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745954157; x=1746558957;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztvL+716FaAHmBwWQZbrSXde86/hu3vO5ILRMzMnPzo=;
        b=oKAn7m4nECR9D4IlzWU5EvlwBHilo6+bKIFMeLoFcpCdVTLA1ZX1uqlOiYYWCYfSU4
         9MbNE1CmUdsPnOk7X21pBlo/NUHW150jFCOMnReQQBWlaM+A2nKZHdoKNoXCHMf/syZa
         D0FFbWnO7nszFTuP5TtMe1R2lM/cAw3IHcT7Mufw3mQzhNO0jqMG+J0RAlSFwwyBuXpJ
         SsKzbIyIItq9Gd3v7Kam91NDRKfFjJy37g723hueH1pNTwBoT72CfvPD4jaV3urXsS9Q
         z2ESYSX0CK2V4zvOdeEOm25Z18Sqv8ZOwOmsalCs/ALkOR19RqR92wRzUD4E7RAdiwBg
         RMfA==
X-Forwarded-Encrypted: i=1; AJvYcCW3UkyJK7eNy73h3j7v5scD98b+D1exVGV6B2/8mrZ9stjRkB9Z2Gvdm0+4DHNyY5mGbgiLO3/O9+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTO1O8hM00xGv/YLxGei/MtPXRCLmwJUEMllFLWD2J4BCYsQ0e
	j355uZc9Gi0E07rRXlG5Aycaw6vPwx/ARIKxOoxu51kHLVO5Tl9WavLVh5JgrcM=
X-Gm-Gg: ASbGnct6hI+AmAw3U8Q4gqW8LoLFX7603izbmCVNm/MGNoxhQR0yhui0kEb12Qrh1am
	kgrn86vm6S56QjSGdqTYdLOYKSmueeKEViZ/YOlHts1urBSkDA/OIMztPxDtLAmJwnqjm4HG1rF
	Srfp0Fo5hPH+l3UogbiNThSNsOL1bgWEwxLWrMWvNm7g6fllJOR6U1y/OGyz5E/myZbkqRSyJIT
	2tvJa1dahWXkZVi6FJiBmP6oQ6zXCcbw98XLfk9gDaeMwYhcVHX6Xoy3dx9ORgaflhO+mn0Q0F1
	spKB1IAK2Ugd2HihVPCwqiyAd8EpWIDOJf4koY1FzaBrK0J+YcyIbY+ulqiDV8TPG0StFvWA+X+
	PyhiBNXyJmWspf7X4uw==
X-Google-Smtp-Source: AGHT+IGvZemKy7Uu0DSwIzSG0ACYUFe1P1N94h9CcheOZQJFt2fLRO+XJODUBk7ZcGahCzF4hFasJg==
X-Received: by 2002:a05:6830:670c:b0:72b:9d2d:804 with SMTP id 46e09a7af769-731c0ab48e8mr311490a34.26.1745954156996;
        Tue, 29 Apr 2025 12:15:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b2ef3e5sm440104a34.46.2025.04.29.12.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 12:15:55 -0700 (PDT)
Message-ID: <27e40c72-7c3a-4595-8647-5fd1f428ea9f@baylibre.com>
Date: Tue, 29 Apr 2025 14:15:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] iio: adc: ad4080: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
 <20250425112538.59792-12-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250425112538.59792-12-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 6:25 AM, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/clk.h>

Should be grouped with the others.

> +
> +/* Register Definition */

...

> +
> +enum ad4080_filter_type {
> +	FILTER_DISABLE,
> +	SINC_1,
> +	SINC_5,
> +	SINC_5_COMP
> +};
> +
> +static const unsigned int ad4080_scale_table[][2] = {
> +	{ 6000, 0},
> +};
> +
> +static const char *const ad4080_filter_type_iio_enum[] = {

So far, only "sinc5" is documented in Documentation/ABI/testing/sysfs-bus-iio
so we will to add the rest there.

> +	[FILTER_DISABLE]   = "disabled",

IMHO, "disabled" doesn't make sense as a "type". I would call it "none" instead.

> +	[SINC_1]           = "sinc1",
> +	[SINC_5]           = "sinc5",
> +	[SINC_5_COMP]      = "sinc5_plus_compensation",

To follow the existing naming patterns it would make sense to call this one:

"sinc5+compensation" - Sinc5 + ???

Or even more generic like the existing sinc3+pfX options:

"sinc5+pf1" - Sinc5 + device specific Post Filter 1.

> +};
> +
> +static const int ad4080_dec_rate_iio_enum[] = {
> +	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
> +};

The datasheet says that 512 and 1024 only apply to sinc1 and that for
sinc5+compensation, the values are N * 2. And I would assume with the filter
disabled, the only option would be 1.

So I think we need 4 different arrays for this with the selection depending
on the filter type.

> +
> +static const char * const ad4080_power_supplies[] = {
> +	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
> +};

From the datasheet, it sounds like VDDLDO is tecnically optional. Given the
way regulators work in Linux though, I guess this is OK for simplicity.

> +
> +struct ad4080_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	const unsigned int (*scale_table)[2];
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};

I guess this is preparing the driver to support more than one chip?

> +
> +struct ad4080_state {
> +	struct spi_device		*spi;

It looks like this is only ever used to get &spi->dev. We could drop this and
get dev from regmap instead.

> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	struct iio_backend		*back;
> +	const struct ad4080_chip_info	*info;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex			lock;
> +	unsigned int			num_lanes;
> +	unsigned int			dec_rate;
> +	enum ad4080_filter_type		filter_type;
> +	bool				lvds_cnv_en;
> +};
> +
> +static const struct regmap_config ad4080_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +	.max_register = 0x29,
> +};
> +
> +static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +

Missing guard(mutex)(&st->lock); ?

> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
> +{
> +	unsigned int tmp;
> +
> +	tmp = (st->info->scale_table[0][0] * 1000000ULL) >>
> +		    st->info->channels[0].scan_type.realbits;
> +	*val = tmp / 1000000;
> +	*val2 = tmp % 1000000;
> +
> +	return IIO_VAL_INT_PLUS_NANO;

Seems like this could be simplifed by using IIO_VAL_FRACTIONAL_LOG2 instead.

> +}
> +
> +static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int data;
> +

Missing guard(mutex)(&st->lock); ?

> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	return (1 << (FIELD_GET(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK, data) + 1));

nit: doen't need outermost ().

> +}
> +
> +static int ad4080_set_dec_rate(struct iio_dev *dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int mode)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	int ret;
> +

Don't we need to check for < 2 as well?

> +	if (st->filter_type >= SINC_5 && mode >= 512)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	ret = regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +				 AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> +				 FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> +					    (ilog2(mode) - 1)));

Otherwise ilog2(mode) - 1 could be < 0.

> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate = mode;

This saves the value the user entered, not what the hardware is actually doing.
It should be saving the power of 2 value instead.

> +
> +	return 0;
> +}
> +
> +static int ad4080_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long m)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	int dec_rate;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4080_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (st->filter_type == SINC_5_COMP)
> +			dec_rate = st->dec_rate * 2;
> +		else
> +			dec_rate = st->dec_rate;

As a concequence of the above, this will return incorrect information if the
user didn't enter an exact value.

> +		if (st->filter_type)
> +			*val = DIV_ROUND_CLOSEST(clk_get_rate(st->clk), dec_rate);
> +		else
> +			*val = clk_get_rate(st->clk);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = ad4080_get_dec_rate(indio_dev, chan);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return -EINVAL;

Can leave these 2 out and just let them fall through to the default.

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4080_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{
> +	unsigned int timeout = 100;
> +	bool sync_en;
> +	int ret;

nit: some comments in this function would be helpful to readers not familiar
with the part. 

> +
> +	guard(mutex)(&st->lock);
> +	if (st->num_lanes == 1)
> +		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK);
> +	else
> +		ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK |
> +				   AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_data_alignment_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		ret = iio_backend_sync_status_get(st->back, &sync_en);
> +		if (ret)
> +			return ret;
> +
> +		if (!sync_en)
> +			dev_dbg(&st->spi->dev, "Not Locked: Running Bit Slip\n");
> +
> +		fsleep(500);
> +	} while (--timeout && !sync_en);
> +
> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and Locked!\n");
> +		if (st->num_lanes == 1)
> +			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					    AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK);
> +		else
> +			return regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					    AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +					    AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> +		if (st->num_lanes == 1) {
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = regmap_write(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					   AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +					   AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return -ETIMEDOUT;
> +	}
> +}
> +
> +static ssize_t ad4080_get_filter_type(struct iio_dev *dev,
> +				      const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	unsigned int data;
> +	int ret;
> +

Missing guard(mutex)(&st->lock); ?

> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(AD4080_FILTER_CONFIG_FILTER_SEL_MSK, data);
> +}
> +

...

> +static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad4080_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			   &ad4080_filter_type_enum),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec ad4080_channels[] = {

Array with one element doesn't make sense. It can just be a single struct.

> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.ext_info = ad4080_ext_info,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 20,
> +			.storagebits = 32,
> +			.shift = 0,
> +		},
> +	}
> +};
> +
> +static const struct ad4080_chip_info ad4080_chip_info = {
> +	.name = "AD4080",
> +	.product_id = AD4080_CHIP_ID,
> +	.scale_table = ad4080_scale_table,
> +	.num_scales = ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels = 1,
> +	.channels = ad4080_channels,
> +};
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned int id;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			   AD4080_INTERFACE_CONFIG_A_SW_RESET_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AD4080_CHIP_ID)
> +		dev_info(&st->spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +
> +	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +			      AD4080_GPIO_CONFIG_A_GPO_1_EN_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +			   FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL, 3));
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->lvds_cnv_en)
> +		return 0;
> +
> +	if (st->num_lanes) {

Since the defualt is st->num_lanes = 1, it seems like this would always be
true, so we can leave out the "if".

> +		ret = regmap_update_bits(st->regmap,
> +					 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +					 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> +					 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> +						    7));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_set_bits(st->regmap,
> +			      AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			      AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN_MSK);
> +	if (ret)
> +		return ret;
> +
> +	return ad4080_lvds_sync_write(st);
> +}
> +
> +static void ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	st->lvds_cnv_en = device_property_read_bool(&st->spi->dev,
> +						    "adi,lvds-cnv-enable");
> +
> +	st->num_lanes = 1;
> +	device_property_read_u32(&st->spi->dev, "adi,num_lanes", &st->num_lanes);

nit: odd that other property names use "-" but this one uses "_". Typical would
be "adi,num-lanes".

> +}
> +
> +static int ad4080_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	struct ad4080_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad4080_power_supplies),
> +					     ad4080_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;

reduandant assignement

> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = st->info->channels;
> +	indio_dev->num_channels = st->info->num_channels;
> +	indio_dev->info = &ad4080_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;

There is not IIO_CHAN_INFO_RAW (or _PROCESSED), so INDIO_DIRECT_MODE does not
apply.

> +
> +	ad4080_properties_parse(st);
> +
> +	st->clk = devm_clk_get_enabled(&spi->dev, "cnv");
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4080_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

