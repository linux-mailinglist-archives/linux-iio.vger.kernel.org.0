Return-Path: <linux-iio+bounces-6230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E0906882
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10A61F2223B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895413E02F;
	Thu, 13 Jun 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KFeBY6C6"
X-Original-To: linux-iio@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC313D891;
	Thu, 13 Jun 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270671; cv=none; b=oDd3A9qeHbbmbRFGeeuiJ5kfmYku8Gux/B+wrG8lSg7zTckZm2jD/64M8pGtsFe2KdDtLkgh7yVjXTR1SETVRUEhVaQZXXpoipAy946gwe5Huxlo7SmsK2y4fnB7WoPlSlTDm2OaZ8/SdyJHfj0/fTB+ekCIutq9Q4paY6MWrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270671; c=relaxed/simple;
	bh=+vQn3HjO/YchQui9IJ3APLcbMNH88nHBloO+VGQCjaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6b41LVsJ6n4kYV5WorSeTWYhj/0QkdFum0K2tGuy1YDxNB+IIvVtn6zsc79a6IdgxhG6+PrsNUUsKOxw/tuHTqO9M7OakY61F16NcEEPJsbdZag0re+rMGFK6ZkMycIHFmbWKSw/ZX8MnuKLVB6y0CO2+LdMb2DQg35eGx+Dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KFeBY6C6; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718270660; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KbWX8Db8CbQXtBeXWc2CukpLYCDdNStf9N0SgO0PdS0=;
	b=KFeBY6C66rgRfcshfoD1qIC0xD18OCFhWQMpAMiLpD1rtbeBeOnn8L+4w6pXxEWYJM0AM2ut9kz55DJ9IqjXCa4mODPmGblXCIx1IJZcxME3/tlr9FcuwTBjZs3ceA0gVsAgKCC+4nmyxr3L4Obvyw2nuKRyzay6ZCnIDTwzd5I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W8NgDjm_1718270656;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8NgDjm_1718270656)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 17:24:18 +0800
Message-ID: <3b7950db-bde8-407e-b568-51cacee93ad8@linux.alibaba.com>
Date: Thu, 13 Jun 2024 17:24:14 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Lucas Stankus <lucas.p.stankus@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>,
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Linus Walleij <linus.walleij@linaro.org>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240611165214.4091591-1-tgamblin@baylibre.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240611165214.4091591-1-tgamblin@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/12 00:52, Trevor Gamblin wrote:
> Simplify the way regmap is accessed in iio drivers.
> 
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
> 
> Instead of using regmap_update_bits() and passing val = 0, use
> regmap_clear_bits().
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

[...]

> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index b4a2e057d80f..2535c2c3e60b 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -508,13 +508,13 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>   		}
>   	}
>   
> -	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> -				 SC27XX_ADC_EN, SC27XX_ADC_EN);
> +	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> +			      SC27XX_ADC_EN);
>   	if (ret)
>   		goto regulator_restore;
>   
> -	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
> -				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
> +	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
> +			      SC27XX_ADC_IRQ_CLR);
>   	if (ret)
>   		goto disable_adc;
>   
> @@ -537,8 +537,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>   	if (ret)
>   		goto disable_adc;
>   
> -	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> -				 SC27XX_ADC_CHN_RUN, SC27XX_ADC_CHN_RUN);
> +	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> +			      SC27XX_ADC_CHN_RUN);
>   	if (ret)
>   		goto disable_adc;
>   
> @@ -559,8 +559,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>   	value &= SC27XX_ADC_DATA_MASK;
>   
>   disable_adc:
> -	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> -			   SC27XX_ADC_EN, 0);
> +	regmap_clear_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> +			  SC27XX_ADC_EN);
>   regulator_restore:
>   	if ((data->var_data->set_volref) && (channel == 30 || channel == 31)) {
>   		ret_volref = regulator_set_voltage(data->volref,
> @@ -765,15 +765,14 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>   {
>   	int ret;
>   
> -	ret = regmap_update_bits(data->regmap, data->var_data->module_en,
> -				 SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
> +	ret = regmap_set_bits(data->regmap, data->var_data->module_en,
> +			      SC27XX_MODULE_ADC_EN);
>   	if (ret)
>   		return ret;
>   
>   	/* Enable ADC work clock and controller clock */
> -	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
> -				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
> -				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
> +	ret = regmap_set_bits(data->regmap, data->var_data->clk_en,
> +			      SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
>   	if (ret)
>   		goto disable_adc;
>   
> @@ -789,11 +788,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>   	return 0;
>   
>   disable_clk:
> -	regmap_update_bits(data->regmap, data->var_data->clk_en,
> -			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
> +	regmap_clear_bits(data->regmap, data->var_data->clk_en,
> +			  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
>   disable_adc:
> -	regmap_update_bits(data->regmap, data->var_data->module_en,
> -			   SC27XX_MODULE_ADC_EN, 0);
> +	regmap_clear_bits(data->regmap, data->var_data->module_en,
> +			  SC27XX_MODULE_ADC_EN);
>   
>   	return ret;
>   }
> @@ -803,11 +802,11 @@ static void sc27xx_adc_disable(void *_data)
>   	struct sc27xx_adc_data *data = _data;
>   
>   	/* Disable ADC work clock and controller clock */
> -	regmap_update_bits(data->regmap, data->var_data->clk_en,
> -			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
> +	regmap_clear_bits(data->regmap, data->var_data->clk_en,
> +			  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
>   
> -	regmap_update_bits(data->regmap, data->var_data->module_en,
> -			   SC27XX_MODULE_ADC_EN, 0);
> +	regmap_clear_bits(data->regmap, data->var_data->module_en,
> +			  SC27XX_MODULE_ADC_EN);
>   }
>   
>   static const struct sc27xx_adc_variant_data sc2731_data = {

For SPRD sc27xx parts, looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

