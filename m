Return-Path: <linux-iio+bounces-21838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB94B0CAAA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 20:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E064E1BBE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FC2D836F;
	Mon, 21 Jul 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jLFYEnPk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789714689
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123393; cv=none; b=sIOc5XB82ZJ7Od0Z1yQiluufkk5ND+N4iZIw2Mayy9R8NhBJ2ipYuftAlh+u+84IerDq7+3NHuJEkVbzZSGf72AF80FSvGADVP0MUsNro9cSUhI+RTApgmeuhWBah5jVAj0Al0G8TXkF5QCXx1x27poxlhJl8bSttCBx1CSQiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123393; c=relaxed/simple;
	bh=oPcwJ1h6iEbfxhctlMtQSoePcoV3Q3/oQHafdW52WSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCdYmutnLnzZXahXqJziUEwnnJmD85l9deBaV5o++lCg4nQXDmefX+W6pCT6AWGvDtKEV8IpqKeIsdMj1gceDTsSSW+KQJOqdduh++fY6pizAUW6hyiNZxpMRzDFVD9ALjwzp9XqVYC4mnM7bjm+k/lg+KpOIO74sLoRyApHRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jLFYEnPk; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-615913ff67fso2901453eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753123389; x=1753728189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQUI4ciB5/nnB8y1HkLSws7EkI4t8Pu1dzM3KnXof/0=;
        b=jLFYEnPkNdt33013aqzYSrLlqnjNYCE5daahMrrELgPGmZk4CRTbFfj/9EaOmwMUMm
         QSwv8keABisdgluHaXLca3WKJZFJ5g8PvVhY2R+VpeuGwtn+DMA2lPslLV4wrrJFSNP4
         9DbJ7cYeh2WeziNDefz52gdzQPtlZ45MqInXqwgbhIIYU13bB2anGOqBnu3R670O0lou
         raLsVHqcLHmVPZpgSDChUOo0QxceOT1mPEmFLBSe3gdRgmisZgnNNEViMbecBWi4/1EV
         /0CIqPpQLB66DZu97GP1kfP1UQWJoRqIIgWmY5ccSEUlMSIsLj0ZjswF2eWHNj9DIVz1
         tYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123389; x=1753728189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQUI4ciB5/nnB8y1HkLSws7EkI4t8Pu1dzM3KnXof/0=;
        b=c0lO8A7feghBYrB3VbujImQ0jnqrp1sT3iPUWVPTM6T7bWSYBRRD6lCExo64AeSmAb
         Rr8TTaSYtynkD1Mrzlaf9FL51faN3M+BnadCk2fjGhy7zld8NYaTQeg/vJulbA9yKPh2
         JHtUK6jff98BrmoMUpVQ9ApxfbFjyxlMUGUWVcPsHcJ2O+HWZdiq4xQl649LoB6iEu2T
         1lSKSa7TlwiH9xyn4k8XrJ3SoXjzAJ6Vcz8LfRDNkEfyKgnnrenIWNzHcKG7U5JUefOX
         t4hO3fkggR1xQ5qTqBPx6upj5mFEncyVxOfCNtGJ4ZGwLkn4Ejt11r2Nk4DavjBqAeAt
         /fNg==
X-Forwarded-Encrypted: i=1; AJvYcCWu6QGvALoNihm1xhDOxjdM/3eI+iPy1SXa5sIRqKZ/owhJSWr7qK0B0kFKUdvtv+GkxB9Mv0WtPfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2uVDDBn+215gd97Y9ebSVVVYlJzT2yMPOsc8We524AvXFNPFz
	IoQyCGsqqV9bhLrhMSQUBK8keRFIqvEVVaw1lhJcv+RVPYeAAxfS7mJsrCmLL5pQCT8=
X-Gm-Gg: ASbGncuDVXizBuFx1hi8OMW2w7GJJjqucGuf6Z1saIsBnhPmfJ+kx07nyqLVo4C7SQ6
	egv6orMhaLUKlyIb9zXJq3ROk+TJQuQOryiW0ckW4XDW7NHpGYZSFY/JBmkHyQHOs6o9pUD2yhf
	XOLUN3LwF+kcnYp99Cx55CBmyY6uGOpevAfTtjXEJXBwdgl0Od5eckHJr2grd1BnzXlRWQKr+Fa
	A6XLHOe2trZ0CvebXvHmUv8fMhiXJo4uwoYySi1kTmUEc9eZeOcAGTFYfq2zvQ7BRc73X4pX/HF
	Pt9T4DJuR7nACPDzxdxEM1IDe4WjsrgRnp7Jvb5uK75H9sYGfsnRwYdYVs73Z21/7+5jg/QQDZE
	aVmvWpOLxlJoxTK2X0GfjJX/n6Ux5P3CXqql3Q+Ua5DREWWZ30LjtKZAMRkAZHkYFq3wwAtdK6Q
	I=
