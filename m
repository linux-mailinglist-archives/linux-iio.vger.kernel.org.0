Return-Path: <linux-iio+bounces-8007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133ED93E89D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B5C28109A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79815028C;
	Sun, 28 Jul 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePQhV2xT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633AA35;
	Sun, 28 Jul 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722184563; cv=none; b=RkR9NexDi6NRf4pob57ynXVZKM5KVuT8acj7vI5/OyKpVCBMKIQRsAH4oywdLIHqZEe+lkNYZOYZICCv1Psu4X4uNX/O8ZqNLF+eE3DxI3t5JOS7c1YkQrbMnOfzqCa41AU4vF1IX9/K1Ulu3dT9K89JZzln+OVfSeXZkqu0T4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722184563; c=relaxed/simple;
	bh=RjYUFyDSWih1+7ZYe0EDKRmdYIzJTCIJE73Pl+aBQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcfCrwJKa36qPj6rdi7edlMmvuVlRtGCUTGC0IjjvrLH6lJcvcA8/FfHC1Je6m3m9AP7Z2zvWSWYy85FZDnYMnLDVA5oah1fFPhC9uOw8+aPIHpYB3qEpLMYVi7+OdRx9rE/eSeUrDOxEI7TqZjVeajHlJz3umgLQ28hkMyPYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePQhV2xT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7F2C4AF10;
	Sun, 28 Jul 2024 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722184562;
	bh=RjYUFyDSWih1+7ZYe0EDKRmdYIzJTCIJE73Pl+aBQsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePQhV2xTrK4yqdTeSIq7AsNrSICxpcqlyaJO+r9DRJfZ2Kkx/UmNBajrxPqBf+NNM
	 lZ5nnqevAGC7SbCaReJiOyFFxjuznO5zSVns/yWwJ0FO1Qe8s56eQ3djpqHYBeG/mN
	 Q8ubI+DNX5m8xHXxb4y8/ASHcCUi4ugp3vEFzXqm5O3SWoGTQ1RzPsTMa+sFxsq49W
	 KSirP5r8SmKULy9gA4PudcL0tUHezezXF5eAGvwMqjodZeZpSU3e4NqaLnj8IXG66E
	 e+GwEvcg9AzUtgMYXNrfovJE8s8kGvAqRF47zyFNq+oBxEiWR5h4fxkb1mLynuLQSJ
	 pRNc6QUxBRL3A==
Date: Sun, 28 Jul 2024 17:35:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/5] ad7380: enable sequencer for single-ended parts
Message-ID: <20240728173553.2d6ac4d0@jic23-huawei>
In-Reply-To: <20240726-ad7380-add-single-ended-chips-v1-4-2d628b60ccd1@baylibre.com>
References: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
	<20240726-ad7380-add-single-ended-chips-v1-4-2d628b60ccd1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 17:20:09 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> ad7386/7/8(-4) single-ended parts have a 2:1 mux in front of each ADC.
> 
> From an IIO point of view, all inputs are exported, i.e ad7386/7/8
> export 4 channels and ad7386-4/7-4/8-4 export 8 channels. First inputs
> of muxes correspond to the first half of IIO channels (i.e 0-1 or 0-3)
> and second inputs correspond to second half (i.e 2-3 or 4-7)
> 
> Currently, the driver supports only sampling first half OR second half of
> the IIO channels. To enable sampling all channels simultaneously, these
> parts have an internal sequencer that automatically cycle through the
> mux entries.
> 
> When enabled, the maximum throughput is divided by two. Moreover, the ADCs
> need additional settling time, so we add an extra CS toggle to correctly
> propagate setting, and an additional spi transfer to read the second
> half.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Hi Julien,

All looks good. Main comment is a suggestion that we add a core
interface to get the index of the active_scan_mask if it is built
from available_scan_masks.  That will avoid the mask matching code
in here.

Implementation for now would be a simple bit of pointer
arithmetic after checking available_scan_masks is set.

Jonathan

> ---
>  drivers/iio/adc/ad7380.c | 164 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 121 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 25d42fff1839..11ed010431cf 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -33,7 +33,7 @@

