Return-Path: <linux-iio+bounces-26374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7AC7BDE1
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 628254E3352
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B475287259;
	Fri, 21 Nov 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HOLJMTy4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9B2BEC2A
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763764388; cv=none; b=pcx9NW+9Aqq4IUKxcQdZf9a5CNAyUwZWjx09RO1J2plt8fLJm1UX8o8NV2bg9UrrB8NaEtqcwaS13d2nLTb+aEX5oHjVbL3n0+IqVmgUd9SmhY6LIjNBDN379oSAoAJQdRsQ2M/dBi3dyo2zHPkEzUPPWNUdcAP/1z+/JXuB93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763764388; c=relaxed/simple;
	bh=/MTl+rn6QKEykIhNYFE+4u6RL7ZvLLaRbFaTElwIr+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3KICfZI3SPgV3U3+/OnDU0AJ6XOgoN0KqSLJS2BibzcF9Jr1zIfYWE9lRmkZrAMwPJoV/hbTOwNt1QY/4fdjA3BnEDP+grxx8RMAddiF4PsYdq7SIJ8nSbZorIBqUsg1KQv+PJNKnawOKvyOBuInJ/9EaKGq0qfbuCX8sZm6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HOLJMTy4; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c75fc222c3so851428a34.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763764383; x=1764369183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoOqLHUb0IgZN9VBAlMxMix5QY96KA+g1uS7oilvYhw=;
        b=HOLJMTy4U1zDGqYNDVbpPnLU/RtaRrO/fgAaxZVXFAQwRuKluMJ8L89wQCEyx/a5qb
         2pC6TlBBE8Pd7Jcbg5P4GMztVWh4t+v1byZ8QtgV8OFDdx5+HRuB8CmCIekqoBjzjZFH
         StPVXeM0DUhBRGRwG/y7p+P3FrcnKwU/cFZG+myYSVfNiSKJAT59XH6rXYE8HorTTeXf
         BD4cVejAOvufOeyNcL+/0+r9eazrifqMaeL0FPC224no2oVQTesYAF/3zg8AB1u/NF5c
         lpfW0tvmNPb99ZZmB5zXNYhnnjZ+MRF/vPyTbbilj98iiX0541FdOYzY90fEivYGoVQ4
         /8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763764383; x=1764369183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoOqLHUb0IgZN9VBAlMxMix5QY96KA+g1uS7oilvYhw=;
        b=wJVCLDGcL3nQQQ/2q55PXZZXgZHwXY9wh0A5tlNp8kgnaZQoUhhnV/jaNhODp6wf8T
         eVSzt4Zsb/WrMmJKLNsludvWVCiINEeqNgf+4Mg3TBlyHxZUBmaBbp7+5WPp6T3sYGs2
         Bx3QoJT8L+wJcy0SGIma0xBbrPP1Fed02lcjNygNnXejQWbuy+I3S1bKcx5Xm44TSsoV
         9jZeFPfN1UTRqmvN/CVqYuTIj6nzDGMkfFCol7ERQw9Wzj84a3qqkcbcqMSycalQ/cMA
         QRRJKiCCMaeof1oouQOma5FiuWmnJUfr2LvCba81VgK2fdKvqCjJ315rm3QL4mUzuHPv
         L25Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYc/1vspT+VsWvCqsP2Omp02HroAYDbbOp1rTL3d9Wl6Oee5IllCdKBdBaoyw6VaXIWf3uGnCSxIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMlCP4TFvrtMFk1/t/Q460+mCT6/Pb5/IBqI8ctml954CfOPq
	SpbTIIH18hv70LoNUELKvEI7o4yG4KCKA0Z3T6HfSCmEVF48UUL/ik3lhrTv5t6tyy8=
X-Gm-Gg: ASbGncsIm35oYOelW4+JzRjo07rV7BJhiR+RxDGsGr/U+7psY11tQ6rLb03WuXW4Hl0
	WqSm8rqpOGcJyMj+AWBqrBV+fS8J2GWQ0PbaML5NEGWPu0z8OUcwWQldDoruz1P2iBd8JANeObE
	az6+CF4ONYxUoJHOiYWZtqhZrmnoE16e+l22HyrV8KjTvwxdhXmjbdbs7ryL3WgdY47sZPD/DYJ
	R/sJ4uAq+KoV7KRrAi0dRrIhrbruYl8gilMImmdGoxZgzHqwYIIY9iz7Fn+VXdHKtwtjHB6hOxR
	wwISJG/gRfVRJe2Um2Na1OmZnmxpVUsFQAfgUJ58+28tf5dPSODtaa+IGaCpKE8VEoVZpNXi/3q
	eswY/pgOI0gTqvexy4AglrN6wga822Lz9RMG42H3rz2rg2fw3HQi3UzrgtFq98yLA75qFz47o/T
	4VE8SWjUTqVbwsJSoaegwmjAS0ZCZ/1HQy/ytTLrMmANFqDGOvkRHsfMxBzXsW
X-Google-Smtp-Source: AGHT+IHVVIRG8FhJRkSE/bObuytAJLwDf8TZwOdkV0z6rIhrXDtIc6ugVQTYim8TYgTsjYoY3oNt1A==
X-Received: by 2002:a05:6830:6da7:b0:7c6:c841:657d with SMTP id 46e09a7af769-7c7990baea0mr1839036a34.34.1763764382970;
        Fri, 21 Nov 2025 14:33:02 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d30475asm2807154a34.3.2025.11.21.14.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 14:33:02 -0800 (PST)
