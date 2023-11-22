Return-Path: <linux-iio+bounces-265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0A7F458F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E967281468
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0596A250E6;
	Wed, 22 Nov 2023 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA6Ym7OG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962691;
	Wed, 22 Nov 2023 04:17:53 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cc537ed54so39961481cf.2;
        Wed, 22 Nov 2023 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700655472; x=1701260272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJvIeAojLvASPqEpApm/YzJ1B5Zf+tRjMY5XMqeks+Q=;
        b=CA6Ym7OGzx0GZuLyAMaioyR+E+W1HxWEtllCXIQnMAF9Xhj3NNznTkQDrpAMAbFnri
         jAbx277hda5UhuXWGMrhvHPkM0Ml9C55ZU9NoEWgc882Lc7HNQ1/MpUy8IQM0zbSU9di
         ufQfeRL+FmEQYHN7wxLsVxzGrfj6wyC7vHeaQe4++RT1+uX7zL2WcLbbjJLRqrPM/E5B
         8bZ3DepY93XqcSxUFEuNNvPB6YSg+1Viwb9WOLZgX9yT3mhZzKC/iIMbrockujHqJN/a
         PWyFPfUUbFAyIVhJskVk4FksCyeQ8iZRFFtg4VNyfVw0vNYnjDOxdRmAS3CDzM/4YbKk
         KHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700655472; x=1701260272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJvIeAojLvASPqEpApm/YzJ1B5Zf+tRjMY5XMqeks+Q=;
        b=CYb6y9tyU06LKZZPRd9FB6ukfCSO84M7xyxc8g1D6zFpNBzGHIutDs5BFlmRfg/JPQ
         O5lKcjg/B9V+I9p/Hj4zUdp7gM8m5qV8D+tK8cjRF9myamtANooG2/qpHtIQHk88x+Mv
         9ikavNb/6aH0QuFEKvWUB8E+OJ28GLW60d8d5lxJ/fp4z/dNRKYMt4/305PTLqPacMpj
         o78FYYORLsBE26Simd8Anc00X+lbFKWW1R15pa4vO34X1qRO6MgPttp0JgHZrdFlDLAU
         mDkWx7WE1Jxg0ml+kRtzVn7IfBt6auxMcImvarMzdzL1zsLp9r2bGfttyors2FIF1VQF
         JUJg==
X-Gm-Message-State: AOJu0YwYZXY2drkYoHZIJuEhHZW9vqiuRwKl4cqiYH2tQoGlLq3G86+8
	aE2PPhBsA8a459sE0fMaX/dsDB+RLjlCbw==
X-Google-Smtp-Source: AGHT+IFPRTdXbPgxOFy8yRheECcUrenQgmKfTVQPPPUEO35BCmoSEc3Ic8e+1KCDiG3oeHnd1hsTMg==
X-Received: by 2002:a05:622a:387:b0:41e:5ccd:a7a0 with SMTP id j7-20020a05622a038700b0041e5ccda7a0mr2467125qtx.44.1700655471919;
        Wed, 22 Nov 2023 04:17:51 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id y8-20020ac87088000000b004199c98f87dsm4360100qto.74.2023.11.22.04.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 04:17:51 -0800 (PST)
