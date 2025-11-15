Return-Path: <linux-iio+bounces-26248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4695C60A1A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A9EB355D5B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476153064BD;
	Sat, 15 Nov 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMNnsm7S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB51D416E;
	Sat, 15 Nov 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232312; cv=none; b=EVkA8CSk8QxRdNC2iyIsEKhczrYWZK7/17Uqx2+b/1xjpVfvdY1v4fLP0p27MoqvSgiQK+qwM1a7B8Q1MK6uS6Tl5OfPD51xxTdg1x8rxVisPuMZNvdo5XtwTK5TTCIqT3j+LuE/QyIYSRWej5cJ2GtmPDP9iVu4xX4wbSkgghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232312; c=relaxed/simple;
	bh=phbopqoY2XNNGPXNm865cyEKU4YD6J/4orALxj4/w24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+xpkXRYv48dQN0N4U3Jwu0y5x2esTb7iGFBEf76EY2YCzVmgnr4qjdTaXenoEH7Lhmbguy3WOuykLXBQx5GYhZQW+kCfG01jhjU7ZamqAgwR21y6dOknDsQKgkQlJJgC13piCf87uTFMQ2WxzjTi4Xv7stcqQPk1NJXK4CVjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMNnsm7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6052FC116D0;
	Sat, 15 Nov 2025 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763232311;
	bh=phbopqoY2XNNGPXNm865cyEKU4YD6J/4orALxj4/w24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UMNnsm7SHz76uLVK03qhLocvvl432HkI+F4wWAmsZqV4lgMyIbz8Hb7bEi/NdsvNR
	 0gc02iGyKJQiLNLpZTB9VDJBvb4YEvukRSo49wSyaD7e4bs9ZkrwreDcHJD8pRJO9w
	 Mz8PmouBi2ta0OVhtVpMB78YkPXqERng7jZjmgsp2zAmmEBfZ6mBTkVie/X86lbaL5
	 BnQsbMhwtMdbim43mWXWjgtN3rna2M4tnPNHD1E5AV3jK4xaXoz+k8QM9RHa8nBUmF
	 vNTzC6M5LkaZCw5R5L9NySHhPqZWv1Zp89otdkalrrZc459edXAkI23/B5x0M0yIg3
	 kuqj7umriX6cw==
Date: Sat, 15 Nov 2025 18:45:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
Message-ID: <20251115184503.57a071b1@jic23-huawei>
In-Reply-To: <20251109141119.561756-3-ajithanandhan0406@gmail.com>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
	<20251109141119.561756-3-ajithanandhan0406@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 19:41:19 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> Add driver for the Texas Instruments ADS1120, a precision 16-bit
> analog-to-digital converter with an SPI interface.
> 
> The driver supports:
> - Differential and single-ended input channels
> - Configurable gain (1-128 for differential, 1-4 for single-ended)
> - Internal 2.048V reference
> - Single-shot conversion mode
> 
> Also update MAINTAINER document.
> 
> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
Hi Ajith

A few comments from me to add to Andy's review. 

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d008f78dc..49c56b459 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -144,6 +144,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
> +obj-$(CONFIG_TI_ADS1120) += ti-ads1120.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
>  obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
> diff --git a/drivers/iio/adc/ti-ads1120.c b/drivers/iio/adc/ti-ads1120.c
> new file mode 100644
> index 000000000..1e1871b74
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1120.c

> +
> +/* Differential channel macro */
> +#define ADS1120_DIFF_CHANNEL(index, chan1, chan2)		\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = chan1,					\
> +	.channel2 = chan2,					\
> +	.differential = 1,					\
> +	.address = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +/* Single-ended channel macro */
> +#define ADS1120_SINGLE_CHANNEL(index, chan)			\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = chan,					\
> +	.address = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
I note that scale is the same for all channels. So why have separate
attributes?

> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +/* Diagnostic channel macro */
> +#define ADS1120_DIAG_CHANNEL(index, label)			\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.address = index,					\
> +	.extend_name = label,					\

We very rarely allow extend)name in new drivers.
It is a real pain for userspace code to deal with, so we now
put that info behind the get_label() callback.

It's also fairly rare that we put diagnostic channels out.  Might
be better to push those to debugfs and keep the main interface
less confusing.

Shorted is sometimes done as a differential channel with itself
(doesn't matter which one). It's made a little more complex here
as it is specified as shorting both to (AVDD + AVDSS) / 2 .


> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +static const struct iio_chan_spec ads1120_channels[] = {
> +	/* Differential inputs */
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN1, 0, 1),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN2, 0, 2),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN3, 0, 3),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN2, 1, 2),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN3, 1, 3),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN2_AIN3, 2, 3),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN0, 1, 0),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN3_AIN2, 3, 2),
> +	/* Single-ended inputs */
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN0_AVSS, 0),
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN1_AVSS, 1),
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN2_AVSS, 2),
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN3_AVSS, 3),
> +	/* Diagnostic inputs */
> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_REFP_REFN_4, "ref_div4"),
> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_AVDD_AVSS_4, "avdd_div4"),
> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_SHORTED, "shorted"),
> +};

> +
> +/* Regmap read function for ADS1120 */
> +static int ads1120_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ads1120_state *st = context;
> +	u8 reg = *(u8 *)reg_buf;
> +	u8 *val = val_buf;
> +	int ret;
> +	struct spi_transfer xfer[2] = {
> +		{
> +			.tx_buf = st->data,
> +			.len = 1,
> +		}, {
> +			.rx_buf = val,
> +			.len = val_size,
> +		}
> +	};
> +
> +	if (reg > ADS1120_REG_CONFIG3)
> +		return -EINVAL;
> +
> +	/* RREG command: 0010rr00 where rr is register address */
> +	st->data[0] = ADS1120_CMD_RREG | (reg << 2);
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));

return spi_sync_transfer()

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

> +
> +static const struct regmap_config ads1120_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADS1120_REG_CONFIG3,
> +	.cache_type = REGCACHE_FLAT,

Andy covered this already but unless you have strong reason for
something else just use REGCACHE_MAPLE.  If you do have a reason
add a comment here to stop it being changed by someone else.

> +};

> +
> +static int ads1120_probe(struct spi_device *spi)
> +{

> +	indio_dev->name = "ads1120";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1120_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1120_channels);
> +	indio_dev->info = &ads1120_info;
> +
> +	ret = ads1120_init(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"Failed to initialize device\n");
Align as.
		return dev_err_probe(dev, ret,
				     "Failed to initialize device\n");

Same for all other similar cases.


> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