Message-ID: <30a7e100-5919-4b5f-86cc-589283acd6cc@baylibre.com>
Date: Fri, 21 Nov 2025 16:33:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: Add ti-ads1x18 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-2-86db080fc9a4@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251121-ads1x18-v1-2-86db080fc9a4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 11:16 AM, Kurt Borja wrote:
> Add ti-ads1x18 driver for Texas Instruments ADS1018 and ADS1118 SPI
> analog-to-digital converters.
> 
> These devices support a data-ready IRQ, which is shared with the MOSI
> line. Due to this peculiarity, interrupt and IIO trigger design is
> heavily inspired in ad_sigma_delta drivers. The IRQ is only enabled when
> waiting for data and an additional GPIO is needed to check if it isn't a
> latched pending interrupt.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  MAINTAINERS                  |   7 +
>  drivers/iio/adc/Kconfig      |  12 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1x18.c | 919 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 939 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 31d98efb1ad1..f9f0983d5d6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25646,6 +25646,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
>  F:	drivers/iio/adc/ti-ads1119.c
>  
> +TI ADS1X18 ADC DRIVER
> +M:	Kurt Borja <kuurtb@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml

It is better if the maintainer entry minus the line below is included in
the dt-bindings patch rather than this patch since that is when the first
file is added.

> +F:	drivers/iio/adc/ti-ads1x18.c

Then just the line above will stay in this patch.

> +
>  TI ADS7924 ADC DRIVER
>  M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58da8255525e..0d3229a67af8 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1686,6 +1686,18 @@ config TI_ADS1119
>           This driver can also be built as a module. If so, the module will be
>           called ti-ads1119.
>  
> +config TI_ADS1X18

We strongly avoid putting an X in names. This applies here and in file names,
etc. Too many times, the pattern has not matched future parts and has been more
confusing than helpful. I like to use the lowsest number part for the generic
name.

> +       tristate "Texas Instruments ADS1119 ADC"

Typo. There is no 9 in these part numbers. And so this should be moved above
the previous existing entry to maintain alphabetical ordering.

> +       depends on SPI
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         If you say yes here you get support for Texas Instruments ADS1X18
> +         ADC chips.
> +
> +         This driver can also be built as a module. If so, the module will be
> +         called ti-ads1x18.
> +
>  config TI_ADS124S08
>  	tristate "Texas Instruments ADS124S08"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7cc8f9a12f76..ab3b52307482 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -147,6 +147,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
> +obj-$(CONFIG_TI_ADS1X18) += ti-ads1x18.o

Comment above apply here as well.

>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
>  obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
> diff --git a/drivers/iio/adc/ti-ads1x18.c b/drivers/iio/adc/ti-ads1x18.c
> new file mode 100644
> index 000000000000..1bf4fe34a825
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1x18.c
> @@ -0,0 +1,919 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Texas Instruments ADS1X18 ADC driver
> + *
> + * Copyright (C) 2025 Kurt Borja <kuurtb@gmail.com>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/bitmap.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/device/devres.h>
> +#include <linux/errno.h>
> +#include <linux/find.h>
> +#include <linux/gfp_types.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>

spinlock isn't used. Probabaly others as well. Please check and
remove them.

> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +

Comment on not using X also applies to identifier names.

> +#define ADS1X18_CFG_DEFAULT		0x058b
> +

Usually, we have macros to define the registers. and group
the fields under each register.

#define ADS1018_CFG_REG			0x0000

And indent the fields a bit to make a visual distenction

> +#define ADS1X18_CFG_OS_TRIG		BIT_U16(15)
> +#define ADS1X18_CFG_TS_MODE_EN		BIT_U16(4)
> +#define ADS1X18_CFG_PULL_UP		BIT_U16(3)
> +#define ADS1X18_CFG_NOP			BIT_U16(1)
> +#define ADS1X18_CFG_VALID		(ADS1X18_CFG_PULL_UP | ADS1X18_CFG_NOP)
> +

In IIO, we just use BIT() and GENMASK(). The U16 version doesn't really
add anything useful and IMHO makes it harder to read.

> +#define ADS1X18_CFG_MUX_MASK		GENMASK_U16(14, 12)
> +#define ADS1X18_AIN0_AIN1_ADDR		0
> +#define ADS1X18_AIN0_AIN3_ADDR		1
> +#define ADS1X18_AIN1_AIN3_ADDR		2
> +#define ADS1X18_AIN2_AIN3_ADDR		3
> +#define ADS1X18_AIN0_GND_ADDR		4
> +#define ADS1X18_AIN1_GND_ADDR		5
> +#define ADS1X18_AIN2_GND_ADDR		6
> +#define ADS1X18_AIN3_GND_ADDR		7
> +#define ADS1X18_TEMP_ADDR		8
> +#define ADS1X18_TIMESTAMP_ADDR		9
> +
> +#define ADS1X18_CFG_PGA_MASK		GENMASK_U16(11, 9)
> +#define ADS1X18_PGA_MODE_0		0
> +#define ADS1X18_PGA_MODE_1		1
> +#define ADS1X18_PGA_MODE_2		2
> +#define ADS1X18_PGA_MODE_3		3
> +#define ADS1X18_PGA_MODE_4		4
> +#define ADS1X18_PGA_MODE_5		5

Not much use in making a macro that matches the value. We can just
use the value directly. And we will have a lookup table to map the