X-Google-Smtp-Source: AGHT+IH+kv4mvkBWtyl6Qic6W+mpkTZOIM8YxwnBePLV+S2WB77gyodzx7xlRGeBIApd3SqXSq2nvA==
X-Received: by 2002:a4a:ec4c:0:b0:613:bd07:54cc with SMTP id 006d021491bc7-615ee56c6f7mr536825eaf.0.1753123389313;
        Mon, 21 Jul 2025 11:43:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-615bcda2865sm1754308eaf.26.2025.07.21.11.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 11:43:08 -0700 (PDT)
Message-ID: <7e3cc17a-1ceb-40ac-bc4c-31487cd0deea@baylibre.com>
Date: Mon, 21 Jul 2025 13:43:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-3-hansg@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250721150614.51918-3-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 10:06 AM, Hans de Goede wrote:
> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
> The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver.
> 
> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
> 
> Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
> binding to the "chtdc_ti_adc" MFD cell of the MFD driver.
> 
> The "cht" in the cell name comes from Cherry Trail, but it turns out that
> just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
> Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
> not include the cht part in its name.
> 
> This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
> from the Acer A1-840 Android kernel source-code archive named:
> "App. Guide_Acer_20151221_A_A.zip"
> which is distributed by Acer from the Acer A1-840 support page:
> https://www.acer.com/us-en/support/product-support/A1-840/downloads
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
> Changes in v2:
> - Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
> - Add IIO_CHAN_INFO_PROCESSED which applies calibration and
>   scaling for the VBat channel
> - Address some other small review remarks
> ---
>  drivers/iio/adc/Kconfig           |  11 +
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/intel_dc_ti_adc.c | 348 ++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ea3ba1397392..51a5fc6efbe1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -723,6 +723,17 @@ config INGENIC_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ingenic_adc.
>  
> +config INTEL_DC_TI_ADC
> +	tristate "Intel Bay / Cherry Trail Dollar Cove TI ADC driver"
> +	depends on INTEL_SOC_PMIC_CHTDC_TI
> +	help
> +	  Say yes here to have support for the Dollar Cove TI PMIC ADC device.
> +	  Depending on platform configuration, this general purpose ADC can be
> +	  used for sensors such as battery voltage and thermal resistors.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called intel_dc_ti_adc.
> +
>  config INTEL_MRFLD_ADC
>  	tristate "Intel Merrifield Basin Cove ADC driver"
>  	depends on INTEL_SOC_PMIC_MRFLD
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 09ae6edb2650..da99ba88b4e1 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>  obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
> +obj-$(CONFIG_INTEL_DC_TI_ADC) += intel_dc_ti_adc.o
>  obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
> diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
> new file mode 100644
> index 000000000000..6f27c45679cc
> --- /dev/null
> +++ b/drivers/iio/adc/intel_dc_ti_adc.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel Dollar Cove TI PMIC GPADC Driver
> + *
> + * Copyright (C) 2014 Intel Corporation (Ramakrishna Pallala <ramakrishna.pallala@intel.com>)
> + * Copyright (C) 2024 - 2025 Hans de Goede <hansg@kernel.org>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/wait.h>
> +
> +#include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +
> +#define DC_TI_ADC_CNTL_REG			0x50
> +#define DC_TI_ADC_START				BIT(0)
> +#define DC_TI_ADC_CH_SEL			GENMASK(2, 1)
> +#define DC_TI_ADC_EN				BIT(5)
> +#define DC_TI_ADC_EN_EXT_BPTH_BIAS		BIT(6)
> +
> +#define DC_TI_VBAT_ZSE_GE_REG			0x53
> +#define DC_TI_VBAT_GE				GENMASK(3, 0)
> +#define DC_TI_VBAT_ZSE				GENMASK(7, 4)
> +
> +/* VBAT GE gain correction is in 0.0015 increments, ZSE is in 1.0 increments */
> +#define DC_TI_VBAT_GE_STEP			15
> +#define DC_TI_VBAT_GE_DIV			10000
> +
> +#define DC_TI_ADC_CH0_DATAH_REG			0x54
> +#define DC_TI_ADC_CH0_DATAL_REG			0x55
> +#define DC_TI_ADC_CH1_DATAH_REG			0x56
> +#define DC_TI_ADC_CH1_DATAL_REG			0x57
> +#define DC_TI_ADC_CH2_DATAH_REG			0x58
> +#define DC_TI_ADC_CH2_DATAL_REG			0x59
> +#define DC_TI_ADC_CH3_DATAH_REG			0x5A
> +#define DC_TI_ADC_CH3_DATAL_REG			0x5B

