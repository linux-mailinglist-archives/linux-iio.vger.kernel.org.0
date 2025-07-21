Return-Path: <linux-iio+bounces-21841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E481B0CACA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 21:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F24C5458BE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2E2222B0;
	Mon, 21 Jul 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIu4frZp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01E1DF751
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124535; cv=none; b=i49UFRf67gWq3ci+IRnNGFNKRexFNRpIIJOuZPXozuhQsW7Nwi8psOvvL0yroFaMj2fbc1pPSfnvUs30GsUN8CGajH+FHZIPfhCvJjjIVp2/coWRsLi42OV7xkrJG8sY7z7QJ4m0B/Pl7HC3fIdMTaH2VeHLpeh7BYuPmJnXEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124535; c=relaxed/simple;
	bh=SnrbMf+nv9odlxyOo5Qn1Z73zu0gHWttkgprTbYfBsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M67lWOiA3tkNVXj83WCKW89qGnyVgLcQZTJiE3jZHunWznPll+BbRq18jgaViZ3HbXJMNJUJKhm4YfaEMwhlq5X8kmfItl5rvI4HRRknW07gWqe0lyY+VmtxG6omp0PSnMPaeRauKTwlPJvDzopLBWB0LeQe5FzYrFfOYN3l9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIu4frZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265DDC4CEED;
	Mon, 21 Jul 2025 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753124533;
	bh=SnrbMf+nv9odlxyOo5Qn1Z73zu0gHWttkgprTbYfBsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tIu4frZpLcI07djydsRM2v5iux6eI9fwcNMQAT4FKabvIr2fIXgAoRLSXFOrqv6Sn
	 wJEdoHJ6U1lDsbGjCOApIoGMI1nOM4GPMoWJIB3BNGMjwBFpSC5XhPWDw+TPgVzLhI
	 CoeTFD4JxlVAx+thQZBA5oOAmmWcxtPVABTOQWOIY4b2FwIY16+X/xBKzo5r3M4+CV
	 lG9u51zGDuAnSfU8w2oXLcEvOwd33qNWSi0/4M/uuCBsFTCI2woefco+h6T1CAh2m9
	 oiw03iU81ncPaLMmsRUwGpITB7GgQbNC42cLGv9fZ293ZFMJBLJMhQyUhkN+jZ5/25
	 dU3AIihlvoG0w==
Message-ID: <47bc1555-0855-4dca-a189-ce84e14d9e41@kernel.org>
Date: Mon, 21 Jul 2025 21:02:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-3-hansg@kernel.org>
 <7e3cc17a-1ceb-40ac-bc4c-31487cd0deea@baylibre.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <7e3cc17a-1ceb-40ac-bc4c-31487cd0deea@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for the review.

