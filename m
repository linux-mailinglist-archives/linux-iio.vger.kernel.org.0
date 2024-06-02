Return-Path: <linux-iio+bounces-5601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F98D74B8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1712822B2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5752E3E9;
	Sun,  2 Jun 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Y8XVga"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C62570;
	Sun,  2 Jun 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717323118; cv=none; b=uD5kiJeBblEwah7ifFfeUc1WUDRSLQBFuX8k7nc+0MxYEPN1HwBAazvl44iK+zWBnKiffNwirZhlxMXe5iQB1NnNsFDXLlgoR/xZJlzNhaSF5M4omPxIi0eOxOn9W9ItU7oNZvOf4dV3zaTGL4DPnk5pfU4lLYSNeJlDrqF2boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717323118; c=relaxed/simple;
	bh=3C7h2gGaFwe/lVnaZ1oOKP+loUwkQ1i5bmocw8U6KR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0B42gJn+04T2lNAzz9PlrIb3GNC5UHt3CflofbqXe8Z4MwIIDIsvbI9/RJFkrLKjFDYNX/flRa+cS6Jao3nCQkMBccMUJCZGkmC3gZr48HNBQToaN78uGmmzDjhQmkvjbTLLc84J+6nLrttEwa6tA1G68uad6DHLp3jAhOkPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Y8XVga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E38C2BBFC;
	Sun,  2 Jun 2024 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717323117;
	bh=3C7h2gGaFwe/lVnaZ1oOKP+loUwkQ1i5bmocw8U6KR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k7Y8XVga2N1e+qxSmRn0mJ6rc+yQU9KpxnoGFrRMFQOfwJKtAbHTuZqTpLTVISkGh
	 Jd/o6KGTanomCgomYtQQdUgNjxMcieir4fevBaEEZfC+J9IUAob7eX3QhkP0iTRZdT
	 3CehY8wgphgp8idLu1rTcwvrnkbJA/iFc17pkbqpnZuqaxdV3erzjV6nVJbUuxZild
	 v4bvu7eLChn8xncNQi+x51BZqAcxSWHEM02Ik1FyCkwpnOlM5iZjL4zxm32TDTWEgB
	 1a0FDEp2A7sJDpnKCkKjcEK2YLa7BZScrtMI31CRh0rci5O4QNoEuOoxH4ZOAWnzUH
	 wKG40uKVFbCQw==
Date: Sun, 2 Jun 2024 11:11:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
Message-ID: <20240602111141.0058f39e@jic23-huawei>
In-Reply-To: <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
	<20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 11:34:08 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Add a driver to support reading the Auxiliary ADC IP found in the
> MediaTek MT6357, MT6358 and MT6359 Power Management ICs.
> 
> This driver provides multiple ADC channels for system monitoring,
> such as battery voltage, PMIC temperature, PMIC-internal voltage
> regulators temperature, and others.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I'll leave you to answer the 'why a new driver' in response to Andy's review
and just assume it makes sense whilst reviewing this.

What are IMP channels?

A few additional comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index edb32ce2af02..da7d4452b1e0 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MCP3564) += mcp3564.o
>  obj-$(CONFIG_MCP3911) += mcp3911.o
> +obj-$(CONFIG_MEDIATEK_MT6359_AUXADC) += mt6359-auxadc.o
>  obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> new file mode 100644
> index 000000000000..0481bd3f0144
> --- /dev/null
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MediaTek MT6359 PMIC AUXADC IIO driver
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Copyright (c) 2024 Collabora Ltd
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mfd/mt6397/core.h>
> +
> +#include <dt-bindings/iio/adc/mediatek,mt6357-auxadc.h>
> +#include <dt-bindings/iio/adc/mediatek,mt6358-auxadc.h>
> +#include <dt-bindings/iio/adc/mediatek,mt6359-auxadc.h>

So I 'guess' these headers are dt-bindings because you want
to consume them from other drivers?  That's fine, but if so please
add info on that to the DT binding patch.

