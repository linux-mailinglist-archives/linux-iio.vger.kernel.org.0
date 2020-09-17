Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4026E2FD
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIQRyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIQRxh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 13:53:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E1C20872;
        Thu, 17 Sep 2020 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600365213;
        bh=kxNSGxocAWFtrHwt6nTRFxbVUNXNxTJl6ykcOTlkCxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E4OOw8Fh+61V0j430fmJGQKQoetoa6d8f10c2p5x2haXUkcplqtxXoquf2YwmqvIz
         hMeVwzXFAL1OVabFF8suZnksRd5WmGvvz8AZMCa0Br6TShOaOuBTFmUYnH/cgZa8xm
         085doP2ow8U4TPduM9BQdzcYd3nDCkqs5OAV+qYU=
Date:   Thu, 17 Sep 2020 18:53:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v4 3/3] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20200917185327.761f7e5a@archlinux>
In-Reply-To: <1600191369-28040-4-git-send-email-gene.chen.richtek@gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600191369-28040-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 01:36:09 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add MT6360 ADC driver include Charger Current, Voltage, and
> Temperature.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
Comments inline.

> ---
>  drivers/iio/adc/Kconfig      |  11 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mt6360-adc.c | 357 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 369 insertions(+)
>  create mode 100644 drivers/iio/adc/mt6360-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 66d9cc0..8d36b66 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -703,6 +703,17 @@ config MCP3911
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp3911.
>  
> +config MEDIATEK_MT6360_ADC
> +	tristate "Mediatek MT6360 ADC driver"
> +	depends on MFD_MT6360
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to enable MT6360 ADC support.
> +	  Integrated for System Monitoring includes
> +	  is used in smartphones and tablets and supports a 11 channel
> +	  general purpose ADC.
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
> index 0000000..b256d0a
> --- /dev/null
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define MT6360_REG_PMUCHGCTRL3	0x313
> +#define MT6360_REG_PMUADCCFG	0x356
> +#define MT6360_REG_PMUADCIDLET	0x358
> +#define MT6360_REG_PMUADCRPT1	0x35A
> +
> +/* PMUCHGCTRL3 0x313 */
> +#define MT6360_AICR_MASK	GENMASK(7, 2)
> +#define MT6360_AICR_SHFT	2
> +#define MT6360_AICR_400MA	0x6
> +/* PMUADCCFG 0x356 */
> +#define MT6360_ADCEN_MASK	0x8000
> +/* PMUADCRPT1 0x35A */
> +#define MT6360_PREFERCH_MASK	GENMASK(7, 4)
> +#define MT6360_PREFERCH_SHFT	4
> +#define MT6360_RPTCH_MASK	GENMASK(3, 0)
> +#define MT6360_NO_PREFER	15
> +
> +/* Time in ms */
> +#define ADC_WAIT_TIME_MS	25
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
> +	MT6360_CHAN_MAX
> +};
> +
> +struct mt6360_adc_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex adc_lock;

Please add a comment to document what the scope of the lock is.

> +	ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> +};
> +
> +static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int *val)
> +{
> +	__be16 adc_enable;
> +	u8 rpt[3];
> +	ktime_t start_t, predict_end_t;
> +	unsigned int pre_wait_time;
> +	int ret;
> +
> +	mutex_lock(&mad->adc_lock);
> +
> +	/* Select the preferred ADC channel */
> +	ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> +				 channel << MT6360_PREFERCH_SHFT);
> +	if (ret)
> +		goto out_adc_lock;
> +
> +	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK | BIT(channel));
> +	ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable,

Shouldn't be any need to cast a pointer explicitly to void *

> +			       sizeof(__be16));

sizeof(adc_enable) preferred.

> +	if (ret)
> +		goto out_adc_lock;
> +
> +	start_t = ktime_get();
> +	predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 2 * ADC_WAIT_TIME_MS);
> +
> +	if (ktime_after(start_t, predict_end_t))
> +		pre_wait_time = ADC_WAIT_TIME_MS;
> +	else
> +		pre_wait_time = 3 * ADC_WAIT_TIME_MS;
> +
> +	msleep(pre_wait_time);
> +
> +	while (true) {
> +		ret = regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
> +		if (ret)
> +			goto out_adc_conv;
> +
> +		/*
> +		 * There are two functions, ZCV and TypeC OTP, running ADC VBAT and TS in
> +		 * background, and ADC samples are taken on a fixed frequency no matter read the
> +		 * previous one or not.
> +		 * To avoid conflict, We set minimum time threshold after enable ADC and
> +		 * check report channel is the same.
> +		 * The worst case is run the same ADC twice and background function is also running,
> +		 * ADC conversion sequence is desire channel before start ADC, background ADC,
> +		 * desire channel after start ADC.
> +		 * So the minimum correct data is three times of typical conversion time.
> +		 */
> +		if ((rpt[0] & MT6360_RPTCH_MASK) == channel)
> +			break;
> +
> +		msleep(ADC_WAIT_TIME_MS);
> +	}
> +
> +	/* rpt[1]: ADC_HI_BYTE, rpt[2]: ADC_LOW_BYTE */
> +	*val = be16_to_cpup((__be16 *)(rpt + 1));

