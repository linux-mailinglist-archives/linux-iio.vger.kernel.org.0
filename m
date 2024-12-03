Return-Path: <linux-iio+bounces-13042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA49E2CC9
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4A1162962
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB51FAC5A;
	Tue,  3 Dec 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVoJqvD2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F01170A1B;
	Tue,  3 Dec 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256591; cv=none; b=bb7T1jRl2K0j6GmCO/7JpPjIGHnOfNL3U7Lkwwjm3ZhQuXPGacM7QowmJKX0rlOJzFdhAZrNEA3T4Q+sIvbWd806StdlUrbzncPxq1TYhQ2UUpDjWwm+UulTNni/pYaoKXdNXK3fEwnjB5zbaIpqoBR4ifjivGH+Ox+Dqjg2pmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256591; c=relaxed/simple;
	bh=QybYAIlWiBGScx7e9c025LBXugT6rKAICroVQWxNRng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ayqvv2h8R+LPV3wEZyqhoZ608dbxrsYrmAtMGw75v2PEbdvrR/dwp0KOiVHgvtXxBqwpJPmgRlikZVUqa9UjAnumrYpaix1z+3QGF3QOuc27iejFFQ81wwbKJyn0IMl2Y86mQ6nzNKsDLQoXLMnTWVzdXFtJVQuBA8U0YC3A7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVoJqvD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7079C4CED8;
	Tue,  3 Dec 2024 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733256590;
	bh=QybYAIlWiBGScx7e9c025LBXugT6rKAICroVQWxNRng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVoJqvD2SNC/81pubhRU3IOjW7o7pPMR7xxNNxI5BGlRyEanpAD7V8Wgq2DKZEE2c
	 VZ652JQDsvEnv3CgH6GpJGr3Zh1k4LrmurIW1jS1zFQT/MtVrGb8Y80OkDgQ58uRrB
	 4zLcO5WruekT06AcJDCc8GAqLXOq+tD5tJCrCthFy+8JhRhq+ir6y78wqMnmuMmsBi
	 BQnUfFu8bfW/85cLzSFfuL7Vl4PjXvNQ5BvQEn/BguuaS5X5MyG2cgzW0X9p/M9c2O
	 4cIS7Ibnsfero/0K55dP1ilwjMthoiGzo/giRwlzeXeEo3ZTfWqHM2XA9GetTZd6G7
	 UjaI2Q+CsyXZA==
Date: Tue, 3 Dec 2024 20:09:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 08/14] iio: adc: rzg2l_adc: Prepare for the addition of
 RZ/G3S support
Message-ID: <20241203200941.03ec9ea3@jic23-huawei>
In-Reply-To: <20241203111314.2420473-9-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:13:08 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The ADC IP available on the RZ/G3S differs slightly from the one found on
> the RZ/G2L. The identified differences are as follows:
> - different number of channels (one being used for temperature conversion);
>   consequently, various registers differ
> - different default sampling periods
> - the RZ/G3S variant lacks the ADVIC register.
> 
> To accommodate these differences, the rzg2l_adc driver has been updated by
> introducing the struct rzg2l_adc_hw_params, which encapsulates the
> hardware-specific differences between the IP variants. A pointer to an
> object of type struct rzg2l_adc_hw_params is embedded in
> struct rzg2l_adc_data.
> 
> Additionally, the completion member of struct rzg2l_adc_data was relocated
> to avoid potential padding, if any.
> 
> The code has been adjusted to utilize hardware-specific parameters stored
> in the new structure instead of relying on plain macros.
> 
> The check of chan->channel in rzg2l_adc_read_raw() function, against the
> driver specific mask was removed as the subsystem should have already
> been done this before reaching the rzg2l_adc_read_raw() function.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 92 ++++++++++++++++++++++++++-----------
>  1 file changed, 64 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index fda8b42ded81..aff41152ebf8 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -32,20 +32,15 @@
>  #define RZG2L_ADM1_MS			BIT(2)
>  #define RZG2L_ADM1_BS			BIT(4)
>  #define RZG2L_ADM1_EGA_MASK		GENMASK(13, 12)
> -#define RZG2L_ADM2_CHSEL_MASK		GENMASK(7, 0)
>  #define RZG2L_ADM3_ADIL_MASK		GENMASK(31, 24)
>  #define RZG2L_ADM3_ADCMP_MASK		GENMASK(23, 16)
> -#define RZG2L_ADM3_ADCMP_E		FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, 0xe)
> -#define RZG2L_ADM3_ADSMP_MASK		GENMASK(15, 0)
>  
>  #define RZG2L_ADINT			0x20
> -#define RZG2L_ADINT_INTEN_MASK		GENMASK(7, 0)
>  #define RZG2L_ADINT_CSEEN		BIT(16)
>  #define RZG2L_ADINT_INTS		BIT(31)
>  
>  #define RZG2L_ADSTS			0x24
>  #define RZG2L_ADSTS_CSEST		BIT(16)
> -#define RZG2L_ADSTS_INTST_MASK		GENMASK(7, 0)
>  
>  #define RZG2L_ADIVC			0x28
>  #define RZG2L_ADIVC_DIVADC_MASK		GENMASK(8, 0)
> @@ -56,12 +51,26 @@
>  #define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
>  #define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
>  
> -#define RZG2L_ADSMP_DEFAULT_SAMPLING	0x578
> -
> -#define RZG2L_ADC_MAX_CHANNELS		8
> -#define RZG2L_ADC_CHN_MASK		0x7
>  #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
>  
> +/**
> + * struct rzg2l_adc_hw_params - ADC hardware specific parameters
> + * @default_adsmp: default ADC sampling period (see ADM3 register)
> + * @adsmp_mask: ADC sampling period mask (see ADM3 register)
> + * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
> + * @default_adcmp: default ADC cmp (see ADM3 register)
> + * @num_channels: number of supported channels
> + * @adivc: specifies if ADVIC register is available
> + */
> +struct rzg2l_adc_hw_params {
> +	u16 default_adsmp;
> +	u16 adsmp_mask;
> +	u16 adint_inten_mask;
> +	u8 default_adcmp;
> +	u8 num_channels;
> +	bool adivc;
> +};
> +
>  struct rzg2l_adc_data {
>  	const struct iio_chan_spec *channels;
>  	u8 num_channels;
> @@ -71,10 +80,11 @@ struct rzg2l_adc {
>  	void __iomem *base;
>  	struct reset_control *presetn;
>  	struct reset_control *adrstn;
> -	struct completion completion;
>  	const struct rzg2l_adc_data *data;
> +	const struct rzg2l_adc_hw_params *hw_params;
> +	u16 *last_val;
> +	struct completion completion;
>  	struct mutex lock;
> -	u16 last_val[RZG2L_ADC_MAX_CHANNELS];

Just make this big enough for the max device.  Chances are it will make little or
no difference to this allocation and nice to avoid the dynamic part.

Feel free to add a runtime check to make sure this is big enough to avoid any
future problems with forgetting to update it.

>  };
>

> @@ -392,6 +410,15 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  
>  	adc = iio_priv(indio_dev);
>  
> +	adc->hw_params = device_get_match_data(dev);
> +	if (!adc->hw_params)
> +		return -EINVAL;
> +
> +	adc->last_val = devm_kcalloc(dev, adc->hw_params->num_channels,
> +				     sizeof(*adc->last_val), GFP_KERNEL);
> +	if (!adc->last_val)
> +		return -ENOMEM;
> +
>  	ret = rzg2l_adc_parse_properties(pdev, adc);
>  	if (ret)
>  		return ret;
> @@ -449,8 +476,17 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(dev, indio_dev);
>  }