Message-ID: <8b865546-0e51-45ff-ab76-8189afaa9ad5@gmail.com>
Date: Wed, 22 Nov 2023 14:17:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
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
References: <20231121031043.327614-1-marex@denx.de>
 <20231121031043.327614-2-marex@denx.de>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231121031043.327614-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/23 05:10, Marek Vasut wrote:
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
> V2: - Overhaul the driver
>      - Cache the entire 8-bit command register instead of parts of it
>        and build up and rewrite the entire register if necessary
>      - Fix illumination scale, add intensity scale, add integration time
> V3: - Limit the read data to 16bit ADC range
>      - Update Kconfig description
>      - Update macros, drop bitshifts
>      - Switch over to table lookup for lux ranges
>      - Switch over to .read_avail instead of attributes
>      - Use guard where applicable
>      - Drop remove function in favor of reset action
> V4: - Address feedback from Andy
>      - Add missing includes
>      - Change ISL76682_ADC_MAX to BIT(16) - 1
>      - Drop initial ret assignment in isl76682_read_raw()
>      - Move return -EINVAL to default: switch-case branch
>      - Use switch-case consistenly instead of if/else
>      - Drop trailing commas
>      - Add comment to isl76682_clear_configure_reg on command zeroing on failure
>      - Drop i2c_set_clientdata
>      - Update devm_regmap_init_i2c return value handling
> ---
>   drivers/iio/light/Kconfig    |  15 ++
>   drivers/iio/light/Makefile   |   1 +
>   drivers/iio/light/isl76682.c | 364 +++++++++++++++++++++++++++++++++++
>   3 files changed, 380 insertions(+)
>   create mode 100644 drivers/iio/light/isl76682.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 45edba797e4c7..9e8cdc091556d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -252,6 +252,21 @@ config ISL29125
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called isl29125.
>   
> +config ISL76682
> +	tristate "Intersil ISL76682 Light Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here if you want to build a driver for the Intersil ISL76682
> +	  Ambient Light Sensor and IR Intensity sensor. This driver provides
> +	  the readouts via standard IIO sysfs and device interface. Both ALS
> +	  illuminance and IR illuminance are provided raw with separate scale
> +	  setting which can be configured via sysfs, the default scale is 1000
> +	  lux, other options are 4000/16000/64000 lux.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called isl76682.
> +
>   config HID_SENSOR_ALS
>   	depends on HID_SENSOR_HUB
>   	select IIO_BUFFER
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0db4c4c36ec9..09fa585f3109f 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_IQS621_ALS)	+= iqs621-als.o
>   obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
>   obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>   obj-$(CONFIG_ISL29125)		+= isl29125.o
> +obj-$(CONFIG_ISL76682)		+= isl76682.o
>   obj-$(CONFIG_JSA1212)		+= jsa1212.o
>   obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>   obj-$(CONFIG_LTR501)		+= ltr501.o
> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> new file mode 100644
> index 0000000000000..7f0ccd0d37539
> --- /dev/null
> +++ b/drivers/iio/light/isl76682.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IIO driver for the light sensor ISL76682.
> + * ISL76682 is Ambient Light Sensor
> + *
> + * Copyright (c) 2023 Marek Vasut <marex@denx.de>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define ISL76682_REG_COMMAND			0x00
> +
> +#define ISL76682_COMMAND_EN			BIT(7)
> +#define ISL76682_COMMAND_MODE_CONTINUOUS	BIT(6)
> +#define ISL76682_COMMAND_LIGHT_IR		BIT(5)
> +
> +#define ISL76682_COMMAND_RANGE_LUX_1K		0x0
> +#define ISL76682_COMMAND_RANGE_LUX_4K		0x1
> +#define ISL76682_COMMAND_RANGE_LUX_16K		0x2
> +#define ISL76682_COMMAND_RANGE_LUX_64K		0x3
> +#define ISL76682_COMMAND_RANGE_LUX_MASK		GENMASK(1, 0)
> +
> +#define ISL76682_REG_ALSIR_L			0x01
> +
> +#define ISL76682_REG_ALSIR_U			0x02
> +
> +#define ISL76682_NUM_REGS			(ISL76682_REG_ALSIR_U + 1)
> +
> +#define ISL76682_CONV_TIME_MS			100
> +#define ISL76682_INT_TIME_US			90000
> +
> +#define ISL76682_ADC_MAX			(BIT(16) - 1)
> +
> +struct isl76682_chip {
> +	/*
> +	 * Lock to synchronize access to device command register
> +	 * and the content of range variable below.
> +	 */
> +	struct mutex			lock;
> +	struct regmap			*regmap;
> +	u8				range;
> +	u8				command;
> +};
> +
> +struct isl76682_range {
> +	u8				range;
> +	u32				als;
> +	u32				ir;
> +};
> +
> +static struct isl76682_range isl76682_range_table[] = {
> +	{ ISL76682_COMMAND_RANGE_LUX_1K, 15000, 10500 },
> +	{ ISL76682_COMMAND_RANGE_LUX_4K, 60000, 42000 },
> +	{ ISL76682_COMMAND_RANGE_LUX_16K, 240000, 168000 },
> +	{ ISL76682_COMMAND_RANGE_LUX_64K, 960000, 673000 }
> +};
> +
> +static int isl76682_get(struct isl76682_chip *chip, bool mode_ir, int *data)
> +{
> +	u8 command;
> +	int ret;
> +
> +	command = ISL76682_COMMAND_EN | ISL76682_COMMAND_MODE_CONTINUOUS |
> +		  chip->range;
> +
> +	if (mode_ir)
> +		command |= ISL76682_COMMAND_LIGHT_IR;
> +
> +	if (command != chip->command) {
> +		ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, command);
> +		if (ret)
> +			return ret;
> +
> +		/* Need to wait for conversion time if ALS/IR mode enabled */
> +		msleep(ISL76682_CONV_TIME_MS);
> +
> +		chip->command = command;
> +	}
> +
> +	ret = regmap_bulk_read(chip->regmap, ISL76682_REG_ALSIR_L, data, 2);
> +	*data &= ISL76682_ADC_MAX;
> +	return ret;
> +}
> +
> +static int isl76682_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	int i;
> +
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	if (val != 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
> +		if (chan->type == IIO_LIGHT) {
> +			if (val2 != isl76682_range_table[i].als)
> +				continue;
> +		} else if (chan->type == IIO_INTENSITY) {
> +			if (val2 != isl76682_range_table[i].ir)
> +				continue;
> +		}

I like this table-based look-up for write (and read) of scales. Looking 
at this I see an analogy to some of the regulator stuff, like for 
example the ramp-up values. What I do very much like in the regulator 
subsystem is the drivers/regulator/helpers.c

I wonder if similar approach would be usable in IIO as well? I mean, 
providing readily written iio_regmap_read/write_raw_<functionality>() 
and iio_available_*() helpers for the simple devices where we just have 
value-register mapping? I mean, driver would just populate something like:

struct iio_scale_desc {
	int *scale_val_table;
	int *scale_val2_table;
	int num_scales;
	int scale_reg_addr;
	int scale_reg_mask;
};

and call helper like
int iio_regmap_read_raw_scale(struct iio_dev *idev,
			      struct iio_scale_desc *sd, int *val,
			      int *val2)"
provided by IIO framework.

Similar helper for writing new scales and getting available scales.

Later this could be expanded by allowing specifying the type of provided 
values (in the example case, IIO_VAL_INT_PLUS_x - but maybe this would 
be extensible (and worth) to support also the other options?)

I know it's a bit much to be done in the context of this series. Hence I 
am definitely not insisting this to be done here! OTOH, the embedded 
Linux is not in EU next year so maybe Marek would forgive me before we 
meet next time :pondering:

Anyways - does this sound like a sensible thing to do? I guess it could 
help simplifying some drivers a little.

Oh. Only after writing of this I noticed the range is written in HW only 
together with the 'start' command. I guess this is how the IC operates - 
you need to write all configs together with starting the measurement? Or 
is that just an optimization to avoid extra writes? If it's the first, 
then a suggested iio_regmap_*() -helper wouldn't work here. I might've 
added a comment explaining why range is written in isl76682_get() and 
not here to the isl76682_get().

Anyways - this driver looks good to me. (What a long way of saying that).

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> +
> +		scoped_guard(mutex, &chip->lock)
> +			chip->range = isl76682_range_table[i].range;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