> +/**
> + * struct mt6359_auxadc - Main driver structure
> + * @dev:           Device pointer
> + * @regmap:        Regmap from SoC PMIC Wrapper
> + * @pdata:         PMIC specific platform data
> + * @lock:          Mutex lock for AUXADC reads

Expand on this mutex comment.  What is it protecting?
I think it's about ensuring they are serialized to ensure configuration
is not changed during the read sequence.

> + * @timed_out:     Signals whether the last read timed out
> + */
> +struct mt6359_auxadc {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	const struct mtk_pmic_auxadc_pdata *pdata;
> +	struct mutex lock;
> +	bool timed_out;
> +};
> +

> +/**
> + * struct mtk_pmic_auxadc_pdata - PMIC specific platform data

I'm not sure this is conventionally what we think of as platform
data.  This is chip specific stuff. Platform data tends to be
more about how things are wired up etc.  A common term for this
stuff is chip_info.

> + * @channels:       IIO specification of ADC channels
> + * @num_channels:   Number of ADC channels
> + * @desc:           PMIC AUXADC channel data
> + * @regs:           List of PMIC specific registers
> + * @sec_unlock_key: Security unlock key for HK_TOP writes
> + * @imp_adc_num:    ADC channel for IMP readings
> + * @read_imp:       Callback to read PMIC IMP channels
> + */
> +struct mtk_pmic_auxadc_pdata {
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +	const struct mtk_pmic_auxadc_chan *desc;
> +	const u16 *regs;
> +	u16 sec_unlock_key;
> +	u8 imp_adc_num;
> +	int (*read_imp)(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat);
> +};
> +

> +
> +static const struct mtk_pmic_auxadc_chan mt6359_auxadc_ch_desc[] = {
> +	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 7, 2),
> +	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 5, 2),
> +	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
> +	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
> +	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, 8, 3, 2),
> +	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
> +	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
> +	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
> +	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 5, 2),
> +	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, 8, 1, 1),
> +	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, 8, 1, 1),
> +	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, 8, 1, 1),
> +
> +	/* IMP channels */
What are these? Expand IMP perhaps!

> +	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
> +	MTK_PMIC_ADC_CHAN(IBAT, 0, 0, 128, 7, 2),
> +};


