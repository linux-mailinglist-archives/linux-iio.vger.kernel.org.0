Return-Path: <linux-iio+bounces-21876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7BBB0DF51
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E42A7AEDC8
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105692EACFF;
	Tue, 22 Jul 2025 14:47:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32572DECA5
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195648; cv=none; b=ntnGqoga2C8SnqB9U2kF13aOLiquNfXReoonJP6GpSl8zEOG1qlQXARNBI+cab6IwenXbLFG6SBNpbT3OaXiZuIf9iUjDdazY7yTtej8NMbNZ58VmuBBWFM3Bf6N9W7MtkKt18Clqped/jZRcWdKIGg1FGhpodbPnngQSpidGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195648; c=relaxed/simple;
	bh=pw7Gou+8+POYddphqnamJaWm4RFGDeW5ZrjRbLXqpR8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pveLq9Aflbz1D+slnmgsRGu86N21Iw+6lsN0vnw1uoUOlehvhoOSzl/cy0xEdP9HQJMpIj4O7caPJUxpIXUk4LPVmdz1qhPL4a4MFldGO32i1bGSpeisRnEbd79QkjLyokvA9iubIDfAqHcyhsi7KQFbEMfU7xT7UgGHOaiLRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmg4P05qrz6L4sZ;
	Tue, 22 Jul 2025 22:43:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 64F4F140114;
	Tue, 22 Jul 2025 22:47:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 16:47:22 +0200
Date: Tue, 22 Jul 2025 15:47:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Hans de Goede <hansg@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC
 driver
Message-ID: <20250722154721.000054a3@huawei.com>
In-Reply-To: <20250721150614.51918-3-hansg@kernel.org>
References: <20250721150614.51918-1-hansg@kernel.org>
	<20250721150614.51918-3-hansg@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Jul 2025 17:06:14 +0200
Hans de Goede <hansg@kernel.org> wrote:

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

A couple of really minor things from me.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
> new file mode 100644
> index 000000000000..6f27c45679cc
> --- /dev/null
> +++ b/drivers/iio/adc/intel_dc_ti_adc.c

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
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_CH_SEL, FIELD_PREP(DC_TI_ADC_CH_SEL, ch));

Bit of a long line. I'd still rather keep under 80 chars when there is no
strong readability argument for not doing so.

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

When you are going to do unconditional disabling like here, might be better
to factor this bit out so we don't need the goto.  I don't care too much
though if you don't want to bother with that particularly as next change
suggested will reduce the number of times that goto happens.

> +	/* TI (PMIC Vendor) recommends 5 sec timeout for conversion */
> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
> +	if (ret == 0) {
> +		dev_err(info->dev, "Error sample timeout\n");
> +		ret = -ETIMEDOUT;
> +		goto disable_adc;
> +	}
> +
> +	/* Reading multiple registers at once is not supported */

Set the magic flag in regmap_config to allow build reads to be automatically
broken into parts.  I think this is what use_single_read controls.

Then you can read it into a u8 array and use an endian conversion.


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
> +	return ret;
> +}




