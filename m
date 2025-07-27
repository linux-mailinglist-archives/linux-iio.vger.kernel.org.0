Return-Path: <linux-iio+bounces-22035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE0B12F6D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD51898B31
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D001207A22;
	Sun, 27 Jul 2025 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9+upJQd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8563CF;
	Sun, 27 Jul 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753618912; cv=none; b=abfvrWeIAV2pi7DYEIY81481zhl6qCuXqn/6NkEGAzwHubCboeph1dIelAD3Kj6ppaJB2vGcRftGkL4nOtHYfgSDU5dQoQmJRWswwnAIXIsxfdKq3c5hmaRFVHUjGMV+wMspc6/kI4xWlt9cw3G953BoIy6RUParfIEoUb2nSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753618912; c=relaxed/simple;
	bh=xFOPvEY9uVWfcWY5moknpMDeQYNDdwyXwi2cmpvAHHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIDxzzfdhinK6ArD7WUdAObSseDorIacGf1ITfooPV4At0kveybObvPbfoymFKqmBNyI09aOWavb9t9tSqS7L6ENm2bDcemMmPHVGnapI3Rxtr3N+ZBckY2pYnmbhOGT9iqMNUw5CKmsljcLrGF1cL2Oy7uqr9wD+RFmRdOdGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9+upJQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366CFC4CEEB;
	Sun, 27 Jul 2025 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753618912;
	bh=xFOPvEY9uVWfcWY5moknpMDeQYNDdwyXwi2cmpvAHHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9+upJQd+tJizle1xoE4tWPC9arP2bh0FlcAntruETtfaOBbZDGTNIQv+VZazeyEl
	 pCsh73Os7TqsKOqGuTXSoYnPTugJiX+12WS6mwULjQmxSddPLxS6LjakvNFBiqXA76
	 URB9keKDcytcO0MyqyaxpWIxEoZVMLQRznrdPL4LraHmOdiiQIJdcLEZbq/VE1Xtsd
	 Vqw11Iz+6zyauoUKDNyXQJ4YGs8utgQm0QDZbq7HZQFNzM+0wiABa2uY2YKJRauJdB
	 gPkITEeolp/d5iJrZPCkEJO3+VweqZfSKJXv+hGVLV8gKYqfyU8NBAny4Xwl36DLE7
	 9kz+/VWbCYHDA==
Date: Sun, 27 Jul 2025 13:21:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad7124: do not require mclk
Message-ID: <20250727132143.35a44547@jic23-huawei>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-2-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
	<20250724-iio-adc-ad7124-proper-clock-support-v1-2-88f35db2fcaf@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 18:25:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Make the "mclk" clock optional in the ad7124 driver. The MCLK is an
> internal counter on the ADC, so it is not something that should be
> coming from the devicetree. However, existing users may be using this
> to essentially select the power mode of the ADC from the devicetree.
> In order to not break those users, we have to keep the existing "mclk"
> handling, but now it is optional.
> 
> Now, when the "mclk" clock is omitted from the devicetree, the driver
> will default to the full power mode. Support for an external clock
> and dynamic power mode switching can be added later if needed.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7124.c | 61 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9808df2e92424283a86e9c105492c7447d071e44..f587574e8a24040540a470e13fed412ec9c81971 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -174,7 +174,6 @@ struct ad7124_state {
>  	struct ad_sigma_delta sd;
>  	struct ad7124_channel *channels;
>  	struct regulator *vref[4];
> -	struct clk *mclk;
>  	unsigned int adc_control;
>  	unsigned int num_channels;
>  	struct mutex cfgs_lock; /* lock for configs access */
> @@ -254,7 +253,9 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>  {
>  	unsigned int fclk, odr_sel_bits;
>  
> -	fclk = clk_get_rate(st->mclk);
> +	fclk = ad7124_master_clk_freq_hz[FIELD_GET(
> +		AD7124_ADC_CONTROL_POWER_MODE, st->adc_control)];
> +

I'm not keen on that wrap point.

	fclk = ad7124_master_clk_freq_hz[FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE,
						   st->adc_control)];

maybe?
>  	/*
>  	 * FS[10:0] = fCLK / (fADC x 32) where:
>  	 * fADC is the output data rate
> @@ -1111,21 +1112,49 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>  static int ad7124_setup(struct ad7124_state *st)
>  {
>  	struct device *dev = &st->sd.spi->dev;
> -	unsigned int fclk, power_mode;
> +	unsigned int power_mode;
> +	struct clk *mclk;
>  	int i, ret;
>  
> -	fclk = clk_get_rate(st->mclk);
> -	if (!fclk)
> -		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
> +	/*
> +	 * Always use full power mode for max performance. If needed, the driver
> +	 * could be adapted to use a dynamic power mode based on the requested
> +	 * output data rate.
> +	 */
> +	power_mode = AD7124_ADC_CONTROL_POWER_MODE_FULL;
>  
> -	/* The power mode changes the master clock frequency */
> -	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
> -					ARRAY_SIZE(ad7124_master_clk_freq_hz),
> -					fclk);
> -	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
> -		ret = clk_set_rate(st->mclk, fclk);
> -		if (ret)
> -			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
> +	/*
> +	 * HACK: This "mclk" business is needed for backwards compatibility with

I'd drop the HACK bit of this. Whilst I understand the spirit of the comment
that term tends to make people try to 'fix' things ;)

> +	 * old devicetrees that specified a fake clock named "mclk" to select
> +	 * the power mode.
> +	 */
> +	mclk = devm_clk_get_optional_enabled(dev, "mclk");
> +	if (IS_ERR(mclk))
> +		return dev_err_probe(dev, PTR_ERR(mclk), "Failed to get mclk\n");
> +
> +	if (mclk) {
> +		unsigned long mclk_hz;
> +
> +		mclk_hz = clk_get_rate(mclk);
> +		if (!mclk_hz)
> +			return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
> +
> +		/*
> +		 * This logic is a bit backwards, which is why it is considered
> +		 * a hack and is only here for backwards compatibility. The
> +		 * driver should be able to set the power mode as it sees fit
> +		 * and the f_clk/mclk rate should be dynamic accordingly. But
> +		 * here, we are selecting a fixed power mode based on the given
> +		 * "mclk" rate.

My assumption is that someone had a board with a fixed rate clock on this pin.
So it might not be possible to have the driver do that adjustment.
If anyone ever adds that support, we'll have to be careful about handling fixed
clocks.

This looks fine though.

> +		 */
> +		power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
> +			ARRAY_SIZE(ad7124_master_clk_freq_hz), mclk_hz);
> +
> +		if (mclk_hz != ad7124_master_clk_freq_hz[power_mode]) {
> +			ret = clk_set_rate(mclk, mclk_hz);
> +			if (ret)
> +				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
> +		}
>  	}
>  
>  	/* Set the power mode */
> @@ -1303,10 +1332,6 @@ static int ad7124_probe(struct spi_device *spi)
>  			return dev_err_probe(dev, ret, "Failed to register disable handler for regulator #%d\n", i);
>  	}
>  
> -	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
> -	if (IS_ERR(st->mclk))
> -		return dev_err_probe(dev, PTR_ERR(st->mclk), "Failed to get mclk\n");
> -
>  	ret = ad7124_soft_reset(st);
>  	if (ret < 0)
>  		return ret;
> 