> +#define ADS1X18_PGA_DEFAULT		ADS1X18_PGA_MODE_2
> +
> +#define ADS1X18_CFG_MODE_MASK		GENMASK_U16(8, 8)
> +#define ADS1X18_MODE_CONTINUOUS		0
> +#define ADS1X18_MODE_ONESHOT		1
> +
> +#define ADS1X18_CFG_DRATE_MASK		GENMASK_U16(7, 5)
> +#define ADS1X18_DRATE_MODE_0		0
> +#define ADS1X18_DRATE_MODE_1		1
> +#define ADS1X18_DRATE_MODE_2		2
> +#define ADS1X18_DRATE_MODE_3		3
> +#define ADS1X18_DRATE_MODE_4		4
> +#define ADS1X18_DRATE_MODE_5		5
> +#define ADS1X18_DRATE_MODE_6		6
> +#define ADS1X18_DRATE_MODE_7		7
> +#define ADS1X18_DRATE_DEFAULT		ADS1X18_DRATE_MODE_4
> +
> +#define ADS1X18_MAX_ADC_ADDR		7
> +#define ADS1X18_MAX_CHANNELS		9
> +
> +struct ads1x18_chan_data {
> +	unsigned int pga_mode:3;
> +	unsigned int drate_mode:3;

I would just use u8 instead of bit fields. We don't usually worry
about saving every little byte unless there are going to be 100s or
1000s of copies of something.

And I would spell out data_rate.

> +};
> +
> +struct ads1x18_chip_info {
> +	const char *name;
> +
> +	const struct iio_chan_spec *channels;
> +	unsigned long channels_sz;

Usually, we say "num_channels" as size could be interpreted as
size in bytes.

> +
> +	const int *sps_table;

"sps" is a bit obscure. I assume this corresponds to drate_mode above?
So perhaps call this data_rate_mode_to_hz_table.

> +	unsigned long sps_table_sz;
> +	const int (*fsr_table)[2];
> +	unsigned long fsr_table_sz;

Same with "fsr". Maybe pga_mode_to_gain_table?

> +	const int temp_scale[2];

This could use a comment. I assume it is integer and micro?

> +};
> +
> +struct ads1x18 {
> +	struct spi_device *spi;
> +	struct iio_dev *indio_dev;
> +	struct iio_trigger *indio_trig;
> +
> +	struct gpio_desc *drdy_gpiod;
> +	int drdy_irq;
> +
> +	u16 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
> +	u16 rx_buf[2];

These need to be moved to the end of the struct. Otherwise everything
after could be in the same cache line and run into problems when DMA
is used.

> +	struct spi_transfer xfer;
> +	struct spi_message message;
> +	struct completion data_ready;
> +	struct mutex msg_lock; /* Protects message transfers */

Unless we need to be able to do direct reads and buffered reads
at the same time, we can usually make use of iio_device_claim_direct()
instead of a new mutex.

> +
> +	unsigned int restore_mode:1;

Just use bool.

> +
> +	unsigned long bufidx_to_addr[ADS1X18_MAX_CHANNELS];

This looks fishy. I think it is only needed because of the lack of
.scan_index, so should be able to remove it.

> +	struct ads1x18_chan_data channels[ADS1X18_MAX_CHANNELS];
> +
> +	const struct ads1x18_chip_info *chip_info;
> +};
> +
> +#define ADS1X18_VOLT_CHANNEL(_addr, _chan, _chan2, _diff, _realbits) {		\
> +	.type = IIO_VOLTAGE,							\
> +	.channel = _chan,							\
> +	.channel2 = _chan2,							\
> +	.address = _addr,							\

Since we are doing buffered reads, we need to set .scan_index. And usually,
we can make it so that .scan_index is the same as .address and just use
.scan_index everywhere and never set .address.

> +	.scan_type = {								\
> +		.sign = 's',							\
> +		.realbits = _realbits,						\
> +		.storagebits = 16,						\
> +		.shift = 16 - _realbits,					\
> +	},									\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\

Since we have to write the data rate to the config register on every sample
anyway, it is possible we could have a different data rate for each channel.
So it could make sensible to make SAMP_FREQ separate instead of shared_by_all
to allow that possibility.

> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\

I'm a bit tempted to say that the scale_available should also be separate instead
of by_type. It is technically fine from what I could see in the datasheet, but I
just saw another chip recently that was simiar but had limits on the PGA on certain
mux channels.


> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.modified = _diff,							\

We can't have .modified and .diff at the same time. And there should be no need
for .modified in this driver.

> +	.indexed = true,							\
> +	.differential = _diff,							\

I would make 2 different macros, one for .differential = 0 and one for
.differential = 1. This way we don't have the noise of an unused chan2
parameter when differential = 0.

> +}
> +
> +#define ADS1X18_TEMP_CHANNEL(_realbits)	{					\
> +	.type = IIO_TEMP,							\
> +	.channel = 0,								\
> +	.address = ADS1X18_TEMP_ADDR,						\

Also needs .scan_index.

> +	.scan_type = {								\
> +		.sign = 's',							\
> +		.realbits = _realbits,						\
> +		.storagebits = 16,						\
> +		.shift = 16 - _realbits,					\
> +	},									\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static const struct iio_chan_spec ads1118_iio_channels[] = {
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN0_AIN1_ADDR, 0, 1, true, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN0_AIN3_ADDR, 0, 3, true, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN1_AIN3_ADDR, 1, 3, true, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN2_AIN3_ADDR, 2, 3, true, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN0_GND_ADDR, 0, 0, false, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN1_GND_ADDR, 1, 0, false, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN2_GND_ADDR, 2, 0, false, 16),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN3_GND_ADDR, 3, 0, false, 16),
> +	ADS1X18_TEMP_CHANNEL(14),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADS1X18_TIMESTAMP_ADDR),

When we switch out .address for .scan_index, I would drop the ADDR macros
here. It should just be 0, 1, 2, 3, ... on each line. With numbers, it is
easy to see mistakes, but the macros hide that.

