Return-Path: <linux-iio+bounces-5121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB38C957D
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4DF1F21C40
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E064DA1F;
	Sun, 19 May 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzst70TO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF94D108;
	Sun, 19 May 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716138842; cv=none; b=Ktvw7jRp0c0I9VoKNlZKKxEXyzIqhI5MertgvKP1F/gv7efd6Dh+bqBrHqHMlXS7HwU4MRUrlorjke5nZPEy8Cs8IemNduaREemTSkW8/RxilDXXzmD+fQzHG9d9vJbjYf7rtseiJCMvjloWagA3GdmzdkM3hCkjnr+8+Of65QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716138842; c=relaxed/simple;
	bh=rzQUip3ttnHtdiXBV8Xar/0z+hrxGmJ12YoZERJc1o8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S71iEg6/IZPb9MYbHGT7u3hAyWq12bUEzIgSuCXkTy2hgq9LQumKgg4r4wyVgK7KztnLHzz9zedf8JzfhSZKWwOpe+iU2Y+MAYKC2NQNNa9TGZ7Xho8gNTFjIbMuksYkt8qrUY5yk83svj7fGn7ocF/c22OeygThwR8R3+nzhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzst70TO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37739C32781;
	Sun, 19 May 2024 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716138842;
	bh=rzQUip3ttnHtdiXBV8Xar/0z+hrxGmJ12YoZERJc1o8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzst70TOK9rMnMkhl4Baw4PRnR93itFBWpkQ1m7a2l+M+UGgahpjYyWc0h87VDjdk
	 acfpcMYbFGKkXT3vQlOY3cQw6gNBuKZM93Wi9v/4I5tRo+F1+dVEiDOgemI7BTLxQ/
	 ttMwwsGHgkB/t6IWlv5yi3iIilWpnVHAb9Mx/YnIkrIvPfCJ4MF8DBkkIYiM0XuyKZ
	 eTQGNAkUU06cqMk1xofz3kIpEdqhFpmSO69UK1kQH9uTRnK9xVKtGZ+DZ/10b/ip6o
	 L2cl1mE3vS7XgAs1WZHgzCalGckiAPHmiDQBwxgKXetCiHZDxy78zez9sS8SnCeUfM
	 fZoykaOLzSm7g==
Date: Sun, 19 May 2024 18:13:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v2 8/9] iio: adc: ad7173: Add support for AD411x devices
Message-ID: <20240519181349.0209271c@jic23-huawei>
In-Reply-To: <20240514-ad4111-v2-8-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
	<20240514-ad4111-v2-8-29be6a55efb5@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 10:22:53 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> 
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
> 
> This family of ADCs integrates an analog front end suitable for processing
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
> 
> - All ADCs have inputs with a precision voltage divider with a division
>   ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>   shunt resistor.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
A couple of trivial things inline. Otherwise lgtm

> @@ -1058,17 +1296,26 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan->scan_index = chan_index;
>  		chan->channel = ain[0];
>  		chan->channel2 = ain[1];
> -		chan->differential = true;
> -
>  		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>  		chan_st_priv->chan_reg = chan_index;
> -		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
> -
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> +
>  		if (chan_st_priv->cfg.bipolar)
>  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
>  
> +		if (is_current_chan)
> +			chan->type = IIO_CURRENT;
> +		else
> +			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> +
> +		ret = fwnode_property_match_property_string(child,
> +							    "adi,channel-type",
> +							    ad7173_channel_types,
> +							    ARRAY_SIZE(ad7173_channel_types));
> +		chan->differential = (ret < 0 || ret == AD7173_CHAN_DIFFERENTIAL)
> +					? true : false;

That's not a boolean. So better to set 1 or 0.




> +MODULE_DESCRIPTION("Analog Devices AD717x and AD411x ADC driver");

I'm scared of wildcards even in descriptive fields as they often end up covering
something unintended. I'd just go with 'and similar'.

>  MODULE_LICENSE("GPL");
> 


