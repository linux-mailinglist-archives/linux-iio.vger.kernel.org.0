Return-Path: <linux-iio+bounces-13129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB09E5E33
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2641883B18
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA8227B8F;
	Thu,  5 Dec 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B9d30mN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CF21C199
	for <linux-iio@vger.kernel.org>; Thu,  5 Dec 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422963; cv=none; b=oMmvpuD0H8DBn8noLILkdMojgLv9Zgri2SEmrUFaAJsyLIUQxpcz1BcodN2GFUTLX361E7YVlbQXlrCnbB93fLA/NW/uMkwMeNhj569bemWBf/aV4ev9YJElSJ59lZ83JM2MGDNwPiZzuGWbcpndfj8QZyjSAzoBkJNajBcdp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422963; c=relaxed/simple;
	bh=r5W5odRX09VappFuONG/wNvGKeV4YPcTYZBbB0VYd4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHuW+jsas/BvdYAUCHaHWvrPq3Jzlk0Vmv6Ht+vbvMWPePq7VtbfVbwC8jJRFNW5OFraw12lYuI4mczmZAq/a8kTy2AxZKUscpT28c928SWFHZ9DbJvOjEj0f72yllsU2zRSec4jYCEMTLT8B2ZqCREpL5NKNYXjfiFDb60fx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B9d30mN/; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso1200993fac.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Dec 2024 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733422958; x=1734027758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PrAtgjWhGUbT6fpAuSSwUHzgtH1B6FTI5RVBzwZwNo=;
        b=B9d30mN/TgfcxhYZ04YZyPb4WYMk7VZlRqH4mLJTQWqRK+OQub3JtXS5IOkWbhJq3w
         QC30zhgVzIfDlfvSB0mOhk1zig8UrR5DAVlo4edgcQsY8pbNqq3IL8OuSN9bw1IpZxAB
         9CuAJ0zbLpzwl2zniwoX5YeEjhR5imX0dTvhyApGzag0RC0ApcYDGgUxEfDbeRqNLOom
         gQd9wn1gvnnwOAptQ4X7T1mqbVaRi+af6wjCGeNxzFQeT/JyOWbFKXO7xzluXZDzVBRU
         vuXogojHuILYv5HKeESZH9pTcU9uFnCTMFkee+UFr3FWXz9qJqLp5LKIWjxFAh2rHAC+
         FoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733422958; x=1734027758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PrAtgjWhGUbT6fpAuSSwUHzgtH1B6FTI5RVBzwZwNo=;
        b=BYH16LdkqwaFluwO0q6Ev17Jw0KjpyFRsOm3SjHhcc0powNOmZUo4C0RnyoZsc1/7D
         nlWnH7pvAwT4biFStrSOZF777wn5/IFy3P0sL4IbXMUqZyYBbX1uPkyJTZCykiiT2N8c
         wLWzXcrqk+3QOw5aTkk7qWxvxggkP9s63ph1Y3YrcrBcPW8pjgZ4mtpVSO44lhTZ+WiM
         579wcAybxCMaWMFzMrm7bT935hsA2B//BR161k9mCObeLxxPe6EAy3cjStKf5HHy49bG
         k6dwze+qVGVZVyJEEXco29efi2gG4AKq8m5PMYsnNAbTmhZaVcYfv7zjBhsYX8fH/n6F
         w/xg==
X-Forwarded-Encrypted: i=1; AJvYcCW3rj9G8kEcUARUrlWtyY+T0KVcaLP8AT979vvapU/e69RoC/0ymaPhnS31Jt5WIL598H4DlTaPWwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Jib1tjxGgzzSFaunT2OMeCoWn48L9K3ZuZn9OE/zF5hF3DY9
	BtD7632Q4U09Ol5kFbAJw8/+j9BkouVgRNTG0aseOvK9bCzsydIzm9U4NuQdAnc=
X-Gm-Gg: ASbGncve6lpQBND1Bw4dPINKAVBhrfXI9JP1O9FaPJPrISe7mSOqPtx7c3eJR6c0qlt
	cF4mzm+ERZwhCFIo9ko97cms3EruMjlc+Pxk/Ix8wi4sYu2vpup2gx9uMAQvT6xfRgbYgfUcLCB
	PIZr6lCVWvCTtnfeb+2A014tAX2tbNysvzNRhtif44w3L+f4uqEHqBNClNso65NPlt7wnM8J9IM
	Cy/bNH3kMsiUuhmHWVLH2LEwZ7GP6wUuIpE1+IkRLoCYPsrgHAKCP1Rp5CYqYCD4iszLq5PO0x/
	W//C0yRLen0=