> +};
> +
> +static const struct iio_chan_spec ads1018_iio_channels[] = {
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN0_AIN1_ADDR, 0, 1, true, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN0_AIN3_ADDR, 0, 3, true, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN1_AIN3_ADDR, 1, 3, true, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN2_AIN3_ADDR, 2, 3, true, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN0_GND_ADDR, 0, 0, false, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN1_GND_ADDR, 1, 0, false, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN2_GND_ADDR, 2, 0, false, 12),
> +	ADS1X18_VOLT_CHANNEL(ADS1X18_AIN3_GND_ADDR, 3, 0, false, 12),
> +	ADS1X18_TEMP_CHANNEL(12),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADS1X18_TIMESTAMP_ADDR),
> +};
> +
> +static unsigned int ads1x18_get_drate_mode(struct ads1x18 *ads1x18,
> +					   unsigned int address)
> +{
> +	return ads1x18->channels[address].drate_mode;
> +}
> +
> +static unsigned int ads1x18_get_pga_mode(struct ads1x18 *ads1x18,
> +					 unsigned int address)
> +{
> +	return ads1x18->channels[address].pga_mode;
> +}
> +
> +static void ads1x18_set_drate_mode(struct ads1x18 *ads1x18, unsigned int address,
> +				   unsigned int val)
> +{
> +	ads1x18->channels[address].drate_mode = val;
> +}
> +
> +static void ads1x18_set_pga_mode(struct ads1x18 *ads1x18, unsigned int address,
> +				 unsigned int val)
> +{
> +	ads1x18->channels[address].pga_mode = val;
> +}
> +
> +static unsigned long ads1x18_calc_timeout(struct ads1x18 *ads1x18,
> +					  unsigned int drate_mode)
> +{
> +	const struct ads1x18_chip_info *chip_info = ads1x18->chip_info;
> +	unsigned long timeout;
> +	unsigned int sps;
> +

This could use some comments explaining how we came up with this
calculation and what the timeout will be used for.

> +	sps = chip_info->sps_table[drate_mode];
> +	timeout = DIV_ROUND_UP(MICROHZ_PER_HZ, sps);
> +
> +	return usecs_to_jiffies(timeout * 2);
> +}
> +
> +static int __ads1x18_read_conver(struct ads1x18 *ads1x18, u16 *cnv)
> +{
> +	int ret;
> +
> +	ads1x18->tx_buf[0] = 0;
> +	ads1x18->tx_buf[1] = 0;
> +	ret = spi_sync_locked(ads1x18->spi, &ads1x18->message);
> +	if (ret)
> +		return ret;
> +
> +	*cnv = be16_to_cpu(ads1x18->rx_buf[0]);
> +
> +	return 0;
> +}
> +
> +static int __ads1x18_write_config(struct ads1x18 *ads1x18, u16 cfg)
> +{
> +	ads1x18->tx_buf[0] = cpu_to_be16(cfg);
> +	ads1x18->tx_buf[1] = 0;
> +
> +	return spi_sync_locked(ads1x18->spi, &ads1x18->message);
> +}
> +
> +static int ads1x18_read_conver(struct ads1x18 *ads1x18, u16 *cnv)
> +{
> +	int ret;
> +
> +	spi_bus_lock(ads1x18->spi->controller);

It is very unusual to manually manage the SPI bus lock. I see later that there
is a good reason for it. It would be good to mention that in the commit message
as well.

And it would be helpful to have a few more comments throughout explaining
which function should be called from where to get proper locking.

> +	ret = __ads1x18_read_conver(ads1x18, cnv);
> +	spi_bus_unlock(ads1x18->spi->controller);
> +
> +	return ret;
> +}
> +
> +static int ads1x18_write_config(struct ads1x18 *ads1x18, u16 cfg)
> +{
> +	int ret;
> +
> +	spi_bus_lock(ads1x18->spi->controller);
> +	ret = __ads1x18_write_config(ads1x18, cfg);
> +	spi_bus_unlock(ads1x18->spi->controller);
> +
> +	return ret;
> +}
> +
> +static int ads1x18_oneshot(struct ads1x18 *ads1x18,
> +			   struct iio_chan_spec const *chan, int *val)
> +{
> +	unsigned int drate = ads1x18_get_drate_mode(ads1x18, chan->address);
> +	unsigned int pga = ads1x18_get_pga_mode(ads1x18, chan->address);
> +	unsigned long timeout = ads1x18_calc_timeout(ads1x18, drate);
> +	u16 cnv, cfg = 0;
> +	int ret;
> +
> +	reinit_completion(&ads1x18->data_ready);
> +
> +	cfg |= ADS1X18_CFG_VALID;
> +	cfg |= ADS1X18_CFG_OS_TRIG;
> +	cfg |= FIELD_PREP(ADS1X18_CFG_MUX_MASK, chan->address);
> +	cfg |= FIELD_PREP(ADS1X18_CFG_PGA_MASK, pga);
> +	cfg |= FIELD_PREP(ADS1X18_CFG_MODE_MASK, ADS1X18_MODE_ONESHOT);
> +	cfg |= FIELD_PREP(ADS1X18_CFG_DRATE_MASK, drate);
> +	if (chan->type == IIO_TEMP)
> +		cfg |= ADS1X18_CFG_TS_MODE_EN;
> +
> +	ret = __ads1x18_write_config(ads1x18, cfg);
> +	if (ret)
> +		return ret;
> +	enable_irq(ads1x18->drdy_irq);
> +
> +	if (!wait_for_completion_timeout(&ads1x18->data_ready, timeout)) {
> +		disable_irq(ads1x18->drdy_irq);
> +		return -ETIMEDOUT;
> +	}
> +	disable_irq(ads1x18->drdy_irq);
> +
> +	ret = __ads1x18_read_conver(ads1x18, &cnv);
> +	if (ret)
> +		return ret;
> +
> +	cnv >>= chan->scan_type.shift;
> +	*val = sign_extend32(cnv, chan->scan_type.realbits - 1);

For direct reads, I would not mess with the interrupt. Unless there is some reason
(like filtering effects) that the data rate is important when reading a single sample,
I would just set the sample rate to the lowest value. Then we can create a single
SPI message using the delay feature of struct spi_xfer that has a delay to match
the period of the data rate. The SPI message would have to have two transfers, one
to trigger the conversion and the other to read the data. Then this will also work
even in cases where the DRDY interrupt is not wired up.

Also, this would allow to simplify the SPI bus lock situation in that we would only
need to take the lock when starting a buffered read

> +
> +	return ret;
> +}
> +
> +static int
> +ads1x18_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		 int *val, int *val2, long mask)
> +{
> +	struct ads1x18 *ads1x18 = iio_priv(indio_dev);
> +	struct ads1x18_chan_data *chan_info = &ads1x18->channels[chan->address];
> +	const struct ads1x18_chip_info *chip_info = ads1x18->chip_info;
> +	int ret;
> +
> +	guard(mutex)(&ads1x18->msg_lock);

Yup,  there is already iio_device_claim_direct() in use here so this
mutex seems redundant.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		/* CS needs to remain asserted until dataready IRQ */
> +		spi_bus_lock(ads1x18->spi->controller);
> +
> +		ret = ads1x18_oneshot(ads1x18, chan, val);
> +
> +		spi_bus_unlock(ads1x18->spi->controller);
> +		iio_device_release_direct(indio_dev);
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = chip_info->fsr_table[chan_info->pga_mode][0];
> +			*val2 = chip_info->fsr_table[chan_info->pga_mode][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +
> +		case IIO_TEMP:
> +			*val = chip_info->temp_scale[0];
> +			*val2 = chip_info->temp_scale[1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = chip_info->sps_table[chan_info->drate_mode];
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int
> +ads1x18_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		   const int **vals, int *type, int *length, long mask)
> +{
> +	struct ads1x18 *ads1x18 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*vals = (const int *)ads1x18->chip_info->fsr_table;
> +		*length = ads1x18->chip_info->fsr_table_sz * 2;
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = ads1x18->chip_info->sps_table;
> +		*length = ads1x18->chip_info->sps_table_sz;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int
> +ads1x18_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		  int val, int val2, long mask)
> +{
> +	struct ads1x18 *ads1x18 = iio_priv(indio_dev);
> +	const struct ads1x18_chip_info *info = ads1x18->chip_info;
> +	unsigned int i = 0;

Strange way to initialize a for loop. I would just do it normally.

> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (; i < info->fsr_table_sz; i++) {
> +			if (val != info->fsr_table[i][0] ||
> +			    val2 != info->fsr_table[i][1])
> +				continue;
> +
> +			ads1x18_set_pga_mode(ads1x18, chan->address, i);
> +			return 0;
> +		}
> +
> +		return -EINVAL;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (; i < info->sps_table_sz; i++) {
> +			if (val != info->sps_table[i])
> +				continue;
> +
> +			ads1x18_set_drate_mode(ads1x18, chan->address, i);
> +			return 0;
> +		}
> +
> +		return -EINVAL;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int
> +ads1x18_write_raw_get_fmt(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> +static const struct iio_info ads1x18_iio_info = {
> +	.read_raw = ads1x18_read_raw,
> +	.read_avail = ads1x18_read_avail,
> +	.write_raw = ads1x18_write_raw,
> +	.write_raw_get_fmt = ads1x18_write_raw_get_fmt,
> +};
> +
> +static int ads1x18_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct ads1x18 *ads1x18 = iio_trigger_get_drvdata(trig);
> +	u16 cnv;
> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	/*
> +	 * We need to lock the SPI bus when enabling the trigger to prevent
> +	 * another device from taking the CS and DOUT/DRDY lines.
> +	 */
> +
> +	if (state) {
> +		spi_bus_lock(ads1x18->spi->controller);
> +		enable_irq(ads1x18->drdy_irq);
> +
> +		/*
> +		 * Read once to ensure we are holding the CS line after locking
> +		 */
> +		return __ads1x18_read_conver(ads1x18, &cnv);

It is a bit confusing to have this here rather than in the buffer
enable callback since that is also setting the config that triggers
the first conversion.

Having the spi_bus_lock() and enable_irq() in the buffer enable
would make more sense to me too.

It should also be possible to use the chip without the interrupt
by using delay to wait for conversions, so perhaps we could make
the case for doing the enable_irq() here. But for sure spi_bus_lock()
would need to be in the buffer enable callback.

> +	}
> +
> +	disable_irq(ads1x18->drdy_irq);
> +	spi_bus_unlock(ads1x18->spi->controller);
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops ads1x18_trigger_ops = {
> +	.set_trigger_state = ads1x18_set_trigger_state,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int ads1x18_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ads1x18 *ads1x18 = iio_priv(indio_dev);
> +	unsigned int pga, drate, addr, idx;
> +	u16 cfg = 0;
> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	idx = find_first_bit(indio_dev->active_scan_mask,
> +			     iio_get_masklength(indio_dev));
> +	addr = ads1x18->bufidx_to_addr[idx];
> +	pga = ads1x18_get_pga_mode(ads1x18, addr);
> +	drate = ads1x18_get_drate_mode(ads1x18, addr);
> +
> +	cfg |= ADS1X18_CFG_VALID;
> +	cfg |= FIELD_PREP(ADS1X18_CFG_MUX_MASK, addr);
> +	cfg |= FIELD_PREP(ADS1X18_CFG_PGA_MASK, pga);
> +	cfg |= FIELD_PREP(ADS1X18_CFG_MODE_MASK, ADS1X18_MODE_CONTINUOUS);
> +	cfg |= FIELD_PREP(ADS1X18_CFG_DRATE_MASK, drate);
> +	if (addr == ADS1X18_TEMP_ADDR)
> +		cfg |= ADS1X18_CFG_TS_MODE_EN;
> +
> +	return ads1x18_write_config(ads1x18, cfg);
> +}
> +
> +static int ads1x18_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ads1x18 *ads1x18 = iio_priv(indio_dev);
> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	return ads1x18_write_config(ads1x18, ADS1X18_CFG_DEFAULT);
> +}
> +
> +static bool ads1x18_validate_scan_mask(struct iio_dev *indio_dev,
> +				       const unsigned long *mask)
> +{
> +	return bitmap_weight(mask, iio_get_masklength(indio_dev)) == 1;
> +}
> +
> +static const struct iio_buffer_setup_ops ads1x18_buffer_ops = {
> +	.preenable = ads1x18_buffer_preenable,
> +	.postdisable = ads1x18_buffer_postdisable,
> +	.validate_scan_mask = ads1x18_validate_scan_mask,
> +};
> +
> +static irqreturn_t ads1x18_irq_handler(int irq, void *dev_id)
> +{
> +	struct ads1x18 *ads1x18 = dev_id;
> +
> +	/*
> +	 * We need to check if the "drdy" pin is actually active or if it's a
> +	 * latched pending interrupt.
> +	 */
> +	if (!gpiod_get_value(ads1x18->drdy_gpiod))
> +		return IRQ_HANDLED;
> +
> +	complete(&ads1x18->data_ready);
> +	iio_trigger_poll(ads1x18->indio_trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ads1x18_interrupt_init(struct ads1x18 *ads1x18)
> +{
> +	const struct ads1x18_chip_info *info = ads1x18->chip_info;
> +	struct spi_device *spi = ads1x18->spi;
> +
> +	ads1x18->drdy_gpiod = devm_gpiod_get(&spi->dev, "drdy", GPIOD_IN);
> +	if (IS_ERR(ads1x18->drdy_gpiod))
> +		return dev_err_probe(&spi->dev, PTR_ERR(ads1x18->drdy_gpiod),
> +				     "Failed to get 'drdy' GPIO.\n");
> +

According the the dt-bindings, the interrupt could be separate from the
gpio. The SPI framework already looks up the first interrupts node if there
is one, so this could be

	if (spi->irq)
		ads1x18->drdy_irq = spi->irq;
	else

> +	ads1x18->drdy_irq = gpiod_to_irq(ads1x18->drdy_gpiod);
> +	if (ads1x18->drdy_irq < 0)
> +		return dev_err_probe(&spi->dev, ads1x18->drdy_irq,
> +				     "Failed to get 'drdy IRQ.\n'");
> +
> +	/*
> +	 * The "data-ready" IRQ line is shared with the MOSI pin, thus we need
> +	 * to keep it disabled until we actually request data.
> +	 */
> +	return devm_request_irq(&spi->dev, ads1x18->drdy_irq,
> +				ads1x18_irq_handler, IRQF_NO_AUTOEN,
> +				info->name, ads1x18);
> +}
> +
> +static irqreturn_t ads1x18_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads1x18 *ads1x18 = iio_priv(indio_dev);
> +	struct {
> +		u16 conv;
> +		aligned_s64 ts;
> +	} scan;

Need to 0-initilze with = { }; to avoid leaking uninitialized stack data.

> +	int ret;
> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	if (iio_trigger_using_own(indio_dev)) {
> +		disable_irq(ads1x18->drdy_irq);
> +		ret = __ads1x18_read_conver(ads1x18, &scan.conv);
> +		enable_irq(ads1x18->drdy_irq);
> +	} else {
> +		ret = ads1x18_read_conver(ads1x18, &scan.conv);
> +	}
> +
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	ret = iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +					  pf->timestamp);
> +	if (!ret)
> +		iio_trigger_notify_done(ads1x18->indio_trig);

Pretty sure we need to notify doen even in case of error, otherwise
we can get a deadlock.

In interrupt handlers our only choice is to ignore errors or do rate-limted
logging of them.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ads1x18_triggered_buffer_init(struct ads1x18 *ads1x18)
> +{
> +	struct iio_dev *indio_dev = ads1x18->indio_dev;
> +	struct spi_device *spi = ads1x18->spi;
> +	int ret;
> +
> +	ads1x18->indio_trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d-drdy",
> +						     indio_dev->name,
> +						     iio_device_id(indio_dev));
> +	if (!ads1x18->indio_trig)
> +		return -ENOMEM;
> +
> +	iio_trigger_set_drvdata(ads1x18->indio_trig, ads1x18);
> +	ads1x18->indio_trig->ops = &ads1x18_trigger_ops;
> +
> +	ret = devm_iio_trigger_register(&spi->dev, ads1x18->indio_trig);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					       iio_pollfunc_store_time,
> +					       ads1x18_trigger_handler,
> +					       &ads1x18_buffer_ops);
> +}
> +
> +static int ads1x18_message_init(struct ads1x18 *ads1x18)
> +{
> +	struct spi_device *spi = ads1x18->spi;
> +
> +	/*
> +	 * We need to keep CS asserted to catch "data-ready" interrupts.
> +	 * Otherwise the DOUT/DRDY line enters a Hi-Z state and it can't be
> +	 * driven by the ADC.
> +	 */
> +	ads1x18->xfer.cs_change = 1;

I think this is going to be problamatic for reading/writing the configuration
register and for direct reads of a single sample. My suggestion to make a
separate message with 2 xfers for the single read will partiall solve it.
And we could just use spi_write() for writing the config register.

> +	ads1x18->xfer.tx_buf = ads1x18->tx_buf;
> +	ads1x18->xfer.rx_buf = ads1x18->rx_buf;
> +	ads1x18->xfer.len = sizeof(ads1x18->tx_buf);
> +	spi_message_init_no_memset(&ads1x18->message);
> +	spi_message_add_tail(&ads1x18->xfer, &ads1x18->message);

Can be simplifed with spi_message_init_with_transfers().

> +
> +	return devm_spi_optimize_message(&spi->dev, spi, &ads1x18->message);
> +}
> +
> +static int ads1x18_fill_properties(struct ads1x18 *ads1x18,
> +				   struct fwnode_handle *handle,
> +				   struct iio_chan_spec *chan)
> +{
> +	const struct ads1x18_chip_info *info = ads1x18->chip_info;
> +	struct ads1x18_chan_data *chan_data;
> +	u32 val, reg;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(handle, "reg", &reg);
> +	if (ret)
> +		return ret;
> +	if (reg > ADS1X18_MAX_ADC_ADDR)
> +		return dev_err_probe(&ads1x18->spi->dev, -ENXIO,
> +				     "%s: Invalid channel address %u.\n",
> +				     fwnode_get_name(handle), reg);
> +
> +	*chan = info->channels[reg];
> +
> +	chan_data = &ads1x18->channels[reg];
> +	chan_data->pga_mode = ADS1X18_PGA_DEFAULT;
> +	chan_data->drate_mode = ADS1X18_DRATE_DEFAULT;
> +
> +	if (fwnode_property_present(handle, "ti,gain")) {
> +		ret = fwnode_property_read_u32(handle, "ti,gain", &val);
> +		if (ret)
> +			return ret;
> +		if (val >= info->fsr_table_sz)
> +			return dev_err_probe(&ads1x18->spi->dev, -ENXIO,
> +					     "%s: ti,gain not in range.",
> +					     fwnode_get_name(handle));
> +
> +		chan_data->pga_mode = val;
> +	}
> +
> +	if (fwnode_property_present(handle, "ti,datarate")) {
> +		ret = fwnode_property_read_u32(handle, "ti,datarate", &val);
> +		if (ret)
> +			return ret;
> +		if (val >= info->sps_table_sz)
> +			return dev_err_probe(&ads1x18->spi->dev, -ENXIO,
> +					     "%s: ti,datarate not in range.",
> +					     fwnode_get_name(handle));
> +
> +		chan_data->drate_mode = val;
> +	}

As mentioned in the dt-bindings review. We don't set an initial value
from the devicetree like this. So we should be able to drop all of this.

> +
> +	return 0;
> +}
> +
> +static int ads1x18_channels_init(struct ads1x18 *ads1x18,
> +				 const struct ads1x18_chip_info *info,
> +				 struct iio_chan_spec **cs)
> +{
> +	struct device *dev = &ads1x18->spi->dev;
> +	struct iio_chan_spec *channels;
> +	int ret, nchans, index = 0;
> +
> +	nchans = device_get_named_child_node_count(dev, "channel");
> +	if (!nchans)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "No ADC channels described.\n");
> +
> +	channels = devm_kcalloc(dev, nchans + 2, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		ret = ads1x18_fill_properties(ads1x18, child, &channels[index]);
> +		if (ret)
> +			return ret;
> +
> +		channels[index].scan_index = index;
> +		ads1x18->bufidx_to_addr[index] = channels[index].address;
> +		index++;
> +	}

There is a small enough number of channels that we shouldn't need any of this.
We can just make an array big enough for all channels in struct ads1x18.

> +
> +	ads1x18->channels[ADS1X18_TEMP_ADDR].drate_mode = ADS1X18_DRATE_DEFAULT;
> +	channels[index] = info->channels[ADS1X18_TEMP_ADDR];
> +	channels[index].scan_index = index;
> +	ads1x18->bufidx_to_addr[index] = channels[index].address;
> +	index++;
> +
> +	channels[index] = info->channels[ADS1X18_TIMESTAMP_ADDR];
> +	ads1x18->bufidx_to_addr[index] = channels[index].address;
> +
> +	*cs = channels;
> +
> +	return index;
> +}
> +
> +static int ads1x18_spi_probe(struct spi_device *spi)
> +{
> +	const struct ads1x18_chip_info *info = spi_get_device_match_data(spi);
> +	struct iio_chan_spec *channels;
> +	struct iio_dev *indio_dev;
> +	struct ads1x18 *ads1x18;
> +	int num_channels, ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*ads1x18));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ads1x18 = iio_priv(indio_dev);
> +	ads1x18->spi = spi;
> +	ads1x18->indio_dev = indio_dev;