> @@ -290,16 +291,22 @@ static const unsigned long ad7380_4_channel_scan_masks[] = {
>   *
>   * Since this is simultaneous sampling for AinX0 OR AinX1 we have two separate
>   * scan masks.
> + * When sequencer mode is enabled, chip automatically cycle through

cycles 

> + * AinX0 and AinX1 channels. From an IIO point of view, we ca enable all
> + * channels, at the cost of an extra read, thus dividing the maximum rate by
> + * two.
>   */

...

>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
>  	 * to live in their own cache lines.
> @@ -609,33 +619,47 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
>  static void ad7380_update_xfers(struct ad7380_state *st,
>  				const struct iio_scan_type *scan_type)
>  {
> -	/*
> -	 * First xfer only triggers conversion and has to be long enough for
> -	 * all conversions to complete, which can be multiple conversion in the
> -	 * case of oversampling. Technically T_CONVERT_X_NS is lower for some
> -	 * chips, but we use the maximum value for simplicity for now.
> -	 */
> -	if (st->oversampling_ratio > 1)
> -		st->xfer[0].delay.value = T_CONVERT_0_NS + T_CONVERT_X_NS *
> -						(st->oversampling_ratio - 1);
> -	else
> -		st->xfer[0].delay.value = T_CONVERT_NS;
> -
> -	st->xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> +	struct spi_transfer *xfer = st->seq ? st->seq_xfer : st->normal_xfer;
> +	unsigned int t_convert = T_CONVERT_NS;
>  
>  	/*
> -	 * Second xfer reads all channels. Data size depends on if resolution
> -	 * boost is enabled or not.
> +	 * In the case of oversampling, conversion time is higher than in normal
> +	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
> +	 * the maximum value for simplicity for now.
>  	 */
> -	st->xfer[1].bits_per_word = scan_type->realbits;
> -	st->xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
> -			  st->chip_info->num_simult_channels;
> +	if (st->oversampling_ratio > 1)
> +		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
> +			(st->oversampling_ratio - 1);
> +
> +	if (st->seq) {
> +		xfer[0].delay.value = xfer[1].delay.value = t_convert;
> +		xfer[0].delay.unit = xfer[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> +		xfer[2].bits_per_word = xfer[3].bits_per_word =
> +			scan_type->realbits;
> +		xfer[2].len = xfer[3].len =
> +			BITS_TO_BYTES(scan_type->storagebits) *
> +			st->chip_info->num_simult_channels;
> +		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
> +		/* Additional delay required here when oversampling is enabled */
> +		if (st->oversampling_ratio > 1)
> +			xfer[2].delay.value = t_convert;
> +		else
> +			xfer[2].delay.value = 0;
> +		xfer[2].delay.unit = SPI_DELAY_UNIT_NSECS;
> +	} else {
> +		xfer[0].delay.value = t_convert;
> +		xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> +		xfer[1].bits_per_word = scan_type->realbits;
> +		xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
> +			st->chip_info->num_simult_channels;
> +	}
>  }
>  
>  static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7380_state *st = iio_priv(indio_dev);
>  	const struct iio_scan_type *scan_type;
> +	struct spi_message *msg = &st->normal_msg;
>  
>  	/*
>  	 * Currently, we always read all channels at the same time. The scan_type
> @@ -646,34 +670,62 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
>  		return PTR_ERR(scan_type);
>  
>  	if (st->chip_info->has_mux) {
> -		unsigned int num_simult_channels = st->chip_info->num_simult_channels;
> +		unsigned int num_simult_channels =
> +			st->chip_info->num_simult_channels;

Unrelated change. Push this back to the earlier patch (or leave it alone - whether
it matters for readability is debatable anyway, so I think this is fine either way).

>  		unsigned long active_scan_mask = *indio_dev->active_scan_mask;
>  		unsigned int ch = 0;
>  		int ret;
>  
>  		/*
>  		 * Depending on the requested scan_mask and current state,
> -		 * we need to change CH bit to sample correct data.
> +		 * we need to either change CH bit, or enable sequencer mode
> +		 * to sample correct data.
> +		 * Sequencer mode is enabled if active mask corresponds to all
> +		 * IIO channels enabled. Otherwise, CH bit is set.
>  		 */
> -		if (active_scan_mask == GENMASK(2 * num_simult_channels - 1,
> -						num_simult_channels))
> -			ch = 1;
> +		if (active_scan_mask == GENMASK(2 * num_simult_channels - 1, 0)) {

Whilst it's an implementation detail that you can (IIRC) just compare the active_scan_mask
address with that of your available_scan_masks array entries, maybe it's worth providing
an interface that gets the index of that array?

int iio_active_scan_mask_index(struct iio_dev *)
that returns an error if available_scan_masks isn't set.

We know the active_scan_mask will always be selected from the available ones
so this interface should be fine even if we change how they are handled internally
in the future.

That would then make all these matches simpler.

> +			ret = regmap_update_bits(st->regmap,
> +						 AD7380_REG_ADDR_CONFIG1,
> +						 AD7380_CONFIG1_SEQ,
> +						 FIELD_PREP(AD7380_CONFIG1_SEQ, 1));
> +			msg = &st->seq_msg;
> +			st->seq = true;
> +		} else {
> +			if (active_scan_mask == GENMASK(2 * num_simult_channels - 1,
> +							num_simult_channels))
> +				ch = 1;
> +
> +			ret = ad7380_set_ch(st, ch);
> +		}
>  
> -		ret = ad7380_set_ch(st, ch);
>  		if (ret)
>  			return ret;

I'd just duplicate this if (ret) check as the two calls are very different so to
me this doesn't make logical sense (even if it works).

>  	}
>  
>  	ad7380_update_xfers(st, scan_type);
>  
> -	return spi_optimize_message(st->spi, &st->msg);
> +	return spi_optimize_message(st->spi, msg);
>  }

