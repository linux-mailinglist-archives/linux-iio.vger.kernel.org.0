Return-Path: <linux-iio+bounces-13474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EA9F204B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05587A0FB2
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04881A4AB3;
	Sat, 14 Dec 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjijPWef"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54130EBE;
	Sat, 14 Dec 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734200810; cv=none; b=kIOnTMtag/R3KKk2HjqB1VDU8M1UaPBW2+a0jdf4K3k4U8LPKbjxokB4hSFEFktQiTz7FW+J26zrUEvxiG+oAmjU39zEcMz2k2qGTXkd3624xMnoakuK25h9hdy4nf4aiBBWSZDZ4W9ETuAm2iT5w0nVCg8znsDdLRjEDVmIsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734200810; c=relaxed/simple;
	bh=yGbb+UmEpUS3I/z5uhSvfUZe9G4wyHQQcxxjKJgsLO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGscfnzw8QpSbKlpEE4LtV8MNZdHpDiSn4Ri8dqrvQkRZSq6vF4cTYdYM8sIQfVuuo3lIVKRTKgQWRWGrF+DVmoNz6MQ151+2iFS/+ozwlpQqqwblSqgO4h5elfqQWxBM1HTOGPczFth4BwTK9GQKmt6gM3y+jk4czP+yh4z0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjijPWef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0034C4CED1;
	Sat, 14 Dec 2024 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734200809;
	bh=yGbb+UmEpUS3I/z5uhSvfUZe9G4wyHQQcxxjKJgsLO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pjijPWeflDLjiUNdDC/1KGbMempHYH2RhorhnDVqoVm7SZXnA0BvzA5dxUumZuABn
	 WOwlyPXarpRZgG9ND1vUjr4d+qU6TlcddfUNnNVV7+BnAMoF9KCYzQlYZT7WF/Q8wi
	 w8cb8nZue33/77reiyr/aLwFndHUQtVpvFDnNlF/Pj1eCCqceiyuo2dz8ezFGDvECs
	 FIVh0OdVbfISSyBSYdya67hTYxKngfbnCZoVi4WYYGBRQTHiqn0+jEeNts6hRcPFrX
	 w8iITb5Q06NjEQJMXwR8Uh5Xjm7PMISxDCAvUHdIMx3K3/2t8OjVMVEtPxXkENx93J
	 1Etc5xZZ6CsBg==
Date: Sat, 14 Dec 2024 18:26:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH v2 1/9] iio: adc: ad7606: Fix hardcoded offset in the
 ADC channels
Message-ID: <20241214182640.6ee2c085@jic23-huawei>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-1-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
	<20241210-ad7606_add_iio_backend_software_mode-v2-1-6619c3e50d81@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:46:41 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> When introducing num_adc_channels, I overlooked some new functions
> created in a meanwhile that had also the hardcoded offset. This commit
> adds the new logic to these functions.
> 
> Fixes: 7a671afeb592 ("iio: adc: ad7606: Introduce num_adc_channels")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Applied this patch to the fixes-togreg branch of iio.git.

That may well stall the rest for a while though whilst that works its
way around into the upstream for the togreg branch.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 48 ++++++++++++++++++++++++++++--------------------
>  drivers/iio/adc/ad7606.h |  2 +-
>  2 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index e35d55d03d86..d8e3c7a43678 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -175,17 +175,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
>  	AD7606_CHANNEL(15, 16),
>  };
>  
> -static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					  struct iio_chan_spec *chan, int ch);
> -static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					  struct iio_chan_spec *chan, int ch);
> -static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					 struct iio_chan_spec *chan, int ch);
> -static int ad7607_chan_scale_setup(struct ad7606_state *st,
> +static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch);
> -static int ad7608_chan_scale_setup(struct ad7606_state *st,
> +static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch);
> -static int ad7609_chan_scale_setup(struct ad7606_state *st,
> +static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch);
>  
>  const struct ad7606_chip_info ad7605_4_info = {
> @@ -323,9 +323,10 @@ int ad7606_reset(struct ad7606_state *st)
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_reset, "IIO_AD7606");
>  
> -static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					 struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  
>  	if (!st->sw_mode_en) {
> @@ -345,10 +346,12 @@ static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
>  	return 0;
>  }
>  
> -static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
> +static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
>  				  bool *bipolar, bool *differential)
>  {
> -	unsigned int num_channels = st->chip_info->num_channels - 1;
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int num_channels = st->chip_info->num_adc_channels;
> +	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
>  	struct device *dev = st->dev;
>  	int ret;
>  
> @@ -364,7 +367,7 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
>  			continue;
>  
>  		/* channel number (here) is from 1 to num_channels */
> -		if (reg == 0 || reg > num_channels) {
> +		if (reg < offset || reg > num_channels) {
>  			dev_warn(dev,
>  				 "Invalid channel number (ignoring): %d\n", reg);
>  			continue;
> @@ -399,9 +402,10 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
>  	return 0;
>  }
>  
> -static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					  struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  	bool bipolar, differential;
>  	int ret;
> @@ -413,7 +417,7 @@ static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
>  		return 0;
>  	}
>  
> -	ret = ad7606_get_chan_config(st, ch, &bipolar, &differential);
> +	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
>  	if (ret)
>  		return ret;
>  
> @@ -455,9 +459,10 @@ static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
>  	return 0;
>  }
>  
> -static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					  struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  	bool bipolar, differential;
>  	int ret;
> @@ -469,7 +474,7 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
>  		return 0;
>  	}
>  
> -	ret = ad7606_get_chan_config(st, ch, &bipolar, &differential);
> +	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
>  	if (ret)
>  		return ret;
>  
> @@ -512,9 +517,10 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
>  	return 0;
>  }
>  
> -static int ad7607_chan_scale_setup(struct ad7606_state *st,
> +static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  
>  	cs->range = 0;
> @@ -523,9 +529,10 @@ static int ad7607_chan_scale_setup(struct ad7606_state *st,
>  	return 0;
>  }
>  
> -static int ad7608_chan_scale_setup(struct ad7606_state *st,
> +static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  
>  	cs->range = 0;
> @@ -534,9 +541,10 @@ static int ad7608_chan_scale_setup(struct ad7606_state *st,
>  	return 0;
>  }
>  
> -static int ad7609_chan_scale_setup(struct ad7606_state *st,
> +static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  
>  	cs->range = 0;
> @@ -1146,8 +1154,8 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
>  
>  static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
>  {
> -	unsigned int num_channels = indio_dev->num_channels - 1;
>  	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
>  	struct iio_chan_spec *chans;
>  	size_t size;
>  	int ch, ret;
> @@ -1161,8 +1169,8 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
>  	memcpy(chans, indio_dev->channels, size);
>  	indio_dev->channels = chans;
>  
> -	for (ch = 0; ch < num_channels; ch++) {
> -		ret = st->chip_info->scale_setup_cb(st, &chans[ch + 1], ch);
> +	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
> +		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset], ch);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 998814a92b82..8778ffe515b3 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -69,7 +69,7 @@
>  
>  struct ad7606_state;
>  
> -typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
> +typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
>  				       struct iio_chan_spec *chan, int ch);
>  
>  /**
> 


