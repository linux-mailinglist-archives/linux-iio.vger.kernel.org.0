Return-Path: <linux-iio+bounces-123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83D7EE521
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 17:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E49CB20D13
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25242FC2E;
	Thu, 16 Nov 2023 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPIPizUu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82A4D50;
	Thu, 16 Nov 2023 08:25:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso14603421fa.0;
        Thu, 16 Nov 2023 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700151942; x=1700756742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OV4V5EcSwk6Sr7QObCUhY0l4eB9jqEOeHbasojNYrvs=;
        b=XPIPizUus+Un/1Qf2BmCb10WEFaJYlJuGW61hI+PdNOeJsVwW1RUkJXT4TfCNUYg5z
         RuLonCTYcEU3jJdxWNJkGmXNMIleUFTV0ZRvu5a65o+kmGzPdE1XvtjX2i4qCZnZhJY3
         WITNyrB3KcQq+uvulTtppQO+leRfVt0SFtA3sxMHvOx63l8ThK7O131g+W2d2WMaW2//
         JxFUQV6vVMoM62l1OKYwfbsWNxSdyrqkhLVbQ+vsSyK5i09oDVkWWecq58U1uzRzm3Fm
         xqjEdZshlLy3lim9zQdWfpSuxhwgn+RoBhZsVaQf1Yp7O0k5aXWU2AC+M47D54L8eQj/
         W56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151942; x=1700756742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV4V5EcSwk6Sr7QObCUhY0l4eB9jqEOeHbasojNYrvs=;
        b=KA8TWK9ZkmaUctvgREnp3Il66bFeyDkLRUgYLSp39YA8C0iVVCfmQFq2LzDYPTqAmZ
         1wXZsM4o9LMieZFw1YpXTVOzh44W0oBjRLb8TtiROXAfZxO54cXIyi0YJE8J8cfJiK/p
         gqZjDHbjhkzvUzuT8Jql2zmhVDZf2exBHU6N49xlS0Ftkdpov2qBQrIhvHsI5nvnCdNq
         f8bf3wnZNS8S+iWy+hmUqM5iTme2Q7jqChLZPkAmUfzRpVEYUzRM7xajokuTAwzJb2Yh
         ldZPSXjoJl2lcwIbxjqGHBgFMn75NO6OO1xy0uiSIL41IypoPVyvJJshFLLEliHxc23i
         lMzQ==
X-Gm-Message-State: AOJu0YyfAZZNEs2KUVMgmRPQLqt7gYjI46k/hJs5YkaT7kuSLeBh4b9x
	R/5jD+1aBqsH1ozKDgPLnpY=
X-Google-Smtp-Source: AGHT+IEpn54+060Z+kRCSsgoSNAXcc6pfpQsB4R88OXPsCwrKO40kO+oxtuoXL31Km2DZDlNfzcXAg==
X-Received: by 2002:a05:6512:1087:b0:507:b7db:1deb with SMTP id j7-20020a056512108700b00507b7db1debmr15345490lfg.38.1700151941662;
        Thu, 16 Nov 2023 08:25:41 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id i7-20020a198c47000000b00507a66f747csm39130lfj.30.2023.11.16.08.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 08:25:40 -0800 (PST)
Message-ID: <493c138c-ca67-4244-bcd7-c1c3d596048d@gmail.com>
Date: Thu, 16 Nov 2023 18:25:39 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US, en-GB
To: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231116131329.6801-1-marex@denx.de>
 <20231116131329.6801-2-marex@denx.de>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231116131329.6801-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho Marek,

Long time no chat :/

On 11/16/23 15:13, Marek Vasut wrote:
> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Andre Werner <andre.werner@systec-electronic.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: Naresh Solanki <naresh.solanki@9elements.com>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> Cc: Vincent Tremblay <vincent@vtremblay.dev>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> NOTE: I am not 100% sure about the SCALE handling, can you please
>        check esp. that one ? Thanks !


I checked the data-sheet. Please correct me if I am wrong - I did only a 
quick read.

To me it seems there are 16bit LSB data registers and 4 supported scales.

I assume the data register value 0 means measurement was not done - but 
rest of the values are computed as if the 0 would mean 0 Lx - and 
register values then grow linearly from that up-to the range max.

Hence, the most sensitive range is from 0 Lx to 1000 Lx. The full 16bit 
value being 1000 Lx. For this range, the scaling should thus be
1000 / 0xFFFF (1000 being decimal).


