Return-Path: <linux-iio+bounces-14761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B125A241B3
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250E516721D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0A1F03ED;
	Fri, 31 Jan 2025 17:14:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2B38DF9;
	Fri, 31 Jan 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343685; cv=none; b=tjhLQhvxG/LGeOu6EcatymIUCM7OyzsaeQ8odtW3N88+a35t7ALuYuX4bG7Hh24LsmEj8vng0mWUp0V+kNv3EvTHlMVsbgWRNNu6NS2mLK98d7Hz5e9raNSjka2CWevQpxSAfwu9ueoVqD+NOah+Q/mHSFS8VaO7ORyfbQXo9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343685; c=relaxed/simple;
	bh=DWrbM1OPPKJ/c+KMhjtfQA5MEWOMGGnbEw89xPCUknI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRRyNsynaqbMA3HIaRTReICXdSPmlSczw2uexhmTlHsPWMAUeHPFnbinHB8YLVuTxBup3IWPRG5DNlzVdgDHjv8c/9eZx5A2YzPbTzs60YsJObUP/HULuyFhwA2u1VFIIYmGOrVuwS6gK2pFxEDVgh9UhthG3x+utUha3tzCOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl2YK2Z1rz6K61Y;
	Sat,  1 Feb 2025 01:13:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7637E140A86;
	Sat,  1 Feb 2025 01:14:39 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 18:14:38 +0100
Date: Fri, 31 Jan 2025 17:14:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones
	<lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij
	<linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>, David Lechner
	<dlechner@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, "Trevor
 Gamblin" <tgamblin@baylibre.com>, Matteo Martelli
	<matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] mfd: Add ROHM BD79124 ADC/GPO
Message-ID: <20250131171436.00002583@huawei.com>
In-Reply-To: <cc30cf6859b5e5a7320282709f428cd42717ac6b.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
	<cc30cf6859b5e5a7320282709f428cd42717ac6b.1738328714.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 15:37:06 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add core driver for the ROHM BD79124 ADC / GPO.
> 
> The core driver launches the sub-drivers for the pinmux/GPO and for the
> IIO ADC. It also provides the regmap, and forwards the IRQ resource to
> the ADC.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
As per response in cover letter. This is a common device combination and so
far I don't think we ever bothered with an MFD. Lots of ADCs provide
GPIO chips as well so I'd just squash it into the ADC driver.

> ---
>  drivers/mfd/Kconfig              |  12 +++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd79124.c       | 165 +++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd79124.h |  32 ++++++
>  4 files changed, 210 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd79124.c
>  create mode 100644 include/linux/mfd/rohm-bd79124.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae23b317a64e..f024256fb180 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2113,6 +2113,18 @@ config MFD_ROHM_BD71828
>  	  also a single-cell linear charger, a Coulomb counter, a real-time
>  	  clock (RTC), GPIOs and a 32.768 kHz clock gate.
>  
> +config MFD_ROHM_BD79124
> +	tristate "Rohm BD79124 core driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the ROHM BD79124 ADC core. The
> +	  ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> +	  also an automatic measurement mode, with an alarm interrupt for
> +	  out-of-window measurements. The window is configurable for each
> +	  channel. The ADC inputs can optionally be used as general purpose
> +	  outputs.
> +
>  config MFD_ROHM_BD957XMUF
>  	tristate "ROHM BD9576MUF and BD9573MUF Power Management ICs"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e057d6d6faef..c7d64e933a7d 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -270,6 +270,7 @@ obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
> +obj-$(CONFIG_MFD_ROHM_BD79124)	+= rohm-bd79124.o
>  obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
>  obj-$(CONFIG_MFD_ROHM_BD96801)	+= rohm-bd96801.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> diff --git a/drivers/mfd/rohm-bd79124.c b/drivers/mfd/rohm-bd79124.c
> new file mode 100644
> index 000000000000..c35ab0e03b0b
> --- /dev/null
> +++ b/drivers/mfd/rohm-bd79124.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (C) 2025 ROHM Semiconductors
> +//
> +// ROHM BD79124 ADC / GPO driver
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>

mod_devicetable.h

> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rohm-bd79124.h>
> +
> +static struct resource adc_alert;

What if we have two of these?

> +
> +enum {
> +	CELL_PINMUX,
> +	CELL_ADC,
> +};
> +
> +static struct mfd_cell bd79124_cells[] = {
> +	[CELL_PINMUX]	= { .name = "bd79124-pinmux", },
> +	[CELL_ADC]	= { .name = "bd79124-adc", },
> +};
> +
> +/* Read-only regs */
> +static const struct regmap_range bd79124_ro_ranges[] = {
> +	{
> +		.range_min = BD79124_REG_EVENT_FLAG,
> +		.range_max = BD79124_REG_EVENT_FLAG,
> +	}, {
> +		.range_min = BD79124_REG_RECENT_CH0_LSB,
> +		.range_max = BD79124_REG_RECENT_CH7_MSB,
> +	},
> +};
> +
> +static const struct regmap_access_table bd79124_ro_regs = {
> +	.no_ranges	= &bd79124_ro_ranges[0],
> +	.n_no_ranges	= ARRAY_SIZE(bd79124_ro_ranges),
> +};
> +
> +static const struct regmap_range bd79124_volatile_ranges[] = {
> +	{
> +		.range_min = BD79124_REG_RECENT_CH0_LSB,
> +		.range_max = BD79124_REG_RECENT_CH7_MSB,
> +	}, {
> +		.range_min = BD79124_REG_EVENT_FLAG,
> +		.range_max = BD79124_REG_EVENT_FLAG,
> +	}, {
> +		.range_min = BD79124_REG_EVENT_FLAG_HI,
> +		.range_max = BD79124_REG_EVENT_FLAG_HI,
> +	}, {
> +		.range_min = BD79124_REG_EVENT_FLAG_LO,
> +		.range_max = BD79124_REG_EVENT_FLAG_LO,
> +	}, {
> +		.range_min = BD79124_REG_SYSTEM_STATUS,
> +		.range_max = BD79124_REG_SYSTEM_STATUS,
> +	},
> +};
> +
> +static const struct regmap_access_table bd79124_volatile_regs = {
> +	.yes_ranges	= &bd79124_volatile_ranges[0],
> +	.n_yes_ranges	= ARRAY_SIZE(bd79124_volatile_ranges),
> +};
> +
> +static const struct regmap_range bd79124_precious_ranges[] = {
> +	{
> +		.range_min = BD79124_REG_EVENT_FLAG_HI,
> +		.range_max = BD79124_REG_EVENT_FLAG_HI,
> +	}, {
> +		.range_min = BD79124_REG_EVENT_FLAG_LO,
> +		.range_max = BD79124_REG_EVENT_FLAG_LO,
> +	},
> +};
> +
> +static const struct regmap_access_table bd79124_precious_regs = {
> +	.yes_ranges	= &bd79124_precious_ranges[0],
> +	.n_yes_ranges	= ARRAY_SIZE(bd79124_precious_ranges),
> +};
> +
> +static const struct regmap_config bd79124_regmap = {
> +	.reg_bits		= 16,
> +	.val_bits		= 8,
> +	.read_flag_mask		= BD79124_I2C_MULTI_READ,
> +	.write_flag_mask	= BD79124_I2C_MULTI_WRITE,
> +	.max_register		= BD79124_REG_MAX,
> +	.cache_type		= REGCACHE_MAPLE,
> +	.volatile_table		= &bd79124_volatile_regs,
> +	.wr_table		= &bd79124_ro_regs,
> +	.precious_table		= &bd79124_precious_regs,
> +};
> +
> +static int bd79124_probe(struct i2c_client *i2c)
> +{
> +	int ret;
> +	struct regmap *map;
> +	struct device *dev = &i2c->dev;
> +	int *adc_vref;

Wrap that in a structure.  It's just a bit too odd to have just
one integer!

> +
> +	adc_vref = devm_kzalloc(dev, sizeof(*adc_vref), GFP_KERNEL);
> +	if (!adc_vref)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Better to enable regulators here so we don't need to worry about the
> +	 * order of sub-device instantiation. We also need to deliver the
> +	 * reference voltage value to the ADC driver. This is done via
> +	 * the MFD driver's drvdata.
> +	 */
> +	*adc_vref = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (*adc_vref < 0)
> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
> +
> +	dev_set_drvdata(dev, adc_vref);
> +
> +	ret = devm_regulator_get_enable(dev, "iovdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
> +
> +	map = devm_regmap_init_i2c(i2c, &bd79124_regmap);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "Failed to initialize Regmap\n");
> +
> +	if (i2c->irq) {
> +		adc_alert = DEFINE_RES_IRQ_NAMED(i2c->irq, "thresh-alert");
> +		bd79124_cells[CELL_ADC].resources = &adc_alert;
> +		bd79124_cells[CELL_ADC].num_resources = 1;
> +	}
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, bd79124_cells,
> +				   ARRAY_SIZE(bd79124_cells), NULL, 0, NULL);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Failed to create subdevices\n");
return dev_err_probe();

Then return 0 in other path.

> +
> +	return ret;
> +}
>
> diff --git a/include/linux/mfd/rohm-bd79124.h b/include/linux/mfd/rohm-bd79124.h
> new file mode 100644
> index 000000000000..505faeb6f135
> --- /dev/null
> +++ b/include/linux/mfd/rohm-bd79124.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2021 ROHM Semiconductors.

No update on that date?

> + *
> + * Author: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> + */
> +
> +#ifndef _MFD_BD79124_H
> +#define _MFD_BD79124_H
> +
> +#define BD79124_I2C_MULTI_READ		0x30
> +#define BD79124_I2C_MULTI_WRITE		0x28
> +#define BD79124_REG_MAX			0xaf
> +
> +#define BD79124_REG_SYSTEM_STATUS	0x0

Give it two digits. 0x00 for ever so slight readability advantage.

> +#define BD79124_REG_GEN_CFG		0x01
> +#define BD79124_REG_OPMODE_CFG		0x04
> +#define BD79124_REG_PINCFG		0x05
> +#define BD79124_REG_GPO_VAL		0x06
> +#define BD79124_REG_SEQUENCE_CFG	0x10
> +#define BD79124_REG_MANUAL_CHANNELS	0x11
> +#define BD79124_REG_AUTO_CHANNELS	0x12
> +#define BD79124_REG_ALERT_CH_SEL	0x14
> +#define BD79124_REG_EVENT_FLAG		0x18
> +#define BD79124_REG_EVENT_FLAG_HI	0x1a
> +#define BD79124_REG_EVENT_FLAG_LO	0x1c
> +#define BD79124_REG_HYSTERESIS_CH0	0x20
> +#define BD79124_REG_EVENTCOUNT_CH0	0x22
> +#define BD79124_REG_RECENT_CH0_LSB	0xa0
> +#define BD79124_REG_RECENT_CH7_MSB	0xaf
> +
> +#endif


