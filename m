Return-Path: <linux-iio+bounces-13043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA29C9E2CEA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFDF280DE8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA1204F8E;
	Tue,  3 Dec 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTkBsFf7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20211B0F09;
	Tue,  3 Dec 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257148; cv=none; b=Jk5fzkJl6eb/xw/DC7V4RhmD53nb7sMSDqZusMsXQSLopzm5cmBrDlmici0eVq1jMYS/4JeuveGwx5xUT9RBRlU8zUsDuadSQNW7e2/yIgLE66+aZ30CMdtJFPVN+0savOSL8Hfc7Fvq/n6/HtqB1UpVwNBCgMkuDTOGjKF0CoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257148; c=relaxed/simple;
	bh=6+2KVTluPIDVxgkNKtooAg7EYhL81BVX5FVJw70UHz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qieNQTJ+kjqUFFD4qHgYyhAxMm9nh+JaZt5PjwDNsw8crf2zPM2LpD9qsTimjN1bJCBYFlqm4G+QdmulTtGvx/YZLtxEgzZdbk+93GFbJ+BokWDSb4uvf7JPNX3feQVFYlEeNGzwn8U3H93yzJZyxDueAwwhCoztWchWXIOcdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTkBsFf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A6C4CECF;
	Tue,  3 Dec 2024 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733257147;
	bh=6+2KVTluPIDVxgkNKtooAg7EYhL81BVX5FVJw70UHz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CTkBsFf7Rclr9R9AFgd5T12PSArLsh28gfaCmBQm8Geu07W3w5tT+JQFLBELMzWjd
	 3pe79x1onntHpLBjxlMaIwDW7M9b/WFtQ3r7PaUuQ3TEc+0LUGmKKXIth+FvDewXeW
	 dFu1JVRaE/rRhS8B/kIBvp9VfLCqxncxV2wBWcpqgwpvcG/g7cE3Ez1EQT4oa+e4eE
	 MhDphfzAZOSELz/JH7GXYQJdWkCOpT4hoJIWw51lJc8NM+9Q7C9/nWOg9WgmEqqS62
	 /DLHCJCOcuq0IkVQWA0jHD7dKoAaTSJwqpg8jLv1YfTj3Wpl8ifLOGGA+bdppeqnu6
	 WGkQjS+nTHovA==
Date: Tue, 3 Dec 2024 20:18:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 09/14] iio: adc: rzg2l_adc: Add support for channel 8
Message-ID: <20241203201857.7ccdcf99@jic23-huawei>
In-Reply-To: <20241203111314.2420473-10-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:13:09 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The ADC on the Renesas RZ/G3S SoC includes an additional channel (channel
> 8) dedicated to reading temperature values from the Thermal Sensor Unit
> (TSU). There is a direct in-SoC connection between the ADC and TSU IPs.
> 
> To read the temperature reported by the TSU, a different sampling rate
> (compared to channels 0-7) must be configured in the ADM3 register.
> 
> The rzg2l_adc driver has been updated to support reading the TSU
> temperature.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

>  static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
> @@ -161,7 +173,7 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
>  	rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
>  }
>  
> -static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> +static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch, enum iio_chan_type type)
>  {
>  	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
>  	u32 reg;
> @@ -177,6 +189,15 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>  	reg |= BIT(ch);
>  	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
>  
> +	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
> +	reg &= ~hw_params->adsmp_mask;
> +	/*
> +	 * type could be IIO_VOLTAGE = 0 or IIO_TEMP = 9. Divide to 8 to get
> +	 * index 0 or 1 depending on the channel type.

That is not particularly nice and potentially a little fragile if we get other device
support in future. Better to match on the type in rzg2l_adc_channels[] possibly wrapped
up in a little utility function bool rzg2l_adc_channels_is_temp(); Then use a
? 1 : 0 to get the offset in default_adsmp[]


> +	 */
> +	reg |= hw_params->default_adsmp[type / 8];
> +	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> +
>  	/*
>  	 * Setup ADINT
>  	 * INTS[31] - Select pulse signal
> @@ -192,7 +213,8 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>  	return 0;
>  }
>
>  
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type != IIO_TEMP)
> +			return -EINVAL;
> +
> +		mutex_lock(&adc->lock);
> +		ret = rzg2l_adc_conversion(indio_dev, chan->type, adc, ch);
> +		if (!ret) {
> +			/* Convert it to mili Celsius. */
> +			*val = adc->last_val[ch] * 1000;
Prefer you provide a scale of 1000 and report this raw.
> +		}
Also strong preference for error conditions out of line.
As in that other case, guard() makes that easier as yo ucan do
		{

			guard(mutex)(&adc->lock);
			ret = rz....
			if (ret)
				return ret;

			*val = ...
			
			return IIO_VAL_INT;
		}

> +		mutex_unlock(&adc->lock);
> +
> +		return ret ? ret : IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}

>  static const struct iio_info rzg2l_adc_iio_info = {
> @@ -332,11 +368,14 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>  		if (channel >= hw_params->num_channels)
>  			return -EINVAL;
>  
> -		chan_array[i].type = IIO_VOLTAGE;
> +		chan_array[i].type = rzg2l_adc_channels[channel].type;
>  		chan_array[i].indexed = 1;
>  		chan_array[i].channel = channel;
> -		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
> +		if (rzg2l_adc_channels[channel].type == IIO_VOLTAGE)
> +			chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		else
> +			chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);

Make it raw, but I'm curious we have no _SCALE on this device.  Do we really have no idea
of the calibration of these channels?

> +		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
>  		i++;
>  	}
>  
> @@ -386,7 +425,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>  	reg &= ~RZG2L_ADM3_ADCMP_MASK;
>  	reg &= ~hw_params->adsmp_mask;
>  	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
> -	       hw_params->default_adsmp;
> +	       hw_params->default_adsmp[0];
>  
>  	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>  
> @@ -479,7 +518,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
>  	.num_channels = 8,
>  	.default_adcmp = 0xe,
> -	.default_adsmp = 0x578,
> +	.default_adsmp = { 0x578 },
>  	.adsmp_mask = GENMASK(15, 0),
>  	.adint_inten_mask = GENMASK(7, 0),
>  	.adivc = true