X-Google-Smtp-Source: AGHT+IHJA/cbIOIYBSs859F5miq2GrUcx29X6pK5u63jJlhb4HI6Ohl70/7j3yniuY4qdJAn3J6PMg==
X-Received: by 2002:a05:6830:2a06:b0:71d:4733:b723 with SMTP id 46e09a7af769-71dcf4f5409mr21624a34.18.1733422957946;
        Thu, 05 Dec 2024 10:22:37 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc4a02506sm381948a34.47.2024.12.05.10.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 10:22:37 -0800 (PST)
Message-ID: <8f5ca298-54ba-4274-a35d-83be868fcfc8@baylibre.com>
Date: Thu, 5 Dec 2024 12:22:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Eason Yang <j2anfernee@gmail.com>, avifishman70@gmail.com,
 tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
 yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241203091540.3695650-3-j2anfernee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 3:15 AM, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.

In the code, there are channels set up for differential inputs. Should we
remove these until conversion and event support for them is added?

> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/adc/Kconfig   |  10 +
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/nct720x.c | 533 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 545 insertions(+)
>  create mode 100644 drivers/iio/adc/nct720x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bea10a846475..573b12f0cd4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2799,6 +2799,7 @@ F:	arch/arm/mach-npcm/
>  F:	arch/arm64/boot/dts/nuvoton/
>  F:	drivers/*/*/*npcm*
>  F:	drivers/*/*npcm*
> +F:	drivers/iio/adc/nct720x.c
>  F:	drivers/rtc/rtc-nct3018y.c
>  F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
>  F:	include/dt-bindings/clock/nuvoton,npcm845-clk.h
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..6eed518efa1c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1048,6 +1048,16 @@ config NAU7802
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nau7802.
>  
> +config NCT720X
> +	tristate "Nuvoton Instruments NCT7201 and NCT7202 Power Monitor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Nuvoton NCT7201 and
> +	  NCT7202 Voltage Monitor.
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nct720x.

Don't put "x" in the name, just call it nct7201. We always try to avoid
using "x" in the IIO subsystem because too often it causes problems in
the future.

> +
>  config NPCM_ADC
>  	tristate "Nuvoton NPCM ADC driver"
>  	depends on ARCH_NPCM || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ee19afba62b7..89f5b5d1a567 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -94,6 +94,7 @@ obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
>  obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
>  obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
> +obj-$(CONFIG_NCT720X) += nct720x.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_PAC1921) += pac1921.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
> diff --git a/drivers/iio/adc/nct720x.c b/drivers/iio/adc/nct720x.c
> new file mode 100644
> index 000000000000..b28b5f4d7d70
> --- /dev/null
> +++ b/drivers/iio/adc/nct720x.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Nuvoton nct7201 and nct7202 power monitor chips.
> + *
> + * Copyright (c) 2024 Nuvoton Inc.

If there are datasheets available, it would be helpful to link to them here.

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
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Unused header.

> +
> +#define VIN_MAX					12	/* Counted from 1 */
> +#define NCT720X_IN_SCALING			4995
> +#define NCT720X_IN_SCALING_FACTOR		10000
> +
> +#define REG_INTERRUPT_STATUS_1			0x0C
> +#define REG_INTERRUPT_STATUS_2			0x0D
> +#define REG_VOLT_LOW_BYTE			0x0F
> +#define REG_CONFIGURATION			0x10
> +#define  BIT_CONFIGURATION_START		BIT(0)
> +#define  BIT_CONFIGURATION_ALERT_MSK		BIT(1)
> +#define  BIT_CONFIGURATION_CONV_RATE		BIT(2)
> +#define  BIT_CONFIGURATION_RESET		BIT(7)
> +
> +#define REG_ADVANCED_CONFIGURATION		0x11
> +#define  BIT_ADVANCED_CONF_MOD_ALERT		BIT(0)
> +#define  BIT_ADVANCED_CONF_MOD_STS		BIT(1)
> +#define  BIT_ADVANCED_CONF_FAULT_QUEUE		BIT(2)
> +#define  BIT_ADVANCED_CONF_EN_DEEP_SHUTDOWN	BIT(4)
> +#define  BIT_ADVANCED_CONF_EN_SMB_TIMEOUT	BIT(5)
> +#define  BIT_ADVANCED_CONF_MOD_RSTIN		BIT(7)
> +
> +#define REG_CHANNEL_INPUT_MODE			0x12
> +#define REG_CHANNEL_ENABLE_1			0x13
> +#define  REG_CHANNEL_ENABLE_1_MASK		GENMASK(7, 0)
> +#define REG_CHANNEL_ENABLE_2			0x14
> +#define  REG_CHANNEL_ENABLE_2_MASK		GENMASK(3, 0)
> +#define REG_INTERRUPT_MASK_1			0x15
> +#define REG_INTERRUPT_MASK_2			0x16
> +#define REG_BUSY_STATUS				0x1E
> +#define  BIT_BUSY				BIT(0)
> +#define  BIT_PWR_UP				BIT(1)
> +#define REG_ONE_SHOT				0x1F
> +#define REG_SMUS_ADDRESS			0xFC
> +#define REG_VIN_LIMIT_LSB_MASK			GENMASK(4, 0)
> +
> +static const u8 REG_VIN[VIN_MAX] = {

Usually ALL_CAPS is reserved for macros and static const data is
lower_snake_case. Plus, prefer to always add the driver name as
a namespace to help avoid conflics with more generic names.

Example:

static const u8 nct7201_reg_vin[NCT7201_VIN_MAX] = {

Or (even better IMHO) just turn these into macros and avoid
the tables:

#define NCT7201_REG_VIN(i) (i)
#define NCT7201_REG_VIN_HIGH_LIMIT(i) (0x20 + (i) * 2)
#define NCT7201_REG_VIN_LOW_LIMIT(i) (0x21 + (i) * 2)

> +	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,	/* 0 -7 */
> +	0x08, 0x09, 0x0A, 0x0B,				/* 8 - 11 */
> +};
> +static const u8 REG_VIN_HIGH_LIMIT[VIN_MAX] = {
> +	0x20, 0x22, 0x24, 0x26, 0x28, 0x2A, 0x2C, 0x2E,
> +	0x30, 0x32, 0x34, 0x36,
> +};
> +static const u8 REG_VIN_LOW_LIMIT[VIN_MAX] = {
> +	0x21, 0x23, 0x25, 0x27, 0x29, 0x2B, 0x2D, 0x2F,
> +	0x31, 0x33, 0x35, 0x37,
> +};
> +static const u8 REG_VIN_HIGH_LIMIT_LSB[VIN_MAX] = {
> +	0x40, 0x42, 0x44, 0x46, 0x48, 0x4A, 0x4C, 0x4E,
> +	0x50, 0x52, 0x54, 0x56,
> +};
> +static const u8 REG_VIN_LOW_LIMIT_LSB[VIN_MAX] = {
> +	0x41, 0x43, 0x45, 0x47, 0x49, 0x4B, 0x4D, 0x4F,
> +	0x51, 0x53, 0x55, 0x57,
> +};
> +static u8 nct720x_chan_to_index[] = {

Should be const. Although, even better, just store this value in
the address field, then we don't need the translation table.

Right now, the address is always the same as the channel, so it
is redundant anyway.

> +	0 /* Not used */, 0, 1, 2, 3, 4, 5, 6,
> +	7, 8, 9, 10, 11,
> +};
> +
> +struct nct720x_chip_info {
> +	struct i2c_client *client;
> +	struct mutex access_lock;	/* for multi-byte read and write operations */
> +	struct regmap *regmap;
> +	struct regmap *regmap16;
> +	int vin_max;			/* number of VIN channels */

We could rename this to num_vin_channels, then we wouldn't need
a comment to explain it.

> +	u32 vin_mask;
> +};
> +
> +struct nct720x_adc_model_data {
> +	const char *model_name;
> +	const struct iio_chan_spec *channels;
> +	const int num_channels;
> +	int vin_max;
> +};
> +
> +static const struct iio_event_spec nct720x_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define NCT720X_VOLTAGE_CHANNEL(chan, addr)				\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = chan,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.address = addr,					\
> +		.event_spec = nct720x_events,				\
> +		.num_event_specs = ARRAY_SIZE(nct720x_events),		\
> +	}
> +
> +#define NCT720X_VOLTAGE_CHANNEL_DIFF(chan1, chan2, addr)		\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (chan1),					\
> +		.channel2 = (chan2),					\
> +		.differential = 1,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.address = addr,					\
> +		.event_spec = nct720x_events,				\
> +		.num_event_specs = ARRAY_SIZE(nct720x_events),		\
> +	}
> +
> +static const struct iio_chan_spec nct7201_channels[] = {
> +	NCT720X_VOLTAGE_CHANNEL(1, 1),
> +	NCT720X_VOLTAGE_CHANNEL(2, 2),
> +	NCT720X_VOLTAGE_CHANNEL(3, 3),
> +	NCT720X_VOLTAGE_CHANNEL(4, 4),
> +	NCT720X_VOLTAGE_CHANNEL(5, 5),
> +	NCT720X_VOLTAGE_CHANNEL(6, 6),
> +	NCT720X_VOLTAGE_CHANNEL(7, 7),
> +	NCT720X_VOLTAGE_CHANNEL(8, 8),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(1, 2, 1),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(3, 4, 3),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(5, 6, 5),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(7, 8, 7),
> +};
> +
> +static const struct iio_chan_spec nct7202_channels[] = {
> +	NCT720X_VOLTAGE_CHANNEL(1, 1),
> +	NCT720X_VOLTAGE_CHANNEL(2, 2),
> +	NCT720X_VOLTAGE_CHANNEL(3, 3),
> +	NCT720X_VOLTAGE_CHANNEL(4, 4),
> +	NCT720X_VOLTAGE_CHANNEL(5, 5),
> +	NCT720X_VOLTAGE_CHANNEL(6, 6),
> +	NCT720X_VOLTAGE_CHANNEL(7, 7),
> +	NCT720X_VOLTAGE_CHANNEL(8, 8),
> +	NCT720X_VOLTAGE_CHANNEL(9, 9),
> +	NCT720X_VOLTAGE_CHANNEL(10, 10),
> +	NCT720X_VOLTAGE_CHANNEL(11, 11),
> +	NCT720X_VOLTAGE_CHANNEL(12, 12),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(1, 2, 1),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(3, 4, 3),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(5, 6, 5),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(7, 8, 7),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(9, 10, 9),
> +	NCT720X_VOLTAGE_CHANNEL_DIFF(11, 12, 11),
> +};
> +
> +static int nct720x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	int index = nct720x_chan_to_index[chan->address];
> +	u16 volt;
> +	unsigned int value;
> +	int err;
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&chip->access_lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = regmap_read(chip->regmap16, REG_VIN[index], &value);
> +		if (err < 0)
> +			return err;
> +		volt = (u16)value;
> +		*val = volt >> 3;