Could be less verbose with just:

#define DC_TI_ADC_CHX_DATAH_REG(x)			(0x54 + 2 * (x))

> +
> +enum dc_ti_adc_id {
> +	DC_TI_ADC_VBAT,
> +	DC_TI_ADC_PMICTEMP,
> +	DC_TI_ADC_BATTEMP,
> +	DC_TI_ADC_SYSTEMP0,
> +};
> +
> +struct dc_ti_adc_info {
> +	struct mutex lock; /* Protects against concurrent accesses to the ADC */
> +	wait_queue_head_t wait;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	int vbat_zse;
> +	int vbat_ge;
> +	bool conversion_done;
> +};
> +
> +static const struct iio_chan_spec dc_ti_adc_channels[] = {
> +	{
> +		.indexed = 1,
> +		.type = IIO_VOLTAGE,
> +		.channel = DC_TI_ADC_VBAT,
> +		.address = DC_TI_ADC_CH0_DATAH_REG,
> +		.datasheet_name = "CH0",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_PMICTEMP,
> +		.address = DC_TI_ADC_CH1_DATAH_REG,
> +		.datasheet_name = "CH1",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

Is the raw value already in millidegrees C or do we need
IIO_CHAN_INFO_SCALE here?

> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_BATTEMP,
> +		.address = DC_TI_ADC_CH2_DATAH_REG,
> +		.datasheet_name = "CH2",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_SYSTEMP0,
> +		.address = DC_TI_ADC_CH3_DATAH_REG,
> +		.datasheet_name = "CH3",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};
> +
> +static struct iio_map dc_ti_adc_default_maps[] = {
> +	IIO_MAP("CH0", "chtdc_ti_battery", "VBAT"),
> +	IIO_MAP("CH1", "chtdc_ti_battery", "PMICTEMP"),
> +	IIO_MAP("CH2", "chtdc_ti_battery", "BATTEMP"),
> +	IIO_MAP("CH3", "chtdc_ti_battery", "SYSTEMP0"),
> +	{ }
> +};
> +
> +static irqreturn_t dc_ti_adc_isr(int irq, void *data)
> +{
> +	struct dc_ti_adc_info *info = data;
> +
> +	info->conversion_done = true;
> +	wake_up(&info->wait);
> +	return IRQ_HANDLED;
> +}
> +
> +static int dc_ti_adc_scale(struct dc_ti_adc_info *info,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2)
> +{
> +	if (chan->channel != DC_TI_ADC_VBAT)
> +		return -EINVAL;
> +
> +	/* Vbat ADC scale is 4.6875 mV / unit */
> +	*val = 4;
> +	*val2 = 687500;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int dc_ti_adc_raw_to_processed(struct dc_ti_adc_info *info,
> +				      struct iio_chan_spec const *chan,
> +				      int raw, int *val, int *val2)
> +{
> +	if (chan->channel != DC_TI_ADC_VBAT)
> +		return -EINVAL;
> +
> +	/* Apply calibration */
> +	raw -= info->vbat_zse;
> +	raw = raw * (DC_TI_VBAT_GE_DIV - info->vbat_ge * DC_TI_VBAT_GE_STEP) /
> +	      DC_TI_VBAT_GE_DIV;
> +	/* Vbat ADC scale is 4.6875 mV / unit */
> +	raw *= 46875;
> +
> +	/* raw is now in 10000 units / mV, convert to milli + milli/1e6 */
> +	*val = raw / 10000;
> +	*val2 = (raw % 10000) * 100;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int dc_ti_adc_sample(struct dc_ti_adc_info *info,
> +			    struct iio_chan_spec const *chan, int *val)
> +{
> +	int ret, ch = chan->channel;
> +	unsigned int lsb, msb;
> +
> +	info->conversion_done = false;
> +
> +	/*
> +	 * As per TI (PMIC Vendor), the ADC enable and ADC start commands should
> +	 * not be sent together. Hence send the commands separately
> +	 */
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_EN, DC_TI_ADC_EN);

Can just be simplified to regmap_set_bits(). (applies several other
places as well)

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_CH_SEL, FIELD_PREP(DC_TI_ADC_CH_SEL, ch));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * As per PMIC Vendor, a minimum of 50 micro seconds delay is required
> +	 * between ADC Enable and ADC START commands. This is also recommended
> +	 * by Intel Hardware team after the timing analysis of GPADC signals.
> +	 * Since the I2C Write transaction to set the channel number also
> +	 * imparts 25 micro seconds of delay, so we need to wait for another
> +	 * 25 micro seconds before issuing ADC START command.
> +	 */
> +	fsleep(25);
> +
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_START, DC_TI_ADC_START);
> +	if (ret)
> +		return ret;
> +
> +	/* TI (PMIC Vendor) recommends 5 sec timeout for conversion */
> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);