Usually, we can write code so that a pointer back to indio_dev is not needed.

> +	ads1x18->chip_info = info;
> +	mutex_init(&ads1x18->msg_lock);
> +	init_completion(&ads1x18->data_ready);
> +	spi_set_drvdata(spi, ads1x18);

There is no spi_get_drvdata(), so we don't need this.

> +
> +	num_channels = ads1x18_channels_init(ads1x18, info, &channels);
> +	if (num_channels < 0)
> +		return num_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = info->name;
> +	indio_dev->info = &ads1x18_iio_info;
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	ret = ads1x18_message_init(ads1x18);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1x18_triggered_buffer_init(ads1x18);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1x18_interrupt_init(ads1x18);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static int ads1x18_suspend(struct device *dev)
> +{
> +	struct ads1x18 *ads1x18 = dev_get_drvdata(dev);
> +	u16 cfg;
> +	int ret;
> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	/* Current config is readback into rx_buf[1] */
> +	cfg = be16_to_cpu(ads1x18->rx_buf[1]);
> +	if (FIELD_GET(ADS1X18_CFG_MODE_MASK, cfg) == ADS1X18_MODE_ONESHOT)
> +		return 0;
> +
> +	cfg |= FIELD_PREP(ADS1X18_CFG_MODE_MASK, ADS1X18_MODE_ONESHOT);
> +	ret = ads1x18_write_config(ads1x18, cfg);
> +	if (ret)
> +		return ret;
> +
> +	ads1x18->restore_mode = 1;
> +
> +	return 0;
> +}
> +
> +static int ads1x18_resume(struct device *dev)
> +{
> +	struct ads1x18 *ads1x18 = dev_get_drvdata(dev);
> +	u16 cfg;
> +	int ret;
> +
> +	guard(mutex)(&ads1x18->msg_lock);
> +
> +	if (!ads1x18->restore_mode)
> +		return 0;
> +
> +	cfg = be16_to_cpu(ads1x18->rx_buf[1]);
> +	FIELD_MODIFY(ADS1X18_CFG_MODE_MASK, &cfg, ADS1X18_MODE_CONTINUOUS);
> +	ret = ads1x18_write_config(ads1x18, cfg);
> +	if (ret)
> +		return ret;
> +
> +	ads1x18->restore_mode = 0;
> +
> +	return 0;
> +}