It seems strange that this is 13 bits when the chips are 8 and 12 bit.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* From the datasheet, we have to multiply by 0.0004995 */

The scale is the same for both 8 bit and 12 bit chips?

> +		*val = 0;
> +		*val2 = 499500;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int nct720x_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	u16 volt;
> +	unsigned int value;
> +	int tmp, err;
> +	int index = nct720x_chan_to_index[chan->address];
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;

Do we need guard(mutex)(&chip->access_lock); here?

> +
> +	if (dir == IIO_EV_DIR_FALLING) {
> +		err = regmap_read(chip->regmap16, REG_VIN_LOW_LIMIT[index], &value);
> +		if (err < 0)
> +			return err;
> +		volt = (u16)value;
> +	} else {
> +		err = regmap_read(chip->regmap16, REG_VIN_HIGH_LIMIT[index], &value);
> +		if (err < 0)
> +			return err;
> +		volt = (u16)value;
> +	}
> +
> +	/* Voltage(V) = 13bitCountValue * 0.0004995 */
> +	tmp = (volt >> 3) * NCT720X_IN_SCALING;
> +	*val = tmp / NCT720X_IN_SCALING_FACTOR;

I'm pretty sure event threshold values need to be in raw units to match
the `in_voltageY_raw` attributes, so the scaling factor would not be
applied here.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int nct720x_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	int index, err = 0;
> +	long v1, v2, volt;
> +
> +	index = nct720x_chan_to_index[chan->address];
> +	volt = (val * NCT720X_IN_SCALING_FACTOR) / NCT720X_IN_SCALING;

