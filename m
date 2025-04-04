Return-Path: <linux-iio+bounces-17628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB56A7C2CF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B991B61178
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DF21930D;
	Fri,  4 Apr 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hs2AZ0EN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637F18FC92
	for <linux-iio@vger.kernel.org>; Fri,  4 Apr 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788918; cv=none; b=E2vcFjsQcky3LS8KplUUrguYRLp+mXmxuBnpPHydv7DUjbbiOermv/c6stN/Usow4NSP6xAggiU36uz1C0Dn6CmAjcWYdxrz3evht4RYJp/brYSIpwJBDhVfN7joxniCaGSvWMlT4XNDBieSV8Y2BhxmdFBxVfglvXLrdOhU+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788918; c=relaxed/simple;
	bh=a7gWH2nkFeOsDGvRh7sMqCcn7di8a5/TuweiIDdEAJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKqCko+Kd7rOiLalR3jB+849K0QsHHBflQPf/VnXx9ygH0Zu++jq+v98xawBzI/o5GSw+DcdhzGSdqbH10TfM2ORhiXs6Xd29Ic5LWtPGKGXmW61T3ftWZpltP+qNnd9PQx4sxEwkmvha05Ue+qGh2KHvt4ca9JXZPQx6FZOdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hs2AZ0EN; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fe83c8cbdbso721942b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Apr 2025 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788915; x=1744393715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvY/WWNlUB6k/evBE4GY6Felovk+eaQUcXiraaY6y74=;
        b=hs2AZ0ENN8R6LMo7idEt9/okS+usW6gqmZ/KjwBIiPQtTDCIZtXVPOblAXo1rO+Ey5
         P+di0LWGRc0NL/q4nMb+X6su/YS/NavZ9E+afnTxFZKFfvQURYhQEEUg2aQ5oc2FumFw
         ggC+0klEcjCkonyTCzcL9BQ/S0wTzGwW8pQpmRy1+rWq7fbHnajWQgNQYXqvqhcT7f4j
         fRuTOXNWf7xYJzGtKb52E1ArGeOeC4ZJFzUrhjyhiJIg2ug0Uv5/OXFkE4t0Ae3bKIl5
         Fl1ws/Ku0cS0PyRkmFDnTUOzCg2BR45FXF0ymOl5dmHXvhMQAN3pL5tle4QhPCaXWZG6
         xwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788915; x=1744393715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvY/WWNlUB6k/evBE4GY6Felovk+eaQUcXiraaY6y74=;
        b=WszXe0Af54u0eR3UZLzcCZBNwYkbCpKQPZyduDtXO0CyW6YuLbJvVwTi4522TSjkhk
         /PvzWRtdalB72yAHftQrRkhwR0TwJP2lD9K3TUcMfjWwCSeZ6YddpKiZ9JSEEGDCIClN
         mxF3PwlKfp2dXv0mMJLKfAcs+Ta+ZFgYrZmz+AH6KnSkfQFl/OV1QjHm1rZ9WS4oFGSm
         ynDIV2pp9EuMHboc1QVYXTqA88W3Qnw1WrUvhrxbIoxgxBu9yeMISwdm6flpwFHgbLZF
         EYnyKSoXjw+BbcJedb5koAMKZagQBNeJr+T0JQvIZBrb4NNyqA2ASglrL5UW7oO74XWT
         J3uQ==
X-Gm-Message-State: AOJu0Yy86WI9tXEWQCRIrmzUf+RLLCvQO1g1GykkW/f7JMNruz0oM1HJ
	jRPUejd28unjatHsge8vUisBpUW96iDMtXeBRvW0onPWOFtkHaDYZHNRGarrMzA=
X-Gm-Gg: ASbGncvlvpfHAl99VCAtYCfU3QcYTqJ/aXY0mo37JGpG2dGsUfoOJ9I/lK2toa+clCq
	kTDGCSe+Xm9UPkooEBGKdk4X9jG73t3Zf/kRVZ4BTn416R6inhAMK5zRCGmnvtOeEc7R4dia2iW
	3ENLUjHo2c2kYTItqT/W7indMyZEVrLkh5IyV18/W1vggAiA+mKf2ist/IEKBv5/EbQ+8kcpIFe
	UmPbPZeE0Z+4F2Xo2WdlKNMZijk2ZtcqEglpntrw0IHJbMB1wChzn2NLwfOzr7MG+CmKTgPRMg0
	ecoZWp0556JOyEfaAM/A6ArrAZwdY7Pztao7FlSz6hnXAlvOIa5pU477t3VcqAu2HjOlT7VAIRx
	ZTRDQ8g==
