Return-Path: <linux-iio+bounces-6734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECE49137CF
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 07:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F691F21E9E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF720332;
	Sun, 23 Jun 2024 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAsce+AC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEC64D;
	Sun, 23 Jun 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719120448; cv=none; b=G3DNqrUjUdYLM5I9PZ2+dBGG9plC7YjWNiQajfDBAAMRayaPG+CUjcg2AApXbSF/nAr1Q9CetSyurZDGC95u5ozhQYdCUGETCKkmIsE8mBpgekxGm+N1GKdccgm/vOrcoMbeEGNSgsrIH+Iz3HAECP/Zqk728N40R6PDKBT02mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719120448; c=relaxed/simple;
	bh=V/8zCuvXkhy2H8rY5y9wEQOUJsBGy0R8u0ynQma3TnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK86HU3HfBUPMZjoO+TRkaPvJ6SwP6AoFzc865GfFY2rsTcir6z9JxFsrhDMCxBA906FAmwrnR3kq7miPf8HXn0ptJj718mi6zjlsB0eyUaOwk0JwdJtsV+mFlmC2KENZe10Ek8rIXq4NwHJNHXfXBIpVPqlDxMUa0KoflQxLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAsce+AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9258C2BD10;
	Sun, 23 Jun 2024 05:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719120448;
	bh=V/8zCuvXkhy2H8rY5y9wEQOUJsBGy0R8u0ynQma3TnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAsce+ACSKTM7cjhTXt1zLH6VD04Cx6kgX0vuCp8tXiBVNMOzDzEtydRaLEKgi6cD
	 AT4XJK4fxFEvDCQML12HP6i0GZrv2n67/dMUkPxpBa1+lDDkvVaBLYGQf/560BQFZ8
	 OAnil3l96godn+tqqT/SZJGM0x/7GVd5KkqWdErGF553MgOa45o9WHBowxAVu+4RvL
	 XKU36nLiT+xEBHpKygPu20VQ+uFRfj3Wi1hdt2IIjODkghDml8AOVeyg3qCcuCe0o1
	 vnQvCtQtUgGVCsfJ6J6Mot9US1bZBJfpMmbV92XxS0OpCMuSlHBOFFwi9GTv+Huxyi
	 13qc3sD2gjIlA==
Received: by wens.tw (Postfix, from userid 1000)
	id B440F5FA33; Sun, 23 Jun 2024 13:27:25 +0800 (CST)
Date: Sun, 23 Jun 2024 13:27:25 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 5/8] iio: adc: axp20x_adc: add support for AXP717 ADC
Message-ID: <ZneyPV9DYzjNV5_x@wens.tw>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-6-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220535.359021-6-macroalpha82@gmail.com>

On Mon, Jun 17, 2024 at 05:05:32PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 ADC. The AXP717 differs from other ADCs
> in this series by utilizing a 14 bit ADC for all channels (a full 16
> bits with the first 2 digits reserved). It also differs by lacking a
> battery discharge current channel.

Maybe charge and discharge share the same channel?