Same applies here.

> +	v1 = volt >> 5;
> +	v2 = (volt & REG_VIN_LIMIT_LSB_MASK) << 3;

Looks like FIELD_PREP() could be used here.

> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info == IIO_EV_INFO_VALUE) {
> +		if (dir == IIO_EV_DIR_FALLING) {
> +			guard(mutex)(&chip->access_lock);
> +			err = regmap_write(chip->regmap, REG_VIN_LOW_LIMIT[index], v1);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_LOW_LIMIT\n",
> +					index + 1);
> +
> +			err = regmap_write(chip->regmap, REG_VIN_LOW_LIMIT_LSB[index], v2);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_LOW_LIMIT_LSB\n",
> +					index + 1);
> +
> +		} else {
> +			guard(mutex)(&chip->access_lock);
> +			err = regmap_write(chip->regmap, REG_VIN_HIGH_LIMIT[index], v1);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_HIGH_LIMIT\n",
> +					index + 1);
> +
> +			err = regmap_write(chip->regmap, REG_VIN_HIGH_LIMIT_LSB[index], v2);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_HIGH_LIMIT_LSB\n",
> +					index + 1);
> +		}
> +	}
> +	return err;
> +}
> +
> +static int nct720x_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	int index = nct720x_chan_to_index[chan->address];
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	return !!(chip->vin_mask & BIT(index));
> +}
> +
> +static int nct720x_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	int err = 0;
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	int index = nct720x_chan_to_index[chan->address];
> +	unsigned int mask;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	mask = BIT(index);
> +
> +	if (!state && (chip->vin_mask & mask))
> +		chip->vin_mask &= ~mask;
> +	else if (state && !(chip->vin_mask & mask))
> +		chip->vin_mask |= mask;
> +
> +	guard(mutex)(&chip->access_lock);
> +
> +	err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_1,
> +			   chip->vin_mask & REG_CHANNEL_ENABLE_1_MASK);
> +	if (err < 0)
> +		dev_err(&indio_dev->dev, "Failed to write REG_CHANNEL_ENABLE_1\n");
> +
> +	if (chip->vin_max == 12) {
> +		err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_2, chip->vin_mask >> 8);
> +		if (err < 0)
> +			dev_err(&indio_dev->dev, "Failed to write REG_CHANNEL_ENABLE_2\n");
> +	}
> +	return err;
> +}
> +
> +static const struct iio_info nct720x_info = {
> +	.read_raw = nct720x_read_raw,
> +	.read_event_config = nct720x_read_event_config,
> +	.write_event_config = nct720x_write_event_config,
> +	.read_event_value = nct720x_read_event_value,
> +	.write_event_value = nct720x_write_event_value,
> +};
> +
> +static const struct nct720x_adc_model_data nct7201_model_data = {
> +	.model_name = "nct7201",
> +	.channels = nct7201_channels,
> +	.num_channels = ARRAY_SIZE(nct7201_channels),
> +	.vin_max = 8,
> +};
> +
> +static const struct nct720x_adc_model_data nct7202_model_data = {
> +	.model_name = "nct7202",
> +	.channels = nct7202_channels,
> +	.num_channels = ARRAY_SIZE(nct7202_channels),
> +	.vin_max = 12,
> +};
> +
> +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> +{
> +	u8 data[2];
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, REG_CONFIGURATION, BIT_CONFIGURATION_RESET);
> +	if (err) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CONFIGURATION\n");
> +		return err;