X-Google-Smtp-Source: AGHT+IHqN/zEntunmQti7QvdnI+zzlxqeFja7+5qeHzwZxJcenPeVZY1WnD3J92Ab5TIEbOJlcUA3g==
X-Received: by 2002:a05:6808:199c:b0:3fa:51c5:d9a7 with SMTP id 5614622812f47-400455970b9mr1550054b6e.10.1743788915363;
        Fri, 04 Apr 2025 10:48:35 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4003ff99759sm686880b6e.21.2025.04.04.10.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 10:48:33 -0700 (PDT)
Message-ID: <fd2116bd-b0e2-4db4-97ff-1a1e88545413@baylibre.com>
Date: Fri, 4 Apr 2025 12:48:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
To: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/25 12:33 AM, Kim Seer Paller wrote:
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/°C internal reference, which is disabled
> by default.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

...

> +#define AD3530R_INTERFACE_CONFIG_A		0x00
> +#define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
> +#define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
> +#define AD3530R_OUTPUT_CONTROL_0		0x2A
> +#define AD3530R_REFERENCE_CONTROL_0		0x3C
> +#define AD3530R_SW_LDAC_TRIG_A			0xE5
> +#define AD3530R_INPUT_CH(c)			(2 * (c) + 0xEB)
> +
> +#define AD3531R_SW_LDAC_TRIG_A			0xDD
> +#define AD3531R_INPUT_CH(c)			(2 * (c) + 0xE3)
> +
> +#define AD3530R_SW_LDAC_TRIG_MASK		BIT(7)
> +#define AD3530R_OUTPUT_CONTROL_MASK		BIT(2)
> +#define AD3530R_REFERENCE_CONTROL_MASK		BIT(0)
> +#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
> +
> +#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
> +#define AD3530R_MAX_CHANNELS			8
> +#define AD3531R_MAX_CHANNELS			4
> +#define AD3530R_CH(c)				(c)
> +#define AD3530R_32KOHM_POWERDOWN_MODE		3
> +#define AD3530R_INTERNAL_VREF_MV		2500
> +#define AD3530R_LDAC_PULSE_US			100
> +
> +struct ad3530r_chan {
> +	unsigned int powerdown_mode;

IMHO, code would be easier to understand if this was an enum.

> +	bool powerdown;
> +};
> +
> +struct ad3530r_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	int (*input_ch_reg)(unsigned int c);
> +	const int iio_chan;
> +	unsigned int num_channels;
> +	unsigned int sw_ldac_trig_reg;
> +	bool internal_ref_support;
> +};
> +
> +struct ad3530r_state {
> +	struct regmap *regmap;
> +	/* lock to protect against multiple access to the device and shared data */
> +	struct mutex lock;
> +	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
> +	const struct ad3530r_chip_info *chip_info;
> +	struct gpio_desc *ldac_gpio;
> +	int vref_mv;
> +	u8 ldac;
> +	bool range_multiplier;

nit: call this has_range_multiplier or change to u8 and save the actual multipler value here.

> +};
> +

...

> +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int mask, val;
> +	bool powerdown;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	switch (chan->channel) {
> +	case AD3530R_CH(0) ... AD3530R_CH(AD3531R_MAX_CHANNELS - 1):

Switch seems hard to read and not needed since there aren't any gaps.

	if (chan->channel < AD3531R_MAX_CHANNELS)

shoud work, no?


> +		mask = GENMASK(chan->channel * 2 + 1, chan->channel * 2);

Could use the chan->address field to hide the calucation a bit.

> +		val = (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
> +		      << (chan->channel * 2);

I saw a series that proposed a non-const field_prep function recently. Not sure
that made it through the bikeshedding though. Could be nice to hide some of this
in a macro for readability if that isn't available.

> +
> +		ret = regmap_update_bits(st->regmap,
> +					 AD3530R_OUTPUT_OPERATING_MODE_0,
> +					 mask, val);
> +		if (ret)
> +			return ret;
> +
> +		st->chan[chan->channel].powerdown = powerdown;
> +		return len;
> +	case AD3530R_CH(AD3531R_MAX_CHANNELS) ...
> +	     AD3530R_CH(AD3530R_MAX_CHANNELS - 1):
> +		mask = GENMASK((chan->channel - 4) * 2 + 1,
> +			       (chan->channel - 4) * 2);
> +		val = (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
> +		      << ((chan->channel - 4) * 2);
> +
> +		ret = regmap_update_bits(st->regmap,
> +					 AD3530R_OUTPUT_OPERATING_MODE_1,
> +					 mask, val);
> +		if (ret)
> +			return ret;
> +
> +		st->chan[chan->channel].powerdown = powerdown;
> +		return len;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
> +{
> +	gpiod_set_value_cansleep(ldac_gpio, 1);
> +	fsleep(AD3530R_LDAC_PULSE_US);
> +	gpiod_set_value_cansleep(ldac_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
> +			     unsigned int val)
> +{
> +	int ret;
> +	__be16 reg_val;
> +
> +	guard(mutex)(&st->lock);
> +	reg_val = cpu_to_be16(val);
> +
> +	ret = regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
> +				&reg_val, sizeof(reg_val));
> +	if (ret)
> +		return ret;
> +
> +	if (st->ldac_gpio)
> +		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
> +
> +	return regmap_update_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
> +				  AD3530R_SW_LDAC_TRIG_MASK,
> +				  FIELD_PREP(AD3530R_SW_LDAC_TRIG_MASK, 1));

Can be simplifed with regmap_set_bits().


> +}
> +
> +static int ad3530r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	int ret;
> +	__be16 reg_val;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(st->regmap,
> +				       st->chip_info->input_ch_reg(chan->channel),
> +				       &reg_val, sizeof(reg_val));
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(reg_val));
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = 16;

This needs to take into account the range multipler.

> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
> +	AD3530R_CHAN_EXT_INFO("powerdown", 0, IIO_SEPARATE,
> +			      ad3530r_get_dac_powerdown,
> +			      ad3530r_set_dac_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3530r_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad3530r_powerdown_mode_enum),
> +	{ },

iio style is no trailing comma on sentinil  

	{ }

> +};
> +