On 21-Jul-25 8:43 PM, David Lechner wrote:
> On 7/21/25 10:06 AM, Hans de Goede wrote:
>> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
>> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
>> The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver.
>>
>> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
>> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
>>
>> Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
>> binding to the "chtdc_ti_adc" MFD cell of the MFD driver.
>>
>> The "cht" in the cell name comes from Cherry Trail, but it turns out that
>> just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
>> Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
>> not include the cht part in its name.
>>
>> This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
>> from the Acer A1-840 Android kernel source-code archive named:
>> "App. Guide_Acer_20151221_A_A.zip"
>> which is distributed by Acer from the Acer A1-840 support page:
>> https://www.acer.com/us-en/support/product-support/A1-840/downloads
>>
>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>> ---
>> Changes in v2:
>> - Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
>> - Add IIO_CHAN_INFO_PROCESSED which applies calibration and
>>   scaling for the VBat channel
>> - Address some other small review remarks
>> ---
>>  drivers/iio/adc/Kconfig           |  11 +
>>  drivers/iio/adc/Makefile          |   1 +
>>  drivers/iio/adc/intel_dc_ti_adc.c | 348 ++++++++++++++++++++++++++++++
>>  3 files changed, 360 insertions(+)
>>  create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index ea3ba1397392..51a5fc6efbe1 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -723,6 +723,17 @@ config INGENIC_ADC
>>  	  This driver can also be built as a module. If so, the module will be
>>  	  called ingenic_adc.
>>  
>> +config INTEL_DC_TI_ADC
>> +	tristate "Intel Bay / Cherry Trail Dollar Cove TI ADC driver"
>> +	depends on INTEL_SOC_PMIC_CHTDC_TI
>> +	help
>> +	  Say yes here to have support for the Dollar Cove TI PMIC ADC device.
>> +	  Depending on platform configuration, this general purpose ADC can be
>> +	  used for sensors such as battery voltage and thermal resistors.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called intel_dc_ti_adc.
>> +
>>  config INTEL_MRFLD_ADC
>>  	tristate "Intel Merrifield Basin Cove ADC driver"
>>  	depends on INTEL_SOC_PMIC_MRFLD
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 09ae6edb2650..da99ba88b4e1 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -67,6 +67,7 @@ obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>>  obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
>>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>>  obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
>> +obj-$(CONFIG_INTEL_DC_TI_ADC) += intel_dc_ti_adc.o
>>  obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
>>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>> diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
>> new file mode 100644
>> index 000000000000..6f27c45679cc
>> --- /dev/null
>> +++ b/drivers/iio/adc/intel_dc_ti_adc.c
>> @@ -0,0 +1,348 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Intel Dollar Cove TI PMIC GPADC Driver
>> + *
>> + * Copyright (C) 2014 Intel Corporation (Ramakrishna Pallala <ramakrishna.pallala@intel.com>)
>> + * Copyright (C) 2024 - 2025 Hans de Goede <hansg@kernel.org>
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/intel_soc_pmic.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/wait.h>
>> +
>> +#include <linux/iio/driver.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/machine.h>
>> +
>> +#define DC_TI_ADC_CNTL_REG			0x50
>> +#define DC_TI_ADC_START				BIT(0)
>> +#define DC_TI_ADC_CH_SEL			GENMASK(2, 1)
>> +#define DC_TI_ADC_EN				BIT(5)
>> +#define DC_TI_ADC_EN_EXT_BPTH_BIAS		BIT(6)
>> +
>> +#define DC_TI_VBAT_ZSE_GE_REG			0x53
>> +#define DC_TI_VBAT_GE				GENMASK(3, 0)
>> +#define DC_TI_VBAT_ZSE				GENMASK(7, 4)
>> +
>> +/* VBAT GE gain correction is in 0.0015 increments, ZSE is in 1.0 increments */
>> +#define DC_TI_VBAT_GE_STEP			15
>> +#define DC_TI_VBAT_GE_DIV			10000
>> +
>> +#define DC_TI_ADC_CH0_DATAH_REG			0x54
>> +#define DC_TI_ADC_CH0_DATAL_REG			0x55
>> +#define DC_TI_ADC_CH1_DATAH_REG			0x56
>> +#define DC_TI_ADC_CH1_DATAL_REG			0x57
>> +#define DC_TI_ADC_CH2_DATAH_REG			0x58
>> +#define DC_TI_ADC_CH2_DATAL_REG			0x59
>> +#define DC_TI_ADC_CH3_DATAH_REG			0x5A
>> +#define DC_TI_ADC_CH3_DATAL_REG			0x5B
> 
> Could be less verbose with just:
> 
> #define DC_TI_ADC_CHX_DATAH_REG(x)			(0x54 + 2 * (x))

Ack, will fix.

>> +
>> +enum dc_ti_adc_id {
>> +	DC_TI_ADC_VBAT,
>> +	DC_TI_ADC_PMICTEMP,
>> +	DC_TI_ADC_BATTEMP,
>> +	DC_TI_ADC_SYSTEMP0,
>> +};
>> +
>> +struct dc_ti_adc_info {
>> +	struct mutex lock; /* Protects against concurrent accesses to the ADC */
>> +	wait_queue_head_t wait;
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	int vbat_zse;
>> +	int vbat_ge;
>> +	bool conversion_done;
>> +};
>> +
>> +static const struct iio_chan_spec dc_ti_adc_channels[] = {
>> +	{
>> +		.indexed = 1,
>> +		.type = IIO_VOLTAGE,
>> +		.channel = DC_TI_ADC_VBAT,
>> +		.address = DC_TI_ADC_CH0_DATAH_REG,
>> +		.datasheet_name = "CH0",
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE) |
>> +				      BIT(IIO_CHAN_INFO_PROCESSED),
>> +	}, {
>> +		.indexed = 1,
>> +		.type = IIO_TEMP,
>> +		.channel = DC_TI_ADC_PMICTEMP,
>> +		.address = DC_TI_ADC_CH1_DATAH_REG,
>> +		.datasheet_name = "CH1",
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> 
> Is the raw value already in millidegrees C or do we need
> IIO_CHAN_INFO_SCALE here?

The scale is unknown (I guess this depends on the thermistor
connected), which is why there is no IIO_CHAN_INFO_SCALE
here.

Note I have no datasheet, this is all based on the Android
kernel sourcecode dump mentioned in the commit message.

>> +	}, {

...

>> +static int dc_ti_adc_sample(struct dc_ti_adc_info *info,
>> +			    struct iio_chan_spec const *chan, int *val)
>> +{
>> +	int ret, ch = chan->channel;
>> +	unsigned int lsb, msb;
>> +
>> +	info->conversion_done = false;
>> +
>> +	/*
>> +	 * As per TI (PMIC Vendor), the ADC enable and ADC start commands should
>> +	 * not be sent together. Hence send the commands separately
>> +	 */
>> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
>> +				 DC_TI_ADC_EN, DC_TI_ADC_EN);
> 
> Can just be simplified to regmap_set_bits(). (applies several other
> places as well)

Ack, will fix for the next version.

>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
>> +				 DC_TI_ADC_CH_SEL, FIELD_PREP(DC_TI_ADC_CH_SEL, ch));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * As per PMIC Vendor, a minimum of 50 micro seconds delay is required
>> +	 * between ADC Enable and ADC START commands. This is also recommended
>> +	 * by Intel Hardware team after the timing analysis of GPADC signals.
>> +	 * Since the I2C Write transaction to set the channel number also
>> +	 * imparts 25 micro seconds of delay, so we need to wait for another
>> +	 * 25 micro seconds before issuing ADC START command.
>> +	 */
>> +	fsleep(25);
>> +
>> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
>> +				 DC_TI_ADC_START, DC_TI_ADC_START);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* TI (PMIC Vendor) recommends 5 sec timeout for conversion */
>> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
> 
> Does conversion_done need to be volatile since it is set in an interrupt
> handler?