I think we could simplify this and avoid needing to use pm runtime (and use
even less power!). During probe, put the chip in power down mode. When doing
direct reads of a single value, put the chip in single-shot mode. When doing
starting a buffered read, put it in continuous mode and when the buffered read
is stopped, put it back in shutdown mode.

> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ads1x18_pm_ops, ads1x18_suspend, ads1x18_resume);
> +
> +static const int ads1118_fsr_table[][2] = {
> +	[ADS1X18_PGA_MODE_0] = { 0, 187500 },
> +	[ADS1X18_PGA_MODE_1] = { 0, 125000 },
> +	[ADS1X18_PGA_MODE_2] = { 0, 62500 },
> +	[ADS1X18_PGA_MODE_3] = { 0, 31250 },
> +	[ADS1X18_PGA_MODE_4] = { 0, 15625 },
> +	[ADS1X18_PGA_MODE_5] = { 0, 7812 }
> +};
> +
> +static const int ads1018_fsr_table[][2] = {
> +	[ADS1X18_PGA_MODE_0] = { 0, 3000000 },
> +	[ADS1X18_PGA_MODE_1] = { 0, 2000000 },
> +	[ADS1X18_PGA_MODE_2] = { 0, 1000000 },
> +	[ADS1X18_PGA_MODE_3] = { 0, 500000 },
> +	[ADS1X18_PGA_MODE_4] = { 0, 250000 },
> +	[ADS1X18_PGA_MODE_5] = { 0, 125000 }
> +};
> +
> +static const unsigned int ads1018_drate_table[] = {
> +	[ADS1X18_DRATE_MODE_0] = 128,
> +	[ADS1X18_DRATE_MODE_1] = 250,
> +	[ADS1X18_DRATE_MODE_2] = 490,
> +	[ADS1X18_DRATE_MODE_3] = 920,
> +	[ADS1X18_DRATE_MODE_4] = 1600,
> +	[ADS1X18_DRATE_MODE_5] = 2400,
> +	[ADS1X18_DRATE_MODE_6] = 3300
> +};
> +
> +static const unsigned int ads1118_drate_table[] = {
> +	[ADS1X18_DRATE_MODE_0] = 8,
> +	[ADS1X18_DRATE_MODE_1] = 16,
> +	[ADS1X18_DRATE_MODE_2] = 32,
> +	[ADS1X18_DRATE_MODE_3] = 64,
> +	[ADS1X18_DRATE_MODE_4] = 128,
> +	[ADS1X18_DRATE_MODE_5] = 250,
> +	[ADS1X18_DRATE_MODE_6] = 475,
> +	[ADS1X18_DRATE_MODE_7] = 860
> +};