Does conversion_done need to be volatile since it is set in an interrupt
handler?

> +	if (ret == 0) {
> +		dev_err(info->dev, "Error sample timeout\n");

Error code is being passed to the caller, so don't need to spam
the kernel log with this.

> +		ret = -ETIMEDOUT;
> +		goto disable_adc;
> +	}
> +
> +	/* Reading multiple registers at once is not supported */
> +	ret = regmap_read(info->regmap, chan->address, &msb);
> +	if (ret)
> +		goto disable_adc;
> +
> +	ret = regmap_read(info->regmap, chan->address + 1, &lsb);
> +	if (ret)
> +		goto disable_adc;
> +
> +	*val = ((msb << 8) | lsb) & 0x3ff;
> +
> +disable_adc:
> +	regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +			   DC_TI_ADC_START | DC_TI_ADC_EN, 0);

Can be simplified to regmap_clear_bits(). (same applies other
places too)

> +	return ret;
> +}
> +
> +static int dc_ti_adc_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct dc_ti_adc_info *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask == IIO_CHAN_INFO_SCALE)
> +		return dc_ti_adc_scale(info, chan, val, val2);
> +
> +	guard(mutex)(&info->lock);
> +
> +	/*
> +	 * If channel BPTHERM has been selected, first enable the BPTHERM BIAS
> +	 * which provides the VREFT Voltage reference to convert BPTHERM Input
> +	 * voltage to temperature.
> +	 * As per PMIC Vendor specifications, BPTHERM BIAS should be enabled
> +	 * 35 ms before ADC_EN command.
> +	 */
> +	if (chan->channel == DC_TI_ADC_BATTEMP) {
> +		ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +					 DC_TI_ADC_EN_EXT_BPTH_BIAS,
> +					 DC_TI_ADC_EN_EXT_BPTH_BIAS);
> +		if (ret)
> +			return ret;
> +		msleep(35);
> +	}
> +
> +	ret = dc_ti_adc_sample(info, chan, val);
> +
> +	if (chan->channel == DC_TI_ADC_BATTEMP)
> +		regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				   DC_TI_ADC_EN_EXT_BPTH_BIAS, 0);
> +
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		return dc_ti_adc_raw_to_processed(info, chan, *val, val, val2);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info dc_ti_adc_iio_info = {
> +	.read_raw = dc_ti_adc_read_raw,
> +};
> +
> +static int dc_ti_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
> +	struct dc_ti_adc_info *info;
> +	struct iio_dev *indio_dev;
> +	unsigned int reg_val;
> +	int irq, ret, val;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret)
> +		return ret;
> +
> +	init_waitqueue_head(&info->wait);
> +
> +	info->dev = dev;
> +	info->regmap = pmic->regmap;
> +
> +	indio_dev->name = "dc_ti_adc";
> +	indio_dev->channels = dc_ti_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(dc_ti_adc_channels);
> +	indio_dev->info = &dc_ti_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = regmap_read(info->regmap, DC_TI_VBAT_ZSE_GE_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_GET(DC_TI_VBAT_ZSE, reg_val);
> +	if (val >= 8)
> +		info->vbat_zse = val - 16;
> +	else
> +		info->vbat_zse = val;

Is this just sign extending? If so, could do it in one line:

	val = sign_extend32(FIELD_GET(DC_TI_VBAT_ZSE, reg_val), 3);

> +
> +	val = FIELD_GET(DC_TI_VBAT_GE, reg_val);
> +	if (val >= 8)
> +		info->vbat_ge = val - 16;
> +	else
> +		info->vbat_ge = val;
> +
> +	dev_dbg(dev, "vbat-zse %d vbat-ge %d\n", info->vbat_zse, info->vbat_ge);
> +
> +	ret = devm_iio_map_array_register(dev, indio_dev, dc_ti_adc_default_maps);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_adc_isr,
> +					IRQF_ONESHOT, indio_dev->name, info);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id dc_ti_adc_ids[] = {
> +	{ .name = "chtdc_ti_adc", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, dc_ti_adc_ids);
> +
> +static struct platform_driver dc_ti_adc_driver = {
> +	.driver = {
> +		.name	= "dc_ti_adc",
> +	},
> +	.probe		= dc_ti_adc_probe,
> +	.id_table	= dc_ti_adc_ids,
> +};
> +module_platform_driver(dc_ti_adc_driver);
> +
> +MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
> +MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
> +MODULE_DESCRIPTION("Intel Dollar Cove (TI) GPADC Driver");
> +MODULE_LICENSE("GPL");