Interesting question, I would expect the wait_event_timeout()
macro to deal with this, and it internally uses:

#define ___wait_cond_timeout(condition)                                         \
({                                                                              \
        bool __cond = (condition);                                              \
        if (__cond && !__ret)                                                   \
                __ret = 1;                                                      \
        __cond || !__ret;                                                       \
})

Where I guess the copy to the bool __conf causes a re-read every
time this is checked?  At least I'm reasonably sure that the kernel
is full of check for some flag wait conditions like this without all
of them being volatile.

>> +	if (ret == 0) {
>> +		dev_err(info->dev, "Error sample timeout\n");
> 
> Error code is being passed to the caller, so don't need to spam
> the kernel log with this.

Ok, I'll drop the error log.

>> +		ret = -ETIMEDOUT;
>> +		goto disable_adc;
>> +	}
>> +
>> +	/* Reading multiple registers at once is not supported */
>> +	ret = regmap_read(info->regmap, chan->address, &msb);
>> +	if (ret)
>> +		goto disable_adc;
>> +
>> +	ret = regmap_read(info->regmap, chan->address + 1, &lsb);
>> +	if (ret)
>> +		goto disable_adc;
>> +
>> +	*val = ((msb << 8) | lsb) & 0x3ff;
>> +
>> +disable_adc:
>> +	regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
>> +			   DC_TI_ADC_START | DC_TI_ADC_EN, 0);
> 
> Can be simplified to regmap_clear_bits(). (same applies other
> places too)

Ack.

>> +	return ret;
>> +}

...

>> +static int dc_ti_adc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
>> +	struct dc_ti_adc_info *info;
>> +	struct iio_dev *indio_dev;
>> +	unsigned int reg_val;
>> +	int irq, ret, val;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	info = iio_priv(indio_dev);
>> +
>> +	ret = devm_mutex_init(dev, &info->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	init_waitqueue_head(&info->wait);
>> +
>> +	info->dev = dev;
>> +	info->regmap = pmic->regmap;
>> +
>> +	indio_dev->name = "dc_ti_adc";
>> +	indio_dev->channels = dc_ti_adc_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(dc_ti_adc_channels);
>> +	indio_dev->info = &dc_ti_adc_iio_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	ret = regmap_read(info->regmap, DC_TI_VBAT_ZSE_GE_REG, &reg_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = FIELD_GET(DC_TI_VBAT_ZSE, reg_val);
>> +	if (val >= 8)
>> +		info->vbat_zse = val - 16;
>> +	else
>> +		info->vbat_zse = val;
> 
> Is this just sign extending?

I think so, let me double check before the next version.

> If so, could do it in one line:
> 
> 	val = sign_extend32(FIELD_GET(DC_TI_VBAT_ZSE, reg_val), 3);

Ack will do if this indeed is just sign extending.

>> +
>> +	val = FIELD_GET(DC_TI_VBAT_GE, reg_val);
>> +	if (val >= 8)
>> +		info->vbat_ge = val - 16;
>> +	else
>> +		info->vbat_ge = val;

and the same here then.


>> +
>> +	dev_dbg(dev, "vbat-zse %d vbat-ge %d\n", info->vbat_zse, info->vbat_ge);
>> +
>> +	ret = devm_iio_map_array_register(dev, indio_dev, dc_ti_adc_default_maps);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_adc_isr,
>> +					IRQF_ONESHOT, indio_dev->name, info);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}

...

Regards,

Hans