> Note that while the current charge channel itself is included in this
> driver for the AXP717 and listed in the datasheet, no scale or offset
> was given for this channel. For now no scale or offset is provided in
> this driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/iio/adc/axp20x_adc.c | 167 +++++++++++++++++++++++++++++++++--
>  1 file changed, 160 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index d6c51b0f48e3..f35ba2c11e1b 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -5,6 +5,7 @@
>   *	Quentin Schulz <quentin.schulz@free-electrons.com>
>   */
>  
> +#include <asm/unaligned.h>
>  #include <linux/bitfield.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
> @@ -27,6 +28,8 @@
>  
>  #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
>  
> +#define AXP717_ADC_EN1_MASK			GENMASK(5, 0)
> +
>  #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
>  #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
>  
> @@ -35,6 +38,11 @@
>  
>  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
>  
> +#define AXP717_ADC_DATA_TS			0x00
> +#define AXP717_ADC_DATA_TEMP			0x01
> +
> +#define AXP717_ADC_DATA_MASK			0x3fff
> +
>  #define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
>  #define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
>  #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
> @@ -98,6 +106,18 @@ enum axp22x_adc_channel_i {
>  	AXP22X_BATT_DISCHRG_I,
>  };
>  
> +enum axp717_adc_channel_v {
> +	AXP717_BATT_V = 0,
> +	AXP717_TS_IN,
> +	AXP717_VBUS_V,
> +	AXP717_VSYS_V,
> +	AXP717_DIE_TEMP_V,

Please also add VMID and backup battery voltage.

> +};
> +
> +enum axp717_adc_channel_i {
> +	AXP717_BATT_CHRG_I = 5,
> +};
> +
>  enum axp813_adc_channel_v {
>  	AXP813_TS_IN = 0,
>  	AXP813_GPIO0_V,
> @@ -152,6 +172,22 @@ static struct iio_map axp22x_maps[] = {
>  	}, { /* sentinel */ }
>  };
>  
> +static struct iio_map axp717_maps[] = {
> +	{
> +		.consumer_dev_name = "axp20x-usb-power-supply",
> +		.consumer_channel = "vbus_v",
> +		.adc_channel_label = "vbus_v",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_v",
> +		.adc_channel_label = "batt_v",
> +	}, {
> +		.consumer_dev_name = "axp20x-battery-power-supply",
> +		.consumer_channel = "batt_chrg_i",
> +		.adc_channel_label = "batt_chrg_i",
> +	},
> +};
> +
>  /*
>   * Channels are mapped by physical system. Their channels share the same index.
>   * i.e. acin_i is in_current0_raw and acin_v is in_voltage0_raw.
> @@ -210,6 +246,25 @@ static const struct iio_chan_spec axp22x_adc_channels[] = {
>  			   AXP22X_TS_ADC_H),
>  };
>  
> +/*
> + * Scale and offset is unknown for temp, ts, and batt_chrg_i channels
> + * for now. Leaving scale and offset undefined for now.
> + */
> +static const struct iio_chan_spec axp717_adc_channels[] = {
> +	AXP20X_ADC_CHANNEL(AXP717_BATT_V, "batt_v", IIO_VOLTAGE,
> +			   AXP717_BATT_V_H),
> +	AXP20X_ADC_CHANNEL(AXP717_TS_IN, "ts_v", IIO_VOLTAGE,
> +			   AXP717_ADC_DATA_H),
> +	AXP20X_ADC_CHANNEL(AXP717_VBUS_V, "vbus_v", IIO_VOLTAGE,
> +			   AXP717_VBUS_V_H),
> +	AXP20X_ADC_CHANNEL(AXP717_VSYS_V, "vsys_v", IIO_VOLTAGE,
> +			   AXP717_VSYS_V_H),
> +	AXP20X_ADC_CHANNEL(AXP717_DIE_TEMP_V, "pmic_temp", IIO_TEMP,
> +				  AXP717_ADC_DATA_H),
> +	AXP20X_ADC_CHANNEL(AXP717_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> +			   AXP717_BATT_CHRG_I_H),
> +};
> +
>  static const struct iio_chan_spec axp813_adc_channels[] = {
>  	{
>  		.type = IIO_TEMP,
> @@ -269,6 +324,44 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
>  	return IIO_VAL_INT;
>  }
>  
> +static int axp717_adc_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val)
> +{
> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +	u8 bulk_reg[2];
> +	int ret;
> +
> +	/*
> +	 * A generic "ADC data" channel is used for TS, tdie, vmid,
> +	 * and vbackup. This channel must both first be enabled and
> +	 * also selected before it can be read.
> +	 */
> +	switch (chan->channel) {
> +	case AXP717_TS_IN:
> +		regmap_write(info->regmap, AXP717_ADC_DATA_SEL,
> +			     AXP717_ADC_DATA_TS);
> +		break;
> +	case AXP717_DIE_TEMP_V:
> +		regmap_write(info->regmap, AXP717_ADC_DATA_SEL,
> +			     AXP717_ADC_DATA_TEMP);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * All channels are 14 bits, with the first 2 bits on the high
> +	 * register reserved and the remaining bits as the ADC value.
> +	 */
> +	ret = regmap_bulk_read(info->regmap, chan->address, bulk_reg, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = get_unaligned_be16(bulk_reg) & AXP717_ADC_DATA_MASK;
> +	return IIO_VAL_INT;
> +}
> +
>  static int axp813_adc_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan, int *val)
>  {
> @@ -425,6 +518,27 @@ static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
>  	}
>  }
>  
> +static int axp717_adc_scale(struct iio_chan_spec const *chan, int *val,
> +			    int *val2)
> +{
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		*val = 1;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CURRENT:
> +		*val = 1;
> +		return IIO_VAL_INT;
> +
> +	case IIO_TEMP:
> +		*val = 100;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
>  			    int *val2)
>  {
> @@ -529,6 +643,22 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int axp717_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return axp717_adc_scale(chan, val, val2);
> +
> +	case IIO_CHAN_INFO_RAW:
> +		return axp717_adc_raw(indio_dev, chan, val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int axp813_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
> @@ -593,6 +723,10 @@ static const struct iio_info axp22x_adc_iio_info = {
>  	.read_raw = axp22x_read_raw,
>  };
>  
> +static const struct iio_info axp717_adc_iio_info = {
> +	.read_raw = axp717_read_raw,
> +};
> +
>  static const struct iio_info axp813_adc_iio_info = {
>  	.read_raw = axp813_read_raw,
>  };
> @@ -622,7 +756,9 @@ struct axp_data {
>  	const struct iio_info		*iio_info;
>  	int				num_channels;
>  	struct iio_chan_spec const	*channels;
> +	unsigned long			adc_en1;
>  	unsigned long			adc_en1_mask;
> +	unsigned long			adc_en2;
>  	unsigned long			adc_en2_mask;
>  	int				(*adc_rate)(struct axp20x_adc_iio *info,
>  						    int rate);
> @@ -633,7 +769,9 @@ static const struct axp_data axp20x_data = {
>  	.iio_info = &axp20x_adc_iio_info,
>  	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
>  	.channels = axp20x_adc_channels,
> +	.adc_en1 = AXP20X_ADC_EN1,
>  	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
> +	.adc_en2 = AXP20X_ADC_EN2,
>  	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
>  	.adc_rate = axp20x_adc_rate,
>  	.maps = axp20x_maps,
> @@ -643,15 +781,26 @@ static const struct axp_data axp22x_data = {
>  	.iio_info = &axp22x_adc_iio_info,
>  	.num_channels = ARRAY_SIZE(axp22x_adc_channels),
>  	.channels = axp22x_adc_channels,
> +	.adc_en1 = AXP20X_ADC_EN1,
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp22x_adc_rate,
>  	.maps = axp22x_maps,
>  };

Please split out the changes generalizing the driver into a separate
patch. That makes it easier to follow.


ChenYu

> +static const struct axp_data axp717_data = {
> +	.iio_info = &axp717_adc_iio_info,
> +	.num_channels = ARRAY_SIZE(axp717_adc_channels),
> +	.channels = axp717_adc_channels,
> +	.adc_en1 = AXP717_ADC_CH_EN_CONTROL,
> +	.adc_en1_mask = AXP717_ADC_EN1_MASK,
> +	.maps = axp717_maps,
> +};
> +
>  static const struct axp_data axp813_data = {
>  	.iio_info = &axp813_adc_iio_info,
>  	.num_channels = ARRAY_SIZE(axp813_adc_channels),
>  	.channels = axp813_adc_channels,
> +	.adc_en1 = AXP20X_ADC_EN1,
>  	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
>  	.adc_rate = axp813_adc_rate,
>  	.maps = axp22x_maps,
> @@ -660,6 +809,7 @@ static const struct axp_data axp813_data = {
>  static const struct of_device_id axp20x_adc_of_match[] = {
>  	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
>  	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
> +	{ .compatible = "x-powers,axp717-adc", .data = (void *)&axp717_data, },
>  	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
>  	{ /* sentinel */ }
>  };
> @@ -668,6 +818,7 @@ MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
>  static const struct platform_device_id axp20x_adc_id_match[] = {
>  	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
>  	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
> +	{ .name = "axp717-adc", .driver_data = (kernel_ulong_t)&axp717_data, },
>  	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
>  	{ /* sentinel */ },
>  };
> @@ -709,15 +860,17 @@ static int axp20x_probe(struct platform_device *pdev)
>  	indio_dev->channels = info->data->channels;
>  
>  	/* Enable the ADCs on IP */
> -	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
> +	regmap_write(info->regmap, info->data->adc_en1,
> +		     info->data->adc_en1_mask);
>  
>  	if (info->data->adc_en2_mask)
> -		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> +		regmap_update_bits(info->regmap, info->data->adc_en2,
>  				   info->data->adc_en2_mask,
>  				   info->data->adc_en2_mask);
>  
>  	/* Configure ADCs rate */
> -	info->data->adc_rate(info, 100);
> +	if (info->data->adc_rate)
> +		info->data->adc_rate(info, 100);
>  
>  	ret = iio_map_array_register(indio_dev, info->data->maps);
>  	if (ret < 0) {
> @@ -737,10 +890,10 @@ static int axp20x_probe(struct platform_device *pdev)
>  	iio_map_array_unregister(indio_dev);
>  
>  fail_map:
> -	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> +	regmap_write(info->regmap, info->data->adc_en1, 0);
>  
>  	if (info->data->adc_en2_mask)
> -		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> +		regmap_write(info->regmap, info->data->adc_en2, 0);
>  
>  	return ret;
>  }
> @@ -753,10 +906,10 @@ static void axp20x_remove(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  	iio_map_array_unregister(indio_dev);
>  
> -	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> +	regmap_write(info->regmap, info->data->adc_en1, 0);
>  
>  	if (info->data->adc_en2_mask)
> -		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> +		regmap_write(info->regmap, info->data->adc_en2, 0);
>  }
>  
>  static struct platform_driver axp20x_adc_driver = {
> -- 
> 2.34.1
> 