These table could use more descriptive names or comments that exlain what
sort of mapping they are doing.

> +
> +static const struct ads1x18_chip_info ads1018_chip_info = {
> +	.name = "ads1018",
> +
> +	.channels = ads1018_iio_channels,
> +	.channels_sz = ARRAY_SIZE(ads1018_iio_channels),
> +
> +	.fsr_table = ads1018_fsr_table,
> +	.fsr_table_sz = ARRAY_SIZE(ads1018_fsr_table),
> +	.sps_table = ads1018_drate_table,
> +	.sps_table_sz = ARRAY_SIZE(ads1018_drate_table),
> +	.temp_scale = { 0, 125000 },
> +};
> +
> +static const struct ads1x18_chip_info ads1118_chip_info = {
> +	.name = "ads1118",
> +
> +	.channels = ads1118_iio_channels,
> +	.channels_sz = ARRAY_SIZE(ads1118_iio_channels),
> +
> +	.fsr_table = ads1118_fsr_table,
> +	.fsr_table_sz = ARRAY_SIZE(ads1118_fsr_table),
> +	.sps_table = ads1118_drate_table,
> +	.sps_table_sz = ARRAY_SIZE(ads1118_drate_table),
> +	.temp_scale = { 0, 31250 },
> +};
> +
> +static const struct of_device_id ads1x18_of_match[] = {
> +	{ .compatible = "ti,ads1018", .data = &ads1018_chip_info },
> +	{ .compatible = "ti,ads1118", .data = &ads1118_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ads1x18_of_match);
> +
> +static const struct spi_device_id ads1x18_spi_match[] = {
> +	{ "ads1018", (kernel_ulong_t)&ads1018_chip_info },
> +	{ "ads1118", (kernel_ulong_t)&ads1118_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads1x18_spi_match);
> +
> +static struct spi_driver ads1x18_spi_driver = {
> +	.driver = {
> +		.name = "ads1x18",

No x here either.

> +		.of_match_table = ads1x18_of_match,
> +		.pm = pm_sleep_ptr(&ads1x18_pm_ops),
> +	},
> +	.probe = ads1x18_spi_probe,
> +	.id_table = ads1x18_spi_match,
> +};
> +
> +module_spi_driver(ads1x18_spi_driver);
> +
> +MODULE_DESCRIPTION("Texas Instruments ADS1X18 ADC Driver");

or here.

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");
> 