To be entirely safe, probably need that to be an unaligned read?

> +	ret = IIO_VAL_INT;
> +
> +out_adc_conv:
> +	/* Only keep ADC enable */
> +	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
> +	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(__be16));

sizeof(adc_enable)

> +	mad->last_off_timestamps[channel] = ktime_get();
> +	/* Config prefer channel to NO_PREFER */
> +	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> +			   MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
> +out_adc_lock:
> +	mutex_unlock(&mad->adc_lock);
> +
> +	return ret;
> +}
> +
> +static int mt6360_adc_read_scale(struct mt6360_adc_data *mad, int channel, int *val, int *val2)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	switch (channel) {
> +	case MT6360_CHAN_USBID:
> +		fallthrough;

I don't think we need fallthrough for cases
with nothing in them.

> +	case MT6360_CHAN_VSYS:
> +		fallthrough;
> +	case MT6360_CHAN_VBAT:
> +		fallthrough;
> +	case MT6360_CHAN_CHG_VDDP:
> +		fallthrough;
> +	case MT6360_CHAN_VREF_TS:
> +		fallthrough;
> +	case MT6360_CHAN_TS:
> +		*val = 1250;
> +		return IIO_VAL_INT;
> +	case MT6360_CHAN_VBUSDIV5:
> +		*val = 6250;
> +		return IIO_VAL_INT;
> +	case MT6360_CHAN_VBUSDIV2:
> +		fallthrough;
> +	case MT6360_CHAN_IBUS:
> +		fallthrough;
> +	case MT6360_CHAN_IBAT:
> +		*val = 2500;
> +
> +		if (channel == MT6360_CHAN_IBUS) {
> +			/* IBUS will be affected by input current limit for the different Ron */
> +			/* Check whether the config is <400mA or not */
> +			ret = regmap_read(mad->regmap, MT6360_REG_PMUCHGCTRL3, &regval);
> +			if (ret)
> +				return ret;
> +
> +			regval = (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
> +			if (regval < MT6360_AICR_400MA)
> +				*val = 1900;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case MT6360_CHAN_TEMP_JC:
> +		*val = 105;
> +		*val2 = 100;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mt6360_adc_read_offset(struct mt6360_adc_data *mad, int channel, int *val)
> +{
> +	*val = (channel == MT6360_CHAN_TEMP_JC) ? -80 : 0;
> +	return IIO_VAL_INT;
> +
> +}
> +
> +static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct mt6360_adc_data *mad = iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return mt6360_adc_read_channel(mad, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		return mt6360_adc_read_scale(mad, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		return mt6360_adc_read_offset(mad, chan->channel, val);
> +	}
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
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\

Docs in patch 1 need to reflect this change. Currently they have
processed channels.

> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),	\
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
> +static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mt6360_adc_data *mad = iio_priv(indio_dev);
> +	struct {
> +		u16 values[MT6360_CHAN_MAX];

There is a hole in here I think? (MT6360_CHAN_MAX is 11?) 
If so we need to explicitly memset the structure to avoid any
risk of kernel data leakage to userspace.

> +		int64_t timestamp;
> +	} data;

I guess we know this is on a platform with 64bit alignment for int64_t's
(unlike x86_64 for example)

> +	int i = 0, bit, val, ret;
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		ret = mt6360_adc_read_channel(mad, bit, &val);
> +		if (ret < 0) {
> +			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val\n", bit);
> +			goto out;
> +		}
> +
> +		data.values[i++] = val;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static inline int mt6360_adc_reset(struct mt6360_adc_data *info)
> +{
> +	__be16 adc_enable;
> +	ktime_t all_off_time;
> +	int i, ret;
> +
> +	/* Clear ADC idle wait time to 0 */
> +	ret = regmap_write(info->regmap, MT6360_REG_PMUADCIDLET, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Only keep ADC enable, but keep all channels off */
> +	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
> +	ret = regmap_raw_write(info->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable,
> +			       sizeof(__be16));
> +	if (ret)
> +		return ret;
> +
> +	/* Reset all channel off time to the current one */
> +	all_off_time = ktime_get();
> +	for (i = 0; i < MT6360_CHAN_MAX; i++)
> +		info->last_off_timestamps[i] = all_off_time;
> +
> +	return 0;
> +}
> +
> +static int mt6360_adc_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_adc_data *mad;
> +	struct regmap *regmap;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	mad = iio_priv(indio_dev);
> +	mad->dev = &pdev->dev;
> +	mad->regmap = regmap;
> +	mutex_init(&mad->adc_lock);
> +
> +	ret = mt6360_adc_reset(mad);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to reset adc\n");
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
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
> +	{ .compatible = "mediatek,mt6360-adc", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_adc_of_id);
> +
> +static struct platform_driver mt6360_adc_driver = {
> +	.driver = {
> +		.name = "mt6360-adc",
> +		.of_match_table = mt6360_adc_of_id,
> +	},
> +	.probe = mt6360_adc_probe,
> +};
> +module_platform_driver(mt6360_adc_driver);
> +
> +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> +MODULE_DESCRIPTION("MT6360 ADC Driver");
> +MODULE_LICENSE("GPL v2");