...

> +static int ad3530r_setup(struct ad3530r_state *st)
> +{
> +	const struct ad3530r_chip_info *chip_info = st->chip_info;
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct gpio_desc *reset_gpio;
> +	int i, ret;
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* Perform hardware reset */
> +		fsleep(1000);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		/* Perform software reset */
> +		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(10000);
> +
> +	/* Set operating mode to normal operation. */
> +	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (chip_info->num_channels > AD3531R_MAX_CHANNELS) {
> +		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < chip_info->num_channels; i++)
> +		st->chan[i].powerdown_mode = AD3530R_32KOHM_POWERDOWN_MODE;
> +
> +	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->ldac_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> +				     "Failed to get ldac GPIO\n");
> +
> +	if (device_property_present(dev, "adi,double-output-range")) {

This is not documented in the DT bindings.

This could instead be implemented by making the out_voltage_scale attribute
writeable.

If we really do need it in the devicetree because we want to protect against
someone accidentally setting it too high, then the property should be the
actual multipler value with an enum specifier of 1, 2 and a default of 1
rather than a flag (e.g. adi,output-multipler).

> +		st->range_multiplier = true;
> +
> +		return regmap_update_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
> +					  AD3530R_OUTPUT_CONTROL_MASK,
> +					  FIELD_PREP(AD3530R_OUTPUT_CONTROL_MASK, 1));

nit: can be simplified with regmap_set_bits().

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config ad3530r_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,

Should have at least a .max_register.

.reg_read and .reg_write tables can make debuging easier too.

> +};
> +
> +static const struct iio_info ad3530r_info = {
> +	.read_raw = ad3530r_read_raw,
> +	.write_raw = ad3530r_write_raw,
> +	.debugfs_reg_access = &ad3530r_reg_access,

nit: style is not consistent - can omit &.

> +};
> +
> +static int ad3530r_probe(struct spi_device *spi)
> +{
> +	static const char * const regulators[] = { "vdd", "iovdd" };
> +	const struct ad3530r_chip_info *chip_info;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad3530r_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad3530r_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to init regmap");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENODEV;
> +
> +	st->chip_info = chip_info;

nit: local variable isn't that useful since st->chip_info is short enough.

> +
> +	ret = ad3530r_setup(st);
> +	if (ret)
> +		return ret;

Setting up the chip before turning on power would not work well if the
regulators are actually controlled. :-)

> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0 && ret != -ENODEV)
> +		return ret;
> +
> +	if (chip_info->internal_ref_support && ret == -ENODEV) {
> +		/* Internal reference. */
> +		ret = regmap_update_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> +					 AD3530R_REFERENCE_CONTROL_MASK,
> +					 FIELD_PREP(AD3530R_REFERENCE_CONTROL_MASK, 1));
> +		if (ret)
> +			return ret;
> +
> +		st->vref_mv = st->range_multiplier ?
> +			      2 * AD3530R_INTERNAL_VREF_MV :
> +			      AD3530R_INTERNAL_VREF_MV;
> +	} else {
> +		st->vref_mv = st->range_multiplier ? 2 * ret / 1000 : ret / 1000;

ret can be -ENODEV here if !chip_info->internal_ref_support

> +	}> +
> +	indio_dev->name = chip_info->name;
> +	indio_dev->info = &ad3530r_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = chip_info->channels;
> +	indio_dev->num_channels = chip_info->num_channels;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +

