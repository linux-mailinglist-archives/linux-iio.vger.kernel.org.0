Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABAC256946
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgH2RMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2RME (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:12:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA1920757;
        Sat, 29 Aug 2020 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598721122;
        bh=TBTW6O/SOyrWxdXint2uEy+GVrwvDDBzwDYVjwcSQxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPZCAqsG+xlsKiz40FHC48oCdoZkwsosNUckCNH5WIzBokR6tiKs9NrP7LBKWqOpR
         baVFgd74/jXK0a4FRAtfKhzvEocuTh7oTYIDkOZdJrQpl4lhLs98qaLA66R2sSWJ61
         +5M/yvYV+4GhJg7lAsnpApCxwpy/8KORrEMHLaes=
Date:   Sat, 29 Aug 2020 18:11:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v3 1/2] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20200829181157.1b653a88@archlinux>
In-Reply-To: <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
        <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Aug 2020 17:06:24 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add MT6360 ADC driver include Charger Current, Voltage, and
> Temperature.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
Hi Gene,

A few comments inline.  The big one centres on why we can't
expose the channels as _raw, _offset and _scale?

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig      |  11 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mt6360-adc.c | 366 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 378 insertions(+)
>  create mode 100644 drivers/iio/adc/mt6360-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 66d9cc0..07dcea7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -703,6 +703,17 @@ config MCP3911
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp3911.
>  
> +config MEDIATEK_MT6360_ADC
> +	tristate "Mediatek MT6360 ADC Part"
> +	depends on MFD_MT6360
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to enable MT6360 ADC Part.
> +	  Integrated for System Monitoring include
> +	  Charger and Battery Current, Voltage and
> +	  Temperature
> +
>  config MEDIATEK_MT6577_AUXADC
>  	tristate "MediaTek AUXADC driver"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 90f94ad..5fca90a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) += max9611.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MCP3911) += mcp3911.o
> +obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> new file mode 100644
> index 0000000..5eed812
> --- /dev/null
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + *
> + * Author: Gene Chen <gene_chen@richtek.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MT6360_REG_PMUCHGCTRL3	0x313
> +#define MT6360_REG_PMUADCCFG	0x356
> +#define MT6360_REG_PMUADCRPT1	0x35A
> +
> +/* PMUCHGCTRL3 0x313 */
> +#define MT6360_AICR_MASK	0xFC
> +#define MT6360_AICR_SHFT	2
> +#define MT6360_AICR_400MA	0x6
> +/* PMUADCCFG 0x356 */
> +#define MT6360_ADCEN_MASK	0x8000
> +/* PMUADCRPT1 0x35A */
> +#define MT6360_PREFERCH_MASK	0xF0
> +#define MT6360_PREFERCH_SHFT	4
> +#define MT6360_RPTCH_MASK	0x0F
> +
> +enum {
> +	MT6360_CHAN_USBID = 0,
> +	MT6360_CHAN_VBUSDIV5,
> +	MT6360_CHAN_VBUSDIV2,
> +	MT6360_CHAN_VSYS,
> +	MT6360_CHAN_VBAT,
> +	MT6360_CHAN_IBUS,
> +	MT6360_CHAN_IBAT,
> +	MT6360_CHAN_CHG_VDDP,
> +	MT6360_CHAN_TEMP_JC,
> +	MT6360_CHAN_VREF_TS,
> +	MT6360_CHAN_TS,
> +	MT6360_CHAN_MAX,
> +};
> +
> +struct mt6360_adc_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct completion adc_complete;
> +	struct mutex adc_lock;
> +	ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> +	int irq;
> +};
> +
> +static inline int mt6360_adc_val_converter(int val, int multiplier, int offset, int divisor)
> +{
> +	return ((val * multiplier) + offset) / divisor;

Why could we not report these values to userspace or consumer drivers and let
them deal with the conversion if they actually needed it?
Mapping this to

(val + new_offset) * multiplier would be a little messy, but not too bad.

The advantage would be that we would then be providing the data needed
to get real units for values read from the buffers without having to
do all the maths in kernel (without access to floating point).

 
> +}
> +
> +static int mt6360_adc_convert_processed_val(struct mt6360_adc_data *info, int chan_idx, int *val)
> +{
> +	unsigned int regval = 0;
> +	const struct converter {
> +		int multiplier;
> +		int offset;
> +		int divisor;
> +	} adc_converter[MT6360_CHAN_MAX] = {
> +		{ 1250, 0, 1}, /* USBID */
> +		{ 6250, 0, 1}, /* VBUSDIV5 */
> +		{ 2500, 0, 1}, /* VBUSDIV2 */
> +		{ 1250, 0, 1}, /* VSYS */
> +		{ 1250, 0, 1}, /* VBAT */
> +		{ 2500, 0, 1}, /* IBUS */
> +		{ 2500, 0, 1}, /* IBAT */
> +		{ 1250, 0, 1}, /* CHG_VDDP */
> +		{ 105, -8000, 100}, /* TEMP_JC */
> +		{ 1250, 0, 1}, /* VREF_TS */
> +		{ 1250, 0, 1}, /* TS */
> +	}, sp_ibus_adc_converter = { 1900, 0, 1 }, *sel_converter;
> +	int ret;
> +
> +	sel_converter = adc_converter + chan_idx;
> +	if (chan_idx == MT6360_CHAN_IBUS) {
> +		/* ibus chan will be affected by aicr config */
> +		/* if aicr < 400, apply the special ibus converter */
> +		ret = regmap_read(info->regmap, MT6360_REG_PMUCHGCTRL3, &regval);
> +		if (ret)
> +			return ret;
> +
> +		regval = (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
> +		if (regval < MT6360_AICR_400MA)
> +			sel_converter = &sp_ibus_adc_converter;
> +	}
> +
> +	*val = mt6360_adc_val_converter(*val, sel_converter->multiplier, sel_converter->offset,
> +					sel_converter->divisor);
> +
> +	return 0;
> +}
> +
> +static int mt6360_adc_read_processed(struct mt6360_adc_data *mad, int channel, int *val)
> +{
> +	u16 adc_enable;
> +	u8 rpt[3];
> +	ktime_t start_t, predict_end_t;
> +	long timeout;
> +	int value, ret;
> +
> +	mutex_lock(&mad->adc_lock);
> +
> +	/* select preferred channel that we want */
> +	ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> +				 channel << MT6360_PREFERCH_SHFT);
> +	if (ret)
> +		goto out_adc;
> +
> +	/* enable adc channel we want and adc_en */
> +	adc_enable = MT6360_ADCEN_MASK | BIT(channel);
> +	adc_enable = cpu_to_be16(adc_enable);

Use a local be16 to store that. It will make it a little clearer
that we are doing something 'unusual' here.  Perhaps a comment on
why this odd code exists would also help?

> +	ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(u16));
> +	if (ret)
> +		goto out_adc;
> +
> +	start_t = ktime_get();
> +	predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 50);
> +
> +	if (ktime_after(start_t, predict_end_t))
> +		predict_end_t = ktime_add_ms(start_t, 25);
> +	else
> +		predict_end_t = ktime_add_ms(start_t, 75);
> +
> +	enable_irq(mad->irq);
> +adc_retry:
> +	reinit_completion(&mad->adc_complete);
> +
> +	/* wait for conversion to complete */
> +	timeout = wait_for_completion_timeout(&mad->adc_complete, msecs_to_jiffies(200));
> +	if (timeout == 0) {
> +		ret = -ETIMEDOUT;
> +		goto out_adc_conv;
> +	} else if (timeout < 0) {
> +		ret = -EINTR;
> +		goto out_adc_conv;
> +	}
> +
> +	ret = regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
> +	if (ret)
> +		goto out_adc_conv;
> +
> +	/* check the current reported channel */
> +	if ((rpt[0] & MT6360_RPTCH_MASK) != channel) {
> +		dev_dbg(mad->dev, "not wanted channel report [%02x]\n", rpt[0]);

This and the one below feel like error messages rather than debug ones.

> +		goto adc_retry;
> +	}
> +
> +	if (!ktime_after(ktime_get(), predict_end_t)) {
> +		dev_dbg(mad->dev, "time is not after one adc_conv_t\n");

Does this actually happen? If feels like we are being a bit over protective
here.  I'd definitely like to see a comment saying why this protection
might be needed.

> +		goto adc_retry;
> +	}
> +
> +	value = (rpt[1] << 8) | rpt[2];
> +
> +	ret = mt6360_adc_convert_processed_val(mad, channel, &value);
> +	if (ret)
> +		goto out_adc_conv;
> +
> +	*val = value;
> +	ret = IIO_VAL_INT;
> +
> +out_adc_conv:
> +	disable_irq(mad->irq);
> +	adc_enable = MT6360_ADCEN_MASK;
> +	adc_enable = cpu_to_be16(adc_enable);
> +	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(u16));
> +	mad->last_off_timestamps[channel] = ktime_get();
> +	/* set prefer channel to 0xf */
> +	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> +			   0xF << MT6360_PREFERCH_SHFT);
> +out_adc:
> +	mutex_unlock(&mad->adc_lock);
> +
> +	return ret;
> +}
> +
> +static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct mt6360_adc_data *mad = iio_priv(iio_dev);
> +
> +	if (mask == IIO_CHAN_INFO_PROCESSED)
> +		return mt6360_adc_read_processed(mad, chan->channel, val);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info mt6360_adc_iio_info = {
> +	.read_raw = mt6360_adc_read_raw,
> +};
> +
> +#define MT6360_ADC_CHAN(_idx, _type) {				\
> +	.type = _type,						\
> +	.channel = MT6360_CHAN_##_idx,				\
> +	.scan_index = MT6360_CHAN_##_idx,			\
> +	.extend_name = #_idx,					\
> +	.datasheet_name = #_idx,				\
> +	.scan_type =  {						\
> +		.sign = 's',					\
> +		.realbits = 32,					\
> +		.storagebits = 32,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> +	.indexed = 1,						\
> +}
> +
> +static const struct iio_chan_spec mt6360_adc_channels[] = {
> +	MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
> +	MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
> +	MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
> +	MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
> +	MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
> +	IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
> +};
> +
> +static irqreturn_t mt6360_pmu_adc_donei_handler(int irq, void *data)
> +{
> +	struct mt6360_adc_data *mad = iio_priv(data);
> +
> +	complete(&mad->adc_complete);
> +	return IRQ_HANDLED;
> +}
> +
...

> +
> +static int mt6360_adc_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_adc_data *mad;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	mad = iio_priv(indio_dev);
> +	mad->dev = &pdev->dev;
> +	init_completion(&mad->adc_complete);
> +	mutex_init(&mad->adc_lock);
> +
> +	mad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mad->regmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = mt6360_adc_reset(mad);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to reset adc\n");
> +		return ret;
> +	}
> +
> +	mad->irq = platform_get_irq_byname(pdev, "adc_donei");
> +	if (mad->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get adc_done irq\n");
> +		return mad->irq;
> +	}
> +
> +	irq_set_status_flags(mad->irq, IRQ_NOAUTOEN);

As we are going to have a v5 anyway to clean up that endian warning,
please could you add a comment to explain the need for IRQ_NOAUTOEN?

> +	ret = devm_request_threaded_irq(&pdev->dev, mad->irq, NULL, mt6360_pmu_adc_donei_handler, 0,
> +					"adc_donei", indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register adc_done irq\n");
> +		return ret;
> +	}
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &mt6360_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mt6360_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mt6360_adc_channels);
> +
> +	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, NULL,
> +					      mt6360_adc_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate iio trigger buffer\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register iio device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
...