> +enum isl76682_als_ir_mode {
> +	ISL76682_MODE_NONE = 0,
> +	ISL76682_MODE_ALS,
> +	ISL76682_MODE_IR,
> +};
> +
> +struct isl76682_chip {
> +	struct mutex			lock;
> +	struct regmap			*regmap;
> +	enum isl76682_als_ir_mode	als_ir_mode;
> +	int				lux_scale;
> +};
> +
> +static int isl76682_set_als_scale(struct isl76682_chip *chip, int lux_scale)
> +{
> +	int ret, val;
> +

Would renaming the lux_scale to lux_range make it clearer? I think the 
scale is really lux_scale/MAX_DATA_REG_VAL

> +	if (lux_scale == 1000)
> +		val = ISL76682_COMMAND_RANGE_LUX_1K;
> +	else if (lux_scale == 4000)
> +		val = ISL76682_COMMAND_RANGE_LUX_4K;
> +	else if (lux_scale == 16000)
> +		val = ISL76682_COMMAND_RANGE_LUX_16K;
> +	else if (lux_scale == 64000)
> +		val = ISL76682_COMMAND_RANGE_LUX_64K;
> +	else
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(chip->regmap, ISL76682_REG_COMMAND,
> +				 ISL76682_COMMAND_RANGE_LUX_MASK, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->lux_scale = lux_scale;

Maybe leave this to be cached by the regmap?

> +
> +	return 0;
> +}
> +
> +static int isl76682_set_als_ir_mode(struct isl76682_chip *chip,
> +				    enum isl76682_als_ir_mode mode)
> +{
> +	int ret;
> +
> +	if (chip->als_ir_mode == mode)
> +		return 0;
> +
> +	if (mode == ISL76682_MODE_NONE) {
> +		return regmap_clear_bits(chip->regmap, ISL76682_REG_COMMAND,
> +					 ISL76682_COMMAND_EN);
> +	}
> +
> +	ret = isl76682_set_als_scale(chip, chip->lux_scale);
> +	if (ret < 0)
> +		return ret;

Does the HW require the scale to be set here?

> +
> +	if (mode == ISL76682_MODE_ALS) {
> +		ret = regmap_clear_bits(chip->regmap, ISL76682_REG_COMMAND,
> +					ISL76682_COMMAND_LIGHT_IR);
> +	} else {
> +		ret = regmap_set_bits(chip->regmap, ISL76682_REG_COMMAND,
> +				      ISL76682_COMMAND_LIGHT_IR);
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable the ALS/IR */
> +	ret = regmap_set_bits(chip->regmap, ISL76682_REG_COMMAND,
> +			      ISL76682_COMMAND_EN |
> +			      ISL76682_COMMAND_MODE_CONTINUOUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Need to wait for conversion time if ALS/IR mode enabled */
> +	msleep(ISL76682_CONV_TIME_MS);
> +
> +	chip->als_ir_mode = mode;
> +
> +	return 0;
> +}
> +
> +static int isl76682_read_als_ir(struct isl76682_chip *chip, int *als_ir)
> +{
> +	unsigned int lsb, msb;
> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, ISL76682_REG_ALSIR_L, &lsb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(chip->regmap, ISL76682_REG_ALSIR_U, &msb);
> +	if (ret < 0)
> +		return ret;
> +
> +	*als_ir = (msb << 8) | lsb;
> +
> +	return 0;
> +}
> +
> +static int isl76682_als_get(struct isl76682_chip *chip, int *als_data)
> +{
> +	int als_ir_data;
> +	int ret;
> +
> +	ret = isl76682_set_als_ir_mode(chip, ISL76682_MODE_ALS);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = isl76682_read_als_ir(chip, &als_ir_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*als_data = als_ir_data;
> +
> +	return 0;
> +}
> +
> +static int isl76682_ir_get(struct isl76682_chip *chip, int *ir_data)
> +{
> +	int ret;
> +
> +	ret = isl76682_set_als_ir_mode(chip, ISL76682_MODE_IR);
> +	if (ret < 0)
> +		return ret;
> +
> +	return isl76682_read_als_ir(chip, ir_data);
> +}
> +
> +static int isl76682_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->lock);
> +	ret = isl76682_set_als_scale(chip, val);
> +	mutex_unlock(&chip->lock);

This looks a bit odd to me. I was under impression that the values would 
by default be IIO_VAL_INT_PLUS_MICRO unless the format is given in 
iio_info struct. If so, I'd expect the val to be zero for all of the 
scales because all scales are smaller than 1. (I may be wrong though). 
Eg, I'd expect that when range 1000 is set (scale 1000 / 65535), val = 
0, val1 roughly 15259 (to mean 0.015259).

> +
> +	return ret;
> +}
> +
> +static int isl76682_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = isl76682_als_get(chip, val);
> +			break;
> +		case IIO_INTENSITY:
> +			ret = isl76682_ir_get(chip, val);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (ret < 0)
> +			break;
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type != IIO_LIGHT)
> +			break;
> +		*val = chip->lux_scale;
> +		*val2 = ISL76682_ADC_MAX;
> +		ret = IIO_VAL_FRACTIONAL;

This looks correct to me (with the remark about maybe leaving the 
caching of scale to regmap).

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR(in_illuminance_scale_available, "1000 4000 16000 64000");

This does not look correct to me. I'd guess the correct available scales 
should be 0.015259... 0.06... 0.24... 0.96... (up to used accuracy - I 
might go with the IIO_VAL_INT_PLUS_NANO. And, I didn't compute other 
than the first, just stole the rest from the data-sheet MIN range value 
which should equal to ADC count 1).

Please just ignore me if you think I am writing nonsense - wouldn't be 
the first time!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