Better would be `return dev_err_probe()`. But it is very rare for
regmap_write() to fail so usually we don't print an error message
for these.

> +	}
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then
> +	 * the Power Up bit will be set to 1. If not, wait for it.

I don't see anything that looks like waiting after checking the power
up bit.

> +	 */
> +	mdelay(25);
> +	err  = regmap_read(chip->regmap, REG_BUSY_STATUS, &value);
> +	if (err < 0)
> +		return err;
> +	if (!(value & BIT_PWR_UP))
> +		return err;

Won't this return 0? It seems like it should be returning an error code.

Better would be something like:

		return dev_err_probe(dev, -EIO, "failed to power up after reset\n");

> +
> +	/* Enable Channel */
> +	err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_1, REG_CHANNEL_ENABLE_1_MASK);
> +	if (err) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_1\n");
> +		return err;
> +	}
> +
> +	if (chip->vin_max == 12) {
> +		err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_2, REG_CHANNEL_ENABLE_2_MASK);
> +		if (err) {
> +			dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_2\n");
> +			return err;
> +		}
> +	}
> +
> +	guard(mutex)(&chip->access_lock);

Why guard here and not before other regmap access in this function?

Since this is only called during probe, we probably don't need the guard.

> +	err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value);
> +	if (err < 0)
> +		return err;
> +	data[0] = (u8)value;
> +
> +	err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value);
> +	if (err < 0)
> +		return err;
> +	data[1] = (u8)value;
> +
> +	value = get_unaligned_le16(data);
> +	chip->vin_mask = value;
> +
> +	/* Start monitoring if needed */
> +	err = regmap_read(chip->regmap, REG_CONFIGURATION, &value);
> +	if (err < 0) {
> +		dev_err(&chip->client->dev, "Failed to read REG_CONFIGURATION\n");
> +		return value;
> +	}
> +
> +	value |= BIT_CONFIGURATION_START;
> +	err = regmap_write(chip->regmap, REG_CONFIGURATION, value);
> +	if (err < 0) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CONFIGURATION\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config nct720x_regmap8_config = {
> +	.name = "vin-data-read-byte",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xff,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const struct regmap_config nct720x_regmap16_config = {
> +	.name = "vin-data-read-word",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0xff,
> +	.cache_type = REGCACHE_NONE,

REGCACHE_NONE is the default, so can be omitted.

> +};
> +
> +static int nct720x_probe(struct i2c_client *client)
> +{
> +	const struct nct720x_adc_model_data *model_data;
> +	struct nct720x_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	model_data = i2c_get_match_data(client);
> +	if (!model_data)
> +		return -EINVAL;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	chip = iio_priv(indio_dev);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &nct720x_regmap8_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> +			"Failed to init regmap\n");
> +
> +	chip->regmap16 = devm_regmap_init_i2c(client, &nct720x_regmap16_config);
> +	if (IS_ERR(chip->regmap16))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16),
> +			"Failed to init regmap16\n");
> +
> +	chip->vin_max = model_data->vin_max;
> +
> +	ret = devm_mutex_init(&client->dev, &chip->access_lock);
> +	if (ret)
> +		return ret;
> +
> +	chip->client = client;
> +
> +	ret = nct720x_init_chip(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->name = model_data->model_name;
> +	indio_dev->channels = model_data->channels;
> +	indio_dev->num_channels = model_data->num_channels;
> +	indio_dev->info = &nct720x_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id nct720x_id[] = {
> +	{ "nct7201", (kernel_ulong_t)&nct7201_model_data },
> +	{ "nct7202", (kernel_ulong_t)&nct7202_model_data },

To be consistent with [1], please add .name = and .driver_data = in this table.

[1]: https://lore.kernel.org/linux-iio/20241204150036.1695824-2-u.kleine-koenig@baylibre.com/

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, nct720x_id);
> +
> +static const struct of_device_id nct720x_of_match[] = {
> +	{
> +		.compatible = "nuvoton,nct7201",
> +		.data = &nct7201_model_data,
> +	},
> +	{
> +		.compatible = "nuvoton,nct7202",
> +		.data = &nct7202_model_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nct720x_of_match);
> +
> +static struct i2c_driver nct720x_driver = {
> +	.driver = {
> +		.name	= "nct720x",
> +		.of_match_table = nct720x_of_match,
> +	},
> +	.probe = nct720x_probe,
> +	.id_table = nct720x_id,
> +};
> +module_i2c_driver(nct720x_driver);
> +
> +MODULE_AUTHOR("Eason Yang <j2anfernee@gmail.com>");
> +MODULE_DESCRIPTION("Nuvoton NCT720x voltage monitor driver");
> +MODULE_LICENSE("GPL");


