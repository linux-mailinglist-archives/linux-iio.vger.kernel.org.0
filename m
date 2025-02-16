Return-Path: <linux-iio+bounces-15586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B73A375CC
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C27A312C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7B19AA5D;
	Sun, 16 Feb 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEzH0AId"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FA182D9;
	Sun, 16 Feb 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723524; cv=none; b=GgEnNmmMN8GyNschI3mBP2W0OMOb/C5mRJoUyLmxAFsXZVmy04gtTId5khAIcgeoTIs4uZrSFFU9HxSaWbw43prNfNsrGTtEIa83b1lBThXQqDDyw0wAA8pVgzgOB4fNdVcoRrT+G4ScasZ4mJsgbPETQsM6QpizMkHAm9POfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723524; c=relaxed/simple;
	bh=3CwtK3fLSQ/dY2NyXOddd0G44hR6QIDrrjcaHt9gpmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCuZ1DOfiXX5wxmwuC5/kROMKNCizX0/PriGL6Pk5sE4rmFBdNOdEs/x++BM4JTPRDQZwpsFXgCVi6t0Sc9xvJztS4Q0KWSe6QNOqwuK3kSC6gfydw41FaUXv6jMmqAlPYjFl16lKhSiyIWpC27MH3DDOBgAY39/yvEiFV05uzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEzH0AId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8600C4CEDD;
	Sun, 16 Feb 2025 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739723523;
	bh=3CwtK3fLSQ/dY2NyXOddd0G44hR6QIDrrjcaHt9gpmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEzH0AIdbwrse6EpMniEM69i9pIzEIcdbF3bX444xmeHc1Phs4wXqd5zwBBbCH8Ep
	 SYGssGF9gyE5VgaKDwHBZykHFCJnUMT8wmar1HrX/bZZ/u5qEMumOT06wh43/0yjB4
	 EC5GQYQmf3gdATkD1i4vLq+mTwZDcf88DJUYeClkhrY/h6XaceukcnONHsbC/ACXWe
	 ER7FVOok1zzOwhQaHS/2LlgC6S2MxkVc9Xqk9R5UFcAqcRmrV7vGpaievATnGBb1xm
	 FxysbDf10JlqCYEglQEKZUavlsIO3efQIMjRJWUISI4+T+1N+47qMyhR2CX6blhNGc
	 pqrBv4Ee6tkHw==
Date: Sun, 16 Feb 2025 16:31:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>, Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH RESEND v3 16/17] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250216163153.55a1ae97@jic23-huawei>
In-Reply-To: <2c3ce1701545e435238605342397e45657a0fb2a.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<2c3ce1701545e435238605342397e45657a0fb2a.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:18:59 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features.
> 
> Co-developed-by: Pop Paul <paul.pop@analog.com>
> Signed-off-by: Pop Paul <paul.pop@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
As below. We should aim to 'pre bake' the value arrays for
get_available() to avoid the potential race conditions of a consumer
seeing a partly updated set a parameters change.

Better to see a consistent but stale one.

Jonathan

> ---
> v3 Changes:
> * removed unsed variables.
> * included sinc3+rej60 filter type.
> * oversampling_ratio moved to info_mask_shared_by_type.
> * reordered functions to avoid foward declaration.
> * simplified regmap writes.
> * Removed locking.
> * replaced some helper functions for direct regmap_update_bits
>   calls.
> * Addressed other nits.
> 
> v2 Changes:
> * Decimation_rate attribute replaced for oversampling_ratio.
> ---
>  drivers/iio/adc/ad7768-1.c | 359 ++++++++++++++++++++++++++++++-------
>  1 file changed, 290 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 8aea38c154fe..18f1ea0bf66d 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c

> +
> +/* Decimation Rate range for each filter type */
> +static const int ad7768_dec_rate_range[][3] = {
> +	[AD7768_FILTER_SINC5] = { 8, 8, 1024 },
> +	[AD7768_FILTER_SINC3] = { 32, 32, 163840 },
> +	[AD7768_FILTER_WIDEBAND] = { 32, 32, 1024 },
> +	[AD7768_FILTER_SINC3_REJ60] = { 32, 32, 163840 },
> +};
> +
> +/*
> + * The AD7768-1 supports three primary filter types:
> + * Sinc5, Sinc3, and Wideband.
> + * However, the filter register values can also encode
wrap at 80 chars.
> + * additional parameters such as decimation rates and
> + * 60Hz rejection. This utility function separates the
> + * filter type from these parameters.
> + */

>  
> -	return 0;
> +static int ad7768_get_fil_type_attr(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int mode;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
> +
> +	/*
> +	 * From the register value, get the corresponding
> +	 * filter type.

Very short line wrap.  Stick to 80 chars.

> +	 */
> +	return ad7768_filter_regval_to_type[mode];
>  }

>  
> @@ -619,16 +798,25 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
>  			     long info)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> -	int i;
> +	int i, freq_filtered, len = 0;
>  
>  	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = (int *)ad7768_dec_rate_range[st->filter_type];
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
> -			st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
> -								   ad7768_clk_config[i].clk_div);
> +		freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);

Ah. So now it is dynamic.  This hits the previously mentioned race.
A consumer can be holding a copy of this and acting on it whilst holding no
locks on this device - thus it can see a mixture of values as this update
occurs. To avoid that you need to precompute the combinations +
store the lot in arrays.  Then this code should simply be selecting the arrays.
A consumer holding a stale one will get a consistent (if wrong) set.

The < 50 check makes this more complex than normal but they are still static
choices I think as long as the input clock doesn't change.

> +		for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> +			st->samp_freq_avail[len] = DIV_ROUND_CLOSEST(freq_filtered,
> +								     ad7768_mclk_div_rates[i]);
> +			/* Sampling frequency cannot be lower than the minimum of 50 SPS */
> +			if (st->samp_freq_avail[len] >= 50)
> +				len++;
> +		}
>  
>  		*vals = (int *)st->samp_freq_avail;
> -		*length = ARRAY_SIZE(ad7768_clk_config);
> +		*length = len;
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  	default:
> @@ -636,20 +824,45 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int ad7768_write_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val, int val2, long info)
> +static int __ad7768_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return ad7768_set_freq(st, val);
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
> +		if (ret)
> +			return ret;
> +
> +		/* Update sampling frequency */
> +		return ad7768_set_freq(st, st->samp_freq);
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int ad7768_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
Previously we didn't claim this to set the sampling frequency.
That change looks like a potential ABI issue.  I'm fine with it
if we should always have this protected.

If you are just using it to avoid racing between setting sampling
frequency and oversampling ratio then don't use that, use a local
lock where the scope can be clearly described.

> +	if (ret)
> +		return ret;
> +
> +	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}