> +static int mt6359_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
> +{
> +	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
> +	struct regmap *regmap = adc_dev->regmap;
> +	int val_v, val_i, ret;
> +	u32 val;
> +
> +	/* Start conversion */
> +	regmap_write(regmap, pdata->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
> +	ret = regmap_read_poll_timeout(regmap, pdata->regs[PMIC_AUXADC_IMP1],
> +				       val, !!(val & MT6359_IMP1_IRQ_RDY),

The condition is just as true or false without the !! so drop those.

> +				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
> +
> +	/* Stop conversion regardless of the result */
> +	regmap_write(regmap, pdata->regs[PMIC_AUXADC_IMP0], 0);
> +	if (ret)
> +		return ret;
> +
> +	/* If it succeeded, wait for the registers to be populated */
> +	usleep_range(IMP_STOP_DELAY_US, IMP_STOP_DELAY_US + 50);
> +
> +	ret = regmap_read(regmap, pdata->regs[PMIC_AUXADC_IMP3], &val_v);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, pdata->regs[PMIC_FGADC_R_CON0], &val_i);
> +	if (ret)
> +		return ret;

Why read them both if only one is wanted?  Do you need to read the data
for some reason - i.e. to allow for fresh reads or clear some status bit
or similar?  If so add a comment.  Otherwise easy to do

	if (vbat) {
		int val_v;
		ret = regmap_read(regmap, pdata->regs[PMIC_AUXADC_IMP3], &val_v);
		if (ret)
			return ret;
		*vbat = val_v;
	}
etc


> +
> +	*vbat = val_v;
> +	*ibat = val_i;
> +
> +	return 0;
> +}
> +
> +static const struct mtk_pmic_auxadc_pdata mt6357_pdata = {
> +	.channels = mt6357_auxadc_channels,
> +	.num_channels = ARRAY_SIZE(mt6357_auxadc_channels),
> +	.desc = mt6357_auxadc_ch_desc,
> +	.regs = mt6357_auxadc_regs,
> +	.imp_adc_num = MT6357_IMP_ADC_NUM,
> +	.read_imp = mt6358_read_imp,
> +};
> +
> +static const struct mtk_pmic_auxadc_pdata mt6358_pdata = {
> +	.channels = mt6358_auxadc_channels,
> +	.num_channels = ARRAY_SIZE(mt6358_auxadc_channels),
> +	.desc = mt6358_auxadc_ch_desc,
> +	.regs = mt6358_auxadc_regs,
> +	.imp_adc_num = MT6358_IMP_ADC_NUM,
> +	.read_imp = mt6358_read_imp,
> +};
> +
> +static const struct mtk_pmic_auxadc_pdata mt6359_pdata = {
> +	.channels = mt6359_auxadc_channels,
> +	.num_channels = ARRAY_SIZE(mt6359_auxadc_channels),
> +	.desc = mt6359_auxadc_ch_desc,
> +	.regs = mt6359_auxadc_regs,
> +	.sec_unlock_key = 0x6359,
> +	.read_imp = mt6359_read_imp,
> +};
>

> +
> +static int mt6359_auxadc_read_label(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan, char *label)
> +{
> +	return sysfs_emit(label, "%s\n", chan->datasheet_name);
> +}
> +
> +static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	struct mt6359_auxadc *adc_dev = iio_priv(indio_dev);
> +	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
> +	const struct mtk_pmic_auxadc_chan *desc = &pdata->desc[chan->scan_index];
> +	int ret;
> +
> +	if (mask == IIO_CHAN_INFO_SCALE) {
> +		*val = desc->r_numerator * AUXADC_VOLT_FULL;
> +
> +		if (desc->r_denominator > 1) {
> +			*val2 = desc->r_denominator;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	mutex_lock(&adc_dev->lock);
> +
> +	switch (chan->scan_index) {
> +	case PMIC_AUXADC_CHAN_IBAT:
> +		ret = adc_dev->pdata->read_imp(adc_dev, val2, val);

This is very odd. Why reverse the parameters between the IBAT and VBAT
channels?  I suspect you want to throw away a parameter. That's fine but
don't use val2 for it. Either make that function handle NULL pointers
or add a local int temp or similar for this purpose.

> +		break;
> +	case PMIC_AUXADC_CHAN_VBAT:
> +		ret = adc_dev->pdata->read_imp(adc_dev, val, val2);
> +		break;
> +	default:
> +		ret = mt6359_auxadc_read_adc(adc_dev, chan, val);
> +		break;
> +	}
> +
> +	mutex_unlock(&adc_dev->lock);
> +
> +	if (ret) {
> +		/*
> +		 * If we get more than one timeout, it's possible that the
> +		 * AUXADC is stuck: perform a full reset to recover it.
> +		 */
> +		if (ret == -ETIMEDOUT) {
> +			if (adc_dev->timed_out) {
> +				dev_warn(adc_dev->dev, "Resetting stuck ADC!\r\n");
> +				mt6359_auxadc_reset(adc_dev);
> +			}
> +			adc_dev->timed_out = true;
> +		}
> +		return ret;
> +	}
> +	adc_dev->timed_out = false;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info mt6359_auxadc_info = {
> +	.read_label = mt6359_auxadc_read_label,
> +	.read_raw = mt6359_auxadc_read_raw,
> +};
> +
> +static int mt6359_auxadc_probe(struct platform_device *pdev)
> +{
> +	struct device *mt6397_mfd_dev = pdev->dev.parent;
> +	struct mt6359_auxadc *adc_dev;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	/* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
> +	regmap = dev_get_regmap(mt6397_mfd_dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get regmap\n");
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc_dev = iio_priv(indio_dev);
> +	adc_dev->regmap = regmap;
> +	adc_dev->dev = &pdev->dev;
> +
> +	adc_dev->pdata = device_get_match_data(&pdev->dev);
> +	if (!adc_dev->pdata)
> +		return -EINVAL;
> +
> +	mutex_init(&adc_dev->lock);
> +
> +	mt6359_auxadc_reset(adc_dev);
> +
> +	indio_dev->dev.parent = &pdev->dev;
No need to set that, the IIO core does it for you in
devm_iio_device_alloc()
> +	indio_dev->name = dev_name(&pdev->dev);

This tends to be fragile at best.  The name should be the part number, best
way to reliably get that is either to query a whoami type register if there
is one or put it in your pdata.

> +	indio_dev->info = &mt6359_auxadc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adc_dev->pdata->channels;
> +	indio_dev->num_channels = adc_dev->pdata->num_channels;
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register iio device\n");
> +
> +	return 0;
> +}

